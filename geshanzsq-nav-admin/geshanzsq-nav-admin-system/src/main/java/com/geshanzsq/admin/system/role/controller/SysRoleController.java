package com.geshanzsq.admin.system.role.controller;

import com.geshanzsq.admin.system.role.dto.*;
import com.geshanzsq.admin.system.role.mapstruct.SysRoleConverter;
import com.geshanzsq.admin.system.role.po.SysRole;
import com.geshanzsq.admin.system.role.service.SysRoleService;
import com.geshanzsq.admin.system.role.vo.SysRoleVO;
import com.geshanzsq.admin.system.user.vo.SysUserVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.controller.BaseController;
import com.geshanzsq.common.log.annotation.Log;
import com.geshanzsq.common.log.enums.BusinessType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * 系统角色
 *
 * @author geshanzsq
 * @date 2022/6/19
 */
@Api(tags = "系统角色")
@RestController
@RequestMapping("/system/role")
public class SysRoleController extends BaseController {

    @Autowired
    private SysRoleService sysRoleService;

    @ApiOperation("分页列表")
    @GetMapping("/page")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<SysRoleVO>> page(SysRolePageDTO pageDTO) {
        pageDTO.setOrderColumn("sort,id");
        PageVO<SysRole> pageVO = sysRoleService.page(pageDTO);
        return ResponseResult.success(SysRoleConverter.INSTANCE.convert(pageVO));
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysRoleVO> getById(@PathVariable Long id) {
        SysRoleVO sysRoleVo = sysRoleService.getRoleById(id);
        return ResponseResult.success(sysRoleVo);
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "角色管理", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysRoleAddDTO addDTO) {
        sysRoleService.add(addDTO);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "角色管理", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysRoleUpdateDTO updateDTO) {
        sysRoleService.update(updateDTO);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "角色管理", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        sysRoleService.removeByIds(ids);
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSort")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSort() {
        Integer maxSort = sysRoleService.getMaxSort();
        return ResponseResult.success(maxSort);
    }

    @GetMapping("/auth/user/page")
    @ApiOperation("已分配用户分页")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysUserVO> getUserAuthPage(@Valid SysRoleAuthUserPageDTO pageDTO) {
        PageVO<SysUserVO> pageVO = sysRoleService.getUserAuthPage(pageDTO);
        return ResponseResult.success(pageVO);
    }

    @GetMapping("/auth/user/not/page")
    @ApiOperation("未分配用户分页")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysUserVO> getUserUnAuthPage(@Valid SysRoleNotAuthUserPageDTO pageDTO) {
        PageVO<SysUserVO> pageVO = sysRoleService.getUserUnAuthPage(pageDTO);
        return ResponseResult.success(pageVO);
    }

    @PostMapping("/auth/user")
    @ApiOperation("授权用户")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "角色管理-授权用户", businessType = BusinessType.ADD)
    public ResponseResult authUser(@Valid @RequestBody SysRoleAuthUserDTO authUserDTO) {
        sysRoleService.authUser(authUserDTO);
        return ResponseResult.success();
    }

    @DeleteMapping("/auth/user/delete")
    @ApiOperation("取消授权")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "角色管理-取消授权", businessType = BusinessType.DELETE)
    public ResponseResult deleteAuthUser(@Valid @RequestBody SysRoleAuthUserDeleteDTO deleteDTO) {
        sysRoleService.removeAuthUser(deleteDTO);
        return ResponseResult.success();
    }
}
