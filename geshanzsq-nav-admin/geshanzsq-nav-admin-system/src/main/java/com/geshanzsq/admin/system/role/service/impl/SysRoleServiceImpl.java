package com.geshanzsq.admin.system.role.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.role.dto.*;
import com.geshanzsq.admin.system.role.mapper.SysRoleMapper;
import com.geshanzsq.admin.system.role.mapstruct.SysRoleConverter;
import com.geshanzsq.admin.system.role.po.SysRole;
import com.geshanzsq.admin.system.role.service.SysRoleMenuService;
import com.geshanzsq.admin.system.role.service.SysRoleService;
import com.geshanzsq.admin.system.role.vo.SysRoleVO;
import com.geshanzsq.admin.system.user.dto.SysUserPageDTO;
import com.geshanzsq.admin.system.user.po.SysUserRole;
import com.geshanzsq.admin.system.user.service.SysUserRoleService;
import com.geshanzsq.admin.system.user.service.SysUserService;
import com.geshanzsq.admin.system.user.vo.SysUserVO;
import com.geshanzsq.common.core.enums.CommonStatus;
import com.geshanzsq.common.core.exception.ParamException;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import com.geshanzsq.framework.security.constant.SecurityConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 系统角色
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@Service
public class SysRoleServiceImpl extends BaseServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysRoleMenuService sysRoleMenuService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysUserRoleService sysUserRoleService;

    /**
     * 通过用户 id 获取角色
     * @param userId 用户 id
     */
    @Override
    public List<SysRoleVO> getRoleByUserId(Long userId) {
        return sysRoleMapper.getRoleByUserIds(Arrays.asList(userId), CommonStatus.NORMAL.code);
    }

    /**
     * 通过用户 ids 获取角色
     * @param userIds 用户 ids
     * @return
     */
    @Override
    public List<SysRoleVO> getRoleByUserIds(List<Long> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            return new ArrayList<>();
        }
        return sysRoleMapper.getRoleByUserIds(userIds, CommonStatus.NORMAL.code);
    }

    /**
     * 新增角色
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(SysRoleAddDTO addDTO) {
        // 判断角色编码是否存在
        if (isExistRoleCode(addDTO.getRoleCode(), null)) {
            throw new ParamException(MessageUtils.message("role.code.exist"));
        }

        // 插入角色信息
        SysRole sysRole = SysRoleConverter.INSTANCE.convert(addDTO);
        sysRoleMapper.insert(sysRole);

        // 插入角色和菜单信息
        sysRoleMenuService.saveBatch(sysRole.getId(), addDTO.getMenuIds());
    }

    /**
     * 修改角色
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(SysRoleUpdateDTO updateDTO) {
        Long roleId = updateDTO.getId();

        // 判断是否为超级管理员角色
        if (isSuperAdminRoleByRoleIds(Arrays.asList(roleId))) {
            throw new ParamException(MessageUtils.message("role.super.admin.not.operation"));
        }

        // 判断角色编码是否存在
        if (isExistRoleCode(updateDTO.getRoleCode(), roleId)) {
            throw new ParamException(MessageUtils.message("role.code.exist"));
        }

        // 更新角色信息
        SysRole sysRole = SysRoleConverter.INSTANCE.convert(updateDTO);
        sysRoleMapper.updateById(sysRole);

        // 删除角色和菜单关系
        sysRoleMenuService.deleteByRoleId(roleId);

        // 插入角色和菜单信息
        sysRoleMenuService.saveBatch(roleId, updateDTO.getMenuIds());
    }

    /**
     * 删除角色
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void removeByIds(Long[] ids) {
        if (ids.length == 0) {
            return;
        }
        List<Long> idList = Arrays.asList(ids);
        // 判断是否为超级管理员角色
        if (isSuperAdminRoleByRoleIds(idList)) {
            throw new ParamException(MessageUtils.message("role.super.admin.not.operation"));
        }

        // 判断角色是否关联用户，如果关联了用户，需先取消关联才能删除
        if (sysUserRoleService.isAssociateUser(idList)) {
            throw new ParamException(MessageUtils.message("role.is.associate.user"));
        }

        // 删除角色
        sysRoleMapper.deleteBatchIds(idList);

        // 删除角色和用户对应关系，虽然前面已经做了是否关联用户，但是为了避免已删除的用户有关联角色有脏的对应关系，所以需要删除
        LambdaQueryWrapper<SysUserRole> urWrapper = new LambdaQueryWrapper<>();
        urWrapper.in(SysUserRole::getRoleId, ids);
        sysUserRoleService.removeByIds(idList);
    }

    /**
     * 获取最大排序
     */
    @Override
    public Integer getMaxSort() {
        return sysRoleMapper.selectMaxSort();
    }

    /**
     * 获取角色信息
     * @param id 角色 id
     */
    @Override
    public SysRoleVO getRoleById(Long id) {
        SysRoleVO sysRoleVO = SysRoleConverter.INSTANCE.convert(sysRoleMapper.selectById(id));
        if (sysRoleVO != null) {
            // 获取角色对应的菜单 Id
            sysRoleVO.setMenuIds(sysRoleMenuService.getMenuIdsByRoleId(id));
        }
        return sysRoleVO;
    }

    /**
     * 已分配用户分页
     */
    @Override
    public PageVO<SysUserVO> getUserAuthPage(SysRoleAuthUserPageDTO pageDTO) {
        // 获取已分配的用户
        List<Long> userIds = sysUserRoleService.getUserIdsByRoleId(pageDTO.getRoleId());
        // 如果获取的用户 id 为空，说明没有关联用户，直接返回
        if (CollectionUtils.isEmpty(userIds)) {
            return new PageVO<>();
        }

        // 查询用户数据
        SysUserPageDTO sysUserPageDTO = SysRoleConverter.INSTANCE.convert(pageDTO);
        sysUserPageDTO.setIds(userIds);
        return sysUserService.pageList(sysUserPageDTO);
    }

    /**
     * 未分配用户分页
     */
    @Override
    public PageVO<SysUserVO> getUserUnAuthPage(SysRoleNotAuthUserPageDTO pageDTO) {
        // 获取已分配的用户
        List<Long> userIds = sysUserRoleService.getUserIdsByRoleId(pageDTO.getRoleId());
        // 查询用户数据
        SysUserPageDTO sysUserPageDTO = SysRoleConverter.INSTANCE.convert(pageDTO);
        sysUserPageDTO.setNotIds(userIds);
        return sysUserService.pageList(sysUserPageDTO);
    }

    /**
     * 授权用户
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void authUser(SysRoleAuthUserDTO authUserDto) {
        Long roleId = authUserDto.getRoleId();
        // 先判断角色是否存在
        LambdaQueryWrapper<SysRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysRole::getId, roleId);
        if (sysRoleMapper.selectCount(wrapper) == 0) {
            throw new ParamException(MessageUtils.message("role.not.exist"));
        }

        // 过滤不存在的用户 id
        List<Long> userIds = sysUserService.filterNotExistUserIds(authUserDto.getUserIds());
        if (CollectionUtils.isEmpty(userIds)) {
            throw new ParamException(MessageUtils.message("role.auth.user.not.exit"));
        }

        // 插入角色和用户直接的关系
        sysUserRoleService.saveBatch(roleId, userIds);
    }

    /**
     * 取消授权
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeAuthUser(SysRoleAuthUserDeleteDTO deleteDto) {
        sysUserRoleService.remove(deleteDto.getRoleId(), deleteDto.getUserIds());
    }

    /**
     * 角色编码是否存在
     * @param roleCode 角色编码
     * @param roleId 角色 id，用于区别新增还是编辑
     * @return
     */
    private boolean isExistRoleCode(String roleCode, Long roleId) {
        if (StrUtils.isBlank(roleCode)) {
            return false;
        }
        LambdaQueryWrapper<SysRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysRole::getRoleCode, roleCode);
        if (roleId != null) {
            wrapper.ne(SysRole::getId, roleId);
        }
        return sysRoleMapper.selectCount(wrapper) > 0;
    }

    /**
     * 判断是否为超级管理员角色
     * @param roleIds
     * @return
     */
    private boolean isSuperAdminRoleByRoleIds(List<Long> roleIds) {
        if (CollectionUtils.isEmpty(roleIds)) {
            return false;
        }
        LambdaQueryWrapper<SysRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(SysRole::getId, roleIds);
        wrapper.eq(SysRole::getRoleCode, SecurityConstant.SUPER_ADMIN_ROLE_CODE);
        return sysRoleMapper.selectCount(wrapper) > 0;
    }
}
