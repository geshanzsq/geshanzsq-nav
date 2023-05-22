package com.geshanzsq.admin.system.user.controller;

import com.geshanzsq.admin.system.user.dto.*;
import com.geshanzsq.admin.system.user.mapstruct.SysUserConverter;
import com.geshanzsq.admin.system.user.po.SysUser;
import com.geshanzsq.admin.system.user.service.SysUserService;
import com.geshanzsq.admin.system.user.vo.SysUserVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.controller.BaseController;
import com.geshanzsq.common.log.annotation.Log;
import com.geshanzsq.common.log.enums.BusinessType;
import com.geshanzsq.framework.security.util.SecurityUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Arrays;

/**
 * 系统用户
 *
 * @author geshanzsq
 * @date 2022/3/20
 */
@Api(tags = "用户管理")
@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/page")
    @ApiOperation(("分页列表"))
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<SysUserVO>> page(SysUserPageDTO pageDto) {
        PageVO<SysUserVO> pageVO = sysUserService.pageList(pageDto);
        return ResponseResult.success(pageVO);
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysUserVO> getById(@PathVariable Long id) {
        SysUser sysUser = sysUserService.getById(id);
        if (sysUser != null) {
            sysUser.setPassword(null);
        }
        return ResponseResult.success(SysUserConverter.INSTANCE.convert(sysUser));
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "用户管理", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysUserAddDTO addDto) {
        sysUserService.add(addDto);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "用户管理", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysUserUpdateDTO updateDto) {
        SysUser sysUser = SysUserConverter.INSTANCE.convert(updateDto);
        sysUserService.updateById(sysUser);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "用户管理", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        sysUserService.removeByIds(Arrays.asList(ids));
        return ResponseResult.success();
    }

    @PutMapping("/resetPassword")
    @ApiOperation("重置密码")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "用户管理-重置密码", businessType = BusinessType.UPDATE, isSaveRequestData = false)
    public ResponseResult resetPassword(@Valid @RequestBody SysUserResetPasswordDTO sysUserResetPasswordDto) {
        sysUserService.resetPassword(sysUserResetPasswordDto);
        return ResponseResult.success();
    }

    @PutMapping("/userUpdateInfo")
    @ApiOperation("用户修改信息")
    @Log(moduleName = "用户管理-用户修改信息", businessType = BusinessType.UPDATE)
    public ResponseResult userUpdateInfo(@Valid @RequestBody SysUserUpdateInfoDTO updateDto) {
        SysUser sysUser = SysUserConverter.INSTANCE.convert(updateDto);
        sysUser.setId(SecurityUtils.getUserId());
        sysUserService.updateById(sysUser);
        return ResponseResult.success();
    }

    @PutMapping("/resetUserPassword")
    @ApiOperation("重置用户密码")
    public ResponseResult resetUserPassword(@Valid @RequestBody SysUserResetUserPasswordDTO passwordDTO) {
        sysUserService.resetUserPassword(passwordDTO);
        return ResponseResult.success();
    }

}
