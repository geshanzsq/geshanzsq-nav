package com.geshanzsq.admin.system.role.service;

import com.geshanzsq.admin.system.role.po.SysRoleMenu;
import com.geshanzsq.common.framework.web.service.BaseService;

import java.util.List;

/**
 * 角色菜单
 *
 * @author geshanzsq
 * @date 2022/6/22
 */
public interface SysRoleMenuService extends BaseService<SysRoleMenu> {

    /**
     * 批量插入
     * @param roleId 角色 id
     * @param menuIds 菜单 ids
     */
    void saveBatch(Long roleId, List<Long> menuIds);

    /**
     * 通过角色 id 获取菜单 ids
     * @param roleId 角色 id
     * @return
     */
    List<Long> getMenuIdsByRoleId(Long roleId);

    /**
     * 删除角色和菜单关系
     * @param roleId 角色 id
     */
    void deleteByRoleId(Long roleId);

}
