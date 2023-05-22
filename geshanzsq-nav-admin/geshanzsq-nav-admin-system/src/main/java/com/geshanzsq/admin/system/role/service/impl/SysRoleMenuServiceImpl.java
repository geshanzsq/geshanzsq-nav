package com.geshanzsq.admin.system.role.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.role.mapper.SysRoleMenuMapper;
import com.geshanzsq.admin.system.role.po.SysRoleMenu;
import com.geshanzsq.admin.system.role.service.SysRoleMenuService;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 角色菜单
 *
 * @author geshanzsq
 * @date 2022/6/22
 */
@Service
public class SysRoleMenuServiceImpl extends BaseServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements SysRoleMenuService {

    @Autowired
    private SysRoleMenuMapper sysRoleMenuMapper;

    /**
     * 批量插入
     * @param roleId 角色 id
     * @param menuIds 菜单 ids
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveBatch(Long roleId, List<Long> menuIds) {
        if (CollectionUtils.isEmpty(menuIds)) {
            return;
        }
        List<SysRoleMenu> roleMenus = new ArrayList<>();
        for (Long menuId : menuIds) {
            SysRoleMenu sysRoleMenu = new SysRoleMenu();
            sysRoleMenu.setMenuId(menuId);
            sysRoleMenu.setRoleId(roleId);
            roleMenus.add(sysRoleMenu);
        }
        super.saveBatch(roleMenus);
    }

    /**
     * 通过角色 id 获取菜单 ids
     * @param roleId 角色 id
     */
    @Override
    public List<Long> getMenuIdsByRoleId(Long roleId) {
        if (roleId == null) {
            return new ArrayList<>();
        }
        LambdaQueryWrapper<SysRoleMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysRoleMenu::getRoleId, roleId);
        wrapper.select(SysRoleMenu::getMenuId);
        List<SysRoleMenu> roleMenus = sysRoleMenuMapper.selectList(wrapper);
        Set<Long> menuIds = roleMenus.stream().map(rm -> rm.getMenuId()).collect(Collectors.toSet());
        return new ArrayList<>(menuIds);
    }

    /**
     * 删除角色和菜单关系
     * @param roleId 角色 id
     */
    @Override
    public void deleteByRoleId(Long roleId) {
        if (roleId == null) {
            return;
        }
        LambdaQueryWrapper<SysRoleMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysRoleMenu::getRoleId, roleId);
        sysRoleMenuMapper.delete(wrapper);
    }
}
