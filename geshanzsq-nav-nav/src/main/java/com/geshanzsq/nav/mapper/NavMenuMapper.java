package com.geshanzsq.nav.mapper;

import com.geshanzsq.nav.domain.NavMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 导航菜单Mapper接口
 * 
 * @author geshanzsq
 * @date 2020-07-10
 */
public interface NavMenuMapper
{
    /**
     * 查询导航菜单
     * 
     * @param menuId 导航菜单ID
     * @return 导航菜单
     */
    public NavMenu selectNavMenuById(@Param("menuId") Long menuId);

    /**
     * 查询导航菜单列表
     * 
     * @param navMenu 导航菜单
     * @return 导航菜单集合
     */
    public List<NavMenu> selectNavMenuList(NavMenu navMenu);

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
     * 删除导航菜单
     * 
     * @param menuId 导航菜单ID
     * @return 结果
     */
    public int deleteNavMenuById(@Param("menuId") Long menuId);

    /**
     * 批量删除导航菜单
     * 
     * @param menuIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteNavMenuByIds(Long[] menuIds);

    /**
     * 通过父级id获取子菜单
     * @param parentId
     * @return
     */
    List<NavMenu> selectNavMenuByParentId(@Param("parentId") Long parentId);

    /**
     * 获取菜单数量
     */
    Integer getCount(@Param("status") Integer status);

    /**
     * 获取该子菜单下最大的排序
     * @param menuId
     * @return
     */
    Integer getMaxChildrenMenuOrderNum(@Param("menuId") Long menuId);

    /**
     * 通过菜单数组获取菜单信息
     * @param sysMenuIds
     * @return
     */
    List<NavMenu> selectMenuByIds(@Param("sysMenuIds") Long[] sysMenuIds,
                                  @Param("status") Integer status);
}
