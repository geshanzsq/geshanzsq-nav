package com.geshanzsq.admin.system.menu.service;

import com.geshanzsq.admin.system.menu.dto.SysMenuAuthApiDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuListDTO;
import com.geshanzsq.admin.system.menu.po.SysMenu;
import com.geshanzsq.admin.system.menu.vo.RouterVO;
import com.geshanzsq.admin.system.menu.vo.SysMenuVO;
import com.geshanzsq.common.framework.web.service.BaseService;

import java.util.List;
import java.util.Set;

/**
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
public interface SysMenuService extends BaseService<SysMenu> {

    /**
     * 通过角色 ids 获取菜单
     * @param roleIds 角色 ids
     */
    List<SysMenuVO> getMenuByRoleIds(Set<Long> roleIds);

    /**
     * 获取菜单路由
     */
    List<RouterVO> getRouters();

    /**
     * 获取菜单列表
     */
    List<SysMenuVO> getMenuList(SysMenuListDTO sysMenuListDTO);

    /**
     * 菜单树形
     */
    List<SysMenuVO> getMenuTree();

    /**
     * 获取最大排序
     * @param parentId 上级菜单 id
     */
    Integer getMaxSortByParentId(Long parentId);

    /**
     * 删除
     * @param id 菜单 id
     */
    void remove(Long id);

    /**
     * 分配 API
     */
    void authApi(SysMenuAuthApiDTO authApiDTO);

}
