package com.geshanzsq.admin.system.api.controller;

import com.geshanzsq.admin.system.api.dto.SysApiCategoryAddDTO;
import com.geshanzsq.admin.system.api.dto.SysApiCategoryPageDTO;
import com.geshanzsq.admin.system.api.dto.SysApiCategoryUpdateDTO;
import com.geshanzsq.admin.system.api.mapstruct.SysApiCategoryConverter;
import com.geshanzsq.admin.system.api.po.SysApiCategory;
import com.geshanzsq.admin.system.api.service.SysApiCategoryService;
import com.geshanzsq.admin.system.api.vo.SysApiCategoryVO;
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
import java.util.List;

/**
 * 系统接口分类
 *
 * @author geshanzsq
 * @date 2022/6/24
 */
@Api(tags = "系统接口分类")
@RestController
@RequestMapping("/system/api/category")
public class SysApiCategoryController extends BaseController {

    @Autowired
    private SysApiCategoryService sysApiCategoryService;

    @ApiOperation("分页列表")
    @GetMapping("/page")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<SysApiCategoryVO>> page(SysApiCategoryPageDTO pageDTO) {
        pageDTO.setOrderColumn("sort,id");
        PageVO<SysApiCategory> pageVO = sysApiCategoryService.page(pageDTO);
        return ResponseResult.success(SysApiCategoryConverter.INSTANCE.convert(pageVO));
    }

    @ApiOperation("列表")
    @GetMapping("/list")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<List<SysApiCategoryVO>> list() {
        return ResponseResult.success(sysApiCategoryService.listSort());
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysApiCategoryVO> getById(@PathVariable Long id) {
        return ResponseResult.success(SysApiCategoryConverter.INSTANCE.convert(sysApiCategoryService.getById(id)));
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统接口分类", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysApiCategoryAddDTO addDTO) {
        SysApiCategory sysApiCategory = SysApiCategoryConverter.INSTANCE.convert(addDTO);
        sysApiCategoryService.save(sysApiCategory);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统接口分类", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysApiCategoryUpdateDTO updateDTO) {
        SysApiCategory sysApiCategory = SysApiCategoryConverter.INSTANCE.convert(updateDTO);
        sysApiCategoryService.updateById(sysApiCategory);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统接口分类", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        sysApiCategoryService.removeByIds(ids);
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSort")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSort() {
        Integer maxSort = sysApiCategoryService.getMaxSort();
        return ResponseResult.success(maxSort);
    }

}
