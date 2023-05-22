package com.geshanzsq.admin.system.user.service;

import com.geshanzsq.admin.system.user.po.SysUserRole;
import com.geshanzsq.common.framework.web.service.BaseService;

import java.util.List;

/**
 * 系统用户角色
 *
 * @author geshanzsq
 * @date 2022/7/17
 */
public interface SysUserRoleService extends BaseService<SysUserRole> {

    /**
     * 通过角色 id 获取用户 id 集合
     * @param roleId 角色 id
     */
    List<Long> getUserIdsByRoleId(Long roleId);

    /**
     * 批量插入角色和用户关系
     * @param roleId 角色 id
     * @param userIds 用户 id 集合
     */
    void saveBatch(Long roleId, List<Long> userIds);

    /**
     * 删除
     * @param roleId 角色 id
     * @param userIds 用户 id 集合
     */
    void remove(Long roleId, List<Long> userIds);

    /**
     * 是否关联用户
     * @param roleIds 角色 id 集合
     */
    boolean isAssociateUser(List<Long> roleIds);

}
