package com.geshanzsq.admin.system.menu.mapper;

import com.geshanzsq.admin.system.menu.po.SysMenu;
import com.geshanzsq.admin.system.menu.vo.SysMenuVO;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@Mapper
public interface SysMenuMapper extends BaseMapperPlus<SysMenu> {

    /**
     * 通过角色 ids 获取菜单
     * @param roleIds 角色 Ids
     * @param menuTypes 菜单类型
     * @param menuStatus 菜单状态
     */
    List<SysMenuVO> getMenuByRoleIds(@Param("roleIds") Set<Long> roleIds,
                                     @Param("menuTypes") List<String> menuTypes,
                                     @Param("menuStatus") Integer menuStatus);

    /**
     * 通过用户 id 获取菜单
     * @param userId 用户 id
     * @param menuStatus 菜单状态
     * @param roleStatus 角色状态
     * @param menuHasPermission 是否需要权限
     * @param menuTypes 菜单类型
     * @return
     */
    List<SysMenuVO> getMenuByUserId(@Param("userId") Long userId,
                                    @Param("menuStatus") Integer menuStatus,
                                    @Param("roleStatus") Integer roleStatus,
                                    @Param("menuHasPermission") Integer menuHasPermission,
                                    @Param("menuTypes") List<String> menuTypes);

    /**
     * 获取最大排序
     * @param parentId 上级菜单
     */
    Integer selectMaxSortByParentId(Long parentId);
}
