package com.geshanzsq.admin.nav.category.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.client.nav.service.ClientNavService;
import com.geshanzsq.admin.nav.category.dto.NavCategoryUpdateDTO;
import com.geshanzsq.admin.nav.category.mapper.NavCategoryMapper;
import com.geshanzsq.admin.nav.category.mapstruct.NavCategoryConverter;
import com.geshanzsq.admin.nav.category.po.NavCategory;
import com.geshanzsq.admin.nav.category.service.NavCategoryService;
import com.geshanzsq.admin.nav.category.vo.NavCategoryTreeVO;
import com.geshanzsq.admin.nav.site.mapper.NavSiteMapper;
import com.geshanzsq.admin.nav.site.po.NavSite;
import com.geshanzsq.common.core.enums.CommonStatus;
import com.geshanzsq.common.core.enums.YesNo;
import com.geshanzsq.common.core.exception.ParamException;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.framework.manager.AsyncManager;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 导航分类
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Service
public class NavCategoryServiceImpl extends BaseServiceImpl<NavCategoryMapper, NavCategory> implements NavCategoryService {

    @Autowired
    private NavCategoryMapper navCategoryMapper;
    @Autowired
    private NavSiteMapper navSiteMapper;

    @Autowired
    private ClientNavService clientNavService;

    /**
     * 获取最大排序
     * @param parentId 上级分类 id
     */
    @Override
    public Integer getMaxSortByParentId(Long parentId) {
        return navCategoryMapper.selectMaxSortByParentId(parentId == null ? 0 : parentId);
    }

    /**
     * 树形
     */
    @Override
    public List<NavCategoryTreeVO> tree() {
        // 获取列表数据
        LambdaQueryWrapper<NavCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(NavCategory::getStatus, YesNo.YES.code);
        wrapper.orderByAsc(NavCategory::getSort);
        List<NavCategory> list = navCategoryMapper.selectList(wrapper);
        List<NavCategoryTreeVO> categoryVOList = NavCategoryConverter.INSTANCE.convertTree(list);

        // 构造树形结构
        return buildTree(categoryVOList, 0L);
    }

    /**
     * 树形
     */
    @Override
    public List<NavCategoryTreeVO> treeByIds(List<Long> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return new ArrayList<>();
        }
        LambdaQueryWrapper<NavCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(NavCategory::getId, ids);
        wrapper.eq(NavCategory::getStatus, CommonStatus.NORMAL.code);

        List<NavCategory> list = navCategoryMapper.selectList(wrapper);
        List<NavCategoryTreeVO> categoryVOList = NavCategoryConverter.INSTANCE.convertTree(list);
        // 构造树形结构
        return buildTree(categoryVOList, 0L);
    }

    /**
     * 更新
     */
    @Override
    public void updateById(NavCategoryUpdateDTO updateDTO) {
        if (updateDTO.getId().equals(updateDTO.getParentId())) {
            throw new ParamException(MessageUtils.message("nav.category.id.parent.id"));
        }
        NavCategory navCategory = NavCategoryConverter.INSTANCE.convert(updateDTO);
        navCategoryMapper.updateById(navCategory);
        // 清除缓存，等后续访问时会自动从数据库获取
        AsyncManager.me().execute(() -> clientNavService.removeCache());
    }

    /**
     * 删除
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void remove(Long id) {
        if (id == null) {
            return;
        }
        // 判断是否有下级分类，如果有，则不能删除
        LambdaQueryWrapper<NavCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(NavCategory::getParentId, id);
        Long count = navCategoryMapper.selectCount(wrapper);
        if (count > 0) {
            throw new ParamException(MessageUtils.message("nav.category.has.child"));
        }

        // 删除分类数据
        navCategoryMapper.deleteById(id);

        // 删除分类和网站对应关系
        LambdaQueryWrapper<NavSite> amWrapper = new LambdaQueryWrapper<>();
        amWrapper.eq(NavSite::getCategoryId, id);
        navSiteMapper.delete(amWrapper);

        // 清除缓存，等后续访问时会自动从数据库获取
        AsyncManager.me().execute(() -> clientNavService.removeCache());
    }

    /**
     * 根据父节点的 id 获取所有子节点
     *
     * @param allList 所有数据
     * @param parentId 传入的父节点 id
     */
    public List<NavCategoryTreeVO> buildTree(List<NavCategoryTreeVO> allList, Long parentId) {
        List<NavCategoryTreeVO> returnList = new ArrayList<>();
        for (NavCategoryTreeVO category : allList) {
            // 根据传入的某个父节点 id，遍历该父节点的所有子节点
            if (parentId != null && parentId.equals(category.getParentId())) {
                // 递归
                recursive(allList, category);
                returnList.add(category);
            }
        }
        return returnList;
    }

    /**
     * 递归列表
     *
     * @param allList
     * @param category 当前分类
     */
    private void recursive(List<NavCategoryTreeVO> allList, NavCategoryTreeVO category) {
        // 得到子节点列表
        List<NavCategoryTreeVO> childList = getChildList(allList, category);
        category.setChildren(childList);
        for (NavCategoryTreeVO tChild : childList) {
            if (hasChild(allList, tChild)) {
                recursive(allList, tChild);
            }
        }
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<NavCategoryTreeVO> allList, NavCategoryTreeVO category) {
        return getChildList(allList, category).size() > 0;
    }

    /**
     * 得到子节点列表
     */
    private List<NavCategoryTreeVO> getChildList(List<NavCategoryTreeVO> allList, NavCategoryTreeVO category) {
        List<NavCategoryTreeVO> childList = new ArrayList<>();
        Iterator<NavCategoryTreeVO> it = allList.iterator();
        while (it.hasNext()) {
            NavCategoryTreeVO child = it.next();
            if (category.getId().equals(child.getParentId())) {
                childList.add(child);
            }
        }
        return childList;
    }

}
