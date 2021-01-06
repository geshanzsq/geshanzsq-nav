package com.geshanzsq.nav.service.impl;

import com.geshanzsq.common.enums.CommonStatus;
import com.geshanzsq.common.utils.DateUtils;
import com.geshanzsq.nav.domain.NavMenu;
import com.geshanzsq.nav.domain.TreeSelectNav;
import com.geshanzsq.nav.mapper.NavMenuMapper;
import com.geshanzsq.nav.service.IFrontMenuService;
import com.geshanzsq.nav.service.INavMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 导航菜单Service业务层处理
 * 
 * @author geshanzsq
 * @date 2020-07-10
 */
@Service
public class NavMenuServiceImpl implements INavMenuService
{
    @Autowired
    private NavMenuMapper navMenuMapper;
    @Autowired
    private IFrontMenuService frontMenuService;

    /**
     * 查询导航菜单
     * 
     * @param menuId 导航菜单ID
     * @return 导航菜单
     */
    @Override
    public NavMenu selectNavMenuById(Long menuId)
    {
        return navMenuMapper.selectNavMenuById(menuId);
    }

    @Override
    public List<NavMenu> selectNavMenuList(NavMenu navMenu) {
        return navMenuMapper.selectNavMenuList(navMenu);
    }

    /**
     * 查询导航菜单树列表
     * 
     * @param navMenu 导航菜单
     * @return 导航菜单
     */
    @Override
    public List<NavMenu> selectNavMenuTreeList(NavMenu navMenu)
    {
        List<NavMenu> menus = navMenuMapper.selectNavMenuList(navMenu);
        return buildMenuTree(menus);
    }

    /**
     * 新增导航菜单
     * 
     * @param navMenu 导航菜单
     * @return 结果
     */
    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public int insertNavMenu(NavMenu navMenu)
    {
        navMenu.setCreateTime(DateUtils.getNowDate());
        int result = navMenuMapper.insertNavMenu(navMenu);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 修改导航菜单
     * 
     * @param navMenu 导航菜单
     * @return 结果
     */
    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public int updateNavMenu(NavMenu navMenu)
    {
        navMenu.setUpdateTime(DateUtils.getNowDate());
        int result = navMenuMapper.updateNavMenu(navMenu);

        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 批量删除导航菜单
     * 
     * @param menuIds 需要删除的导航菜单ID
     * @return 结果
     */
    @Override
    public int deleteNavMenuByIds(Long[] menuIds)
    {
        int result = navMenuMapper.deleteNavMenuByIds(menuIds);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 删除导航菜单信息
     * 
     * @param menuId 导航菜单ID
     * @return 结果
     */
    @Override
    public int deleteNavMenuById(Long menuId)
    {
        int result = navMenuMapper.deleteNavMenuById(menuId);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 构建前端所需要下拉树结构
     *
     * @param menus 菜单列表
     * @return 下拉树结构列表
     */
    @Override
    public List<TreeSelectNav> buildNavMenuTreeSelect(List<NavMenu> menus) {
        List<NavMenu> menuTree = buildMenuTree(menus);
        return menuTree.stream().map(TreeSelectNav::new).collect(Collectors.toList());
    }


    /**
     * 获取菜单数量
     */
    @Override
    public Integer getCount(Integer status) {
        return navMenuMapper.getCount(status);
    }

    /**
     * 获取该子菜单下最大的排序
     * @param menuId
     * @return
     */
    @Override
    public Integer getMaxChildrenMenuOrderNum(Long menuId) {
        return navMenuMapper.getMaxChildrenMenuOrderNum(menuId);
    }

    /**
     * 通过菜单数组获取菜单信息
     * @param sysMenuIds
     * @return
     */
    @Override
    public List<NavMenu> selectMenuByIds(Long[] sysMenuIds) {
        return navMenuMapper.selectMenuByIds(sysMenuIds, CommonStatus.OK.code);
    }


    /**
     * 构建前端所需要树结构
     *
     * @param menus 菜单列表
     * @return 树结构列表
     */
    private List<NavMenu> buildMenuTree(List<NavMenu> menus) {
        List<NavMenu> returnList = new ArrayList<>();
        for (Iterator<NavMenu> iterator = menus.iterator(); iterator.hasNext();)
        {
            NavMenu t = (NavMenu) iterator.next();
            // 根据传入的某个父节点ID,遍历该父节点的所有子节点
            if (t.getParentId() == 0)
            {
                recursionFn(menus, t);
                returnList.add(t);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = menus;
        }
        return returnList;
    }

    /**
     * 递归列表
     *
     * @param list
     * @param t
     */
    private void recursionFn(List<NavMenu> list, NavMenu t)
    {
        // 得到子节点列表
        List<NavMenu> childList = getChildList(list, t);
        t.setChildren(childList);
        for (NavMenu tChild : childList)
        {
            if (hasChild(list, tChild))
            {
                // 判断是否有子节点
                Iterator<NavMenu> it = childList.iterator();
                while (it.hasNext())
                {
                    NavMenu n = (NavMenu) it.next();
                    recursionFn(list, n);
                }
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<NavMenu> getChildList(List<NavMenu> list, NavMenu t)
    {
        List<NavMenu> tlist = new ArrayList<>();
        Iterator<NavMenu> it = list.iterator();
        while (it.hasNext())
        {
            NavMenu n = (NavMenu) it.next();
            if (n.getParentId().longValue() == t.getMenuId().longValue())
            {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<NavMenu> list, NavMenu t)
    {
        return getChildList(list, t).size() > 0 ? true : false;
    }




}
