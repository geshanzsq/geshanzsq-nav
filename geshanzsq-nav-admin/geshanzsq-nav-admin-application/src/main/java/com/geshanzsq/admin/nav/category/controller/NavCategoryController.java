package com.geshanzsq.admin.nav.category.controller;

import com.geshanzsq.admin.nav.category.dto.NavCategoryAddDTO;
import com.geshanzsq.admin.nav.category.dto.NavCategoryListDTO;
import com.geshanzsq.admin.nav.category.dto.NavCategoryUpdateDTO;
import com.geshanzsq.admin.nav.category.mapstruct.NavCategoryConverter;
import com.geshanzsq.admin.nav.category.po.NavCategory;
import com.geshanzsq.admin.nav.category.service.NavCategoryService;
import com.geshanzsq.admin.nav.category.vo.NavCategoryTreeVO;
import com.geshanzsq.admin.nav.category.vo.NavCategoryVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
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
 * 导航分类
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Api(tags = "导航分类")
@RestController
@RequestMapping("/nav/category")
public class NavCategoryController extends BaseController {

    @Autowired
    private NavCategoryService navCategoryService;

    @ApiOperation("列表")
    @GetMapping("/list")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<List<NavCategoryVO>> list(NavCategoryListDTO listDTO) {
        List<NavCategory> list = navCategoryService.list(listDTO);
        return ResponseResult.success(NavCategoryConverter.INSTANCE.convert(list));
    }

    @ApiOperation("树形")
    @GetMapping("/tree")
    public ResponseResult<List<NavCategoryTreeVO>> tree() {
        List<NavCategoryTreeVO> list = navCategoryService.tree();
        return ResponseResult.success(list);
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<NavCategoryVO> getById(@PathVariable Long id) {
        return ResponseResult.success(NavCategoryConverter.INSTANCE.convert(navCategoryService.getById(id)));
    }

    @PostMapping
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "导航分类", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody NavCategoryAddDTO addDTO) {
        NavCategory navCategory = NavCategoryConverter.INSTANCE.convert(addDTO);
        navCategoryService.save(navCategory);
        return ResponseResult.success();
    }

    @PutMapping
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "导航分类", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody NavCategoryUpdateDTO updateDTO) {
        navCategoryService.updateById(updateDTO);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "导航分类", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long id) {
        navCategoryService.remove(id);
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSortByParentId")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSortByParentId(Long parentId) {
        Integer maxSort = navCategoryService.getMaxSortByParentId(parentId);
        return ResponseResult.success(maxSort);
    }

}
