package com.geshanzsq.admin.system.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.user.mapper.SysUserRoleMapper;
import com.geshanzsq.admin.system.user.po.SysUserRole;
import com.geshanzsq.admin.system.user.service.SysUserRoleService;
import com.geshanzsq.common.core.enums.DelFlag;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 系统用户角色
 *
 * @author geshanzsq
 * @date 2022/7/17
 */
@Service
public class SysUserRoleServiceImpl extends BaseServiceImpl<SysUserRoleMapper, SysUserRole> implements SysUserRoleService {

    @Autowired
    private SysUserRoleMapper sysUserRoleMapper;

    /**
     * 通过角色 id 获取用户 id 集合
     * @param roleId 角色 id
     */
    @Override
    public List<Long> getUserIdsByRoleId(Long roleId) {
        if (roleId == null) {
            return new ArrayList<>();
        }
        // 获取已分配的用户
        LambdaQueryWrapper<SysUserRole> wrapper = new LambdaQueryWrapper();
        wrapper.eq(SysUserRole::getRoleId, roleId);
        wrapper.select(SysUserRole::getId, SysUserRole::getUserId);
        List<SysUserRole> list = sysUserRoleMapper.selectList(wrapper);
        List<Long> userIds = list.stream().map(SysUserRole::getUserId).collect(Collectors.toList());
        return userIds;
    }

    /**
     * 批量插入角色和用户关系
     * @param roleId 角色 id
     * @param userIds 用户 id 集合
     */
    @Override
    public void saveBatch(Long roleId, List<Long> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            return;
        }
        List<SysUserRole> list = new ArrayList<>();
        for (Long userId : userIds) {
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setRoleId(roleId);
            sysUserRole.setUserId(userId);
            list.add(sysUserRole);
        }
        super.saveBatch(list);
    }

    /**
     * 删除
     * @param roleId 角色 id
     * @param userIds 用户 id 集合
     */
    @Override
    public void remove(Long roleId, List<Long> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            return;
        }
        LambdaQueryWrapper<SysUserRole> wrapper = new LambdaQueryWrapper();
        wrapper.eq(SysUserRole::getRoleId, roleId);
        wrapper.in(SysUserRole::getUserId, userIds);
        sysUserRoleMapper.delete(wrapper);
    }

    /**
     * 是否关联用户
     * @param roleIds 角色 id 集合
     */
    @Override
    public boolean isAssociateUser(List<Long> roleIds) {
        if (CollectionUtils.isEmpty(roleIds)) {
            return false;
        }
        return sysUserRoleMapper.selectAssociateNotDeleteUserCount(roleIds, DelFlag.NO_DELETE.code) > 0;
    }
}
