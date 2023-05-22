package com.geshanzsq.admin.system.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.api.mapper.SysApiMapper;
import com.geshanzsq.admin.system.api.po.SysApi;
import com.geshanzsq.admin.system.api.po.SysApiMenu;
import com.geshanzsq.admin.system.api.service.SysApiMenuService;
import com.geshanzsq.admin.system.api.service.SysApiService;
import com.geshanzsq.admin.system.api.vo.SysApiVO;
import com.geshanzsq.admin.system.menu.vo.SysMenuAuthApiVO;
import com.geshanzsq.common.core.enums.CommonStatus;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 接口
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Service
public class SysApiServiceImpl extends BaseServiceImpl<SysApiMapper, SysApi> implements SysApiService {

    @Autowired
    private SysApiMapper sysApiMapper;

    @Autowired
    private SysApiMenuService sysApiMenuService;

    /**
     * 通过菜单 id 列表获取接口
     * @param menuIds 菜单 id 列表
     * @return
     */
    @Override
    public List<SysApiVO> getApiByMenuIds(List<Long> menuIds) {
        if (CollectionUtils.isEmpty(menuIds)) {
            return new ArrayList<>();
        }
        return sysApiMapper.getApiByMenuIds(menuIds, CommonStatus.NORMAL.code);
    }

    /**
     * 删除
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeByIds(Long[] ids) {
        if (ids.length == 0) {
            return;
        }
        // 删除接口
        sysApiMapper.deleteBatchIds(Arrays.asList(ids));

        // 删除接口和菜单的对应关系
        LambdaQueryWrapper<SysApiMenu> amWrapper = new LambdaQueryWrapper<>();
        amWrapper.in(SysApiMenu::getApiId, ids);
        sysApiMenuService.remove(amWrapper);
    }

    /**
     * 获取最大排序
     * @param apiCategoryId 分类 id
     */
    @Override
    public Integer getMaxSortByCategoryId(Long apiCategoryId) {
        return sysApiMapper.selectMaxSortByCategoryId(apiCategoryId);
    }

    /**
     * 分配 API
     * @param menuId 菜单 id
     * @param apiIds 接口 ids
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void authApi(Long menuId, List<Long> apiIds) {
        if (menuId == null) {
            return;
        }
        // 先删除对应关系，然后再添加
        LambdaQueryWrapper<SysApiMenu> apiMenuWrapper = new LambdaQueryWrapper<>();
        apiMenuWrapper.eq(SysApiMenu::getMenuId, menuId);
        sysApiMenuService.remove(apiMenuWrapper);

        if (CollectionUtils.isEmpty(apiIds)) {
            return;
        }

        // 添加数据
        List<SysApiMenu> apiMenus = new ArrayList<>();
        for (Long apiId : apiIds) {
            SysApiMenu sysApiMenu = new SysApiMenu();
            sysApiMenu.setMenuId(menuId);
            sysApiMenu.setApiId(apiId);
            apiMenus.add(sysApiMenu);
        }
        sysApiMenuService.saveBatch(apiMenus);
    }

    /**
     * 获取分配的 API 接口
     * @param menuId 菜单 id
     * @return
     */
    @Override
    public List<SysMenuAuthApiVO> getAuthApiByMenuId(Long menuId) {
        return sysApiMapper.selectAuthApiByMenuId(menuId);
    }

}
