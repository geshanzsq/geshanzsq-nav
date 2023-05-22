package com.geshanzsq.admin.system.menu.controller;

import com.geshanzsq.admin.system.api.service.SysApiService;
import com.geshanzsq.admin.system.menu.dto.SysMenuAddDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuAuthApiDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuListDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuUpdateDTO;
import com.geshanzsq.admin.system.menu.mapstruct.SysMenuConverter;
import com.geshanzsq.admin.system.menu.po.SysMenu;
import com.geshanzsq.admin.system.menu.service.SysMenuService;
import com.geshanzsq.admin.system.menu.vo.SysMenuAuthApiVO;
import com.geshanzsq.admin.system.menu.vo.SysMenuVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.log.annotation.Log;
import com.geshanzsq.common.log.enums.BusinessType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Api(tags = "系统菜单")
@RestController
@RequestMapping("/system/menu")
public class SysMenuController {

    @Autowired
    private SysMenuService sysMenuService;
    @Autowired
    private SysApiService sysApiService;

    @GetMapping("/list")
    @ApiOperation("列表")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<List<SysMenuVO>> list(SysMenuListDTO sysMenuListDTO) {
        List<SysMenuVO> list = sysMenuService.getMenuList(sysMenuListDTO);
        return ResponseResult.success(list);
    }

    @GetMapping("/tree")
    @ApiOperation("树形")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<List<SysMenuVO>> tree() {
        List<SysMenuVO> treeList = sysMenuService.getMenuTree();
        return ResponseResult.success(treeList);
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysMenuVO> getById(@PathVariable Long id) {
        return ResponseResult.success(SysMenuConverter.INSTANCE.convert(sysMenuService.getById(id)));
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "菜单管理", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysMenuAddDTO addDTO) {
        SysMenu sysMenu = SysMenuConverter.INSTANCE.convert(addDTO);
        sysMenuService.save(sysMenu);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "菜单管理", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysMenuUpdateDTO updateDTO) {
        SysMenu sysMenu = SysMenuConverter.INSTANCE.convert(updateDTO);
        sysMenuService.updateById(sysMenu);
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSortByParentId")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSortByParentId(Long parentId) {
        Integer maxSort = sysMenuService.getMaxSortByParentId(parentId);
        return ResponseResult.success(maxSort);
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "菜单管理", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long id) {
        sysMenuService.remove(id);
        return ResponseResult.success();
    }

    @GetMapping("/auth/api/list")
    @ApiOperation("获取分配的 API 接口")
    public ResponseResult<List<SysMenuAuthApiVO>> getApiByMenuId(Long menuId) {
        List<SysMenuAuthApiVO> list = sysApiService.getAuthApiByMenuId(menuId);
        return ResponseResult.success(list);
    }

    @PostMapping("/auth/api")
    @ApiOperation("分配 API")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "菜单管理-分配 API", businessType = BusinessType.UPDATE)
    public ResponseResult authApi(@Valid @RequestBody SysMenuAuthApiDTO authApiDto) {
        sysMenuService.authApi(authApiDto);
        return ResponseResult.success();
    }


}
