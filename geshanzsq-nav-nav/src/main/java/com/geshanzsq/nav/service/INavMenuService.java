package com.geshanzsq.nav.service;

import com.geshanzsq.nav.domain.NavMenu;
import com.geshanzsq.nav.domain.TreeSelectNav;

import java.util.List;

/**
 * 导航菜单Service接口
 *
 * @author geshanzsq
 * @date 2020-07-10
 */
public interface INavMenuService
{
    /**
     * 查询导航菜单
     *
     * @param menuId 导航菜单ID
     * @return 导航菜单
     */
    public NavMenu selectNavMenuById(Long menuId);
    /**
     * 查询导航菜单列表
     *
     * @param navMenu 导航菜单
     * @return 导航菜单集合
     */
    public List<NavMenu> selectNavMenuList(NavMenu navMenu);


    /**
     * 查询导航菜单树列表
     *
     * @param navMenu 导航菜单
     * @return 导航菜单集合
     */
    public List<NavMenu> selectNavMenuTreeList(NavMenu navMenu);

    /**
     * 新增导航菜单
     *
     * @param navMenu 导航菜单
     * @return 结果
     */
    public int insertNavMenu(NavMenu navMenu);

    /**
     * 修改导航菜单
     *
     * @param navMenu 导航菜单
     * @return 结果
     */
    public int updateNavMenu(NavMenu navMenu);

    /**
     * 批量删除导航菜单
     *
     * @param menuIds 需要删除的导航菜单ID
     * @return 结果
     */
    public int deleteNavMenuByIds(Long[] menuIds);

    /**
     * 删除导航菜单信息
     *
     * @param MenuId 导航菜单ID
     * @return 结果
     */
    public int deleteNavMenuById(Long MenuId);

    /**
     * 构建前端所需要下拉树结构
     *
     * @param menus 菜单列表
     * @return 下拉树结构列表
     */
    public List<TreeSelectNav> buildNavMenuTreeSelect(List<NavMenu> menus);

    /**
     * 获取菜单数量
     */
    Integer getCount(Integer status);

    /**
     * 获取该子菜单下最大的排序
     * @param menuId
     * @return
     */
    Integer getMaxChildrenMenuOrderNum(Long menuId);

    /**
     * 通过菜单数组获取菜单信息
     * @param sysMenuIds
     * @return
     */
    List<NavMenu> selectMenuByIds(Long[] sysMenuIds);

}
