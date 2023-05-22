package com.geshanzsq.admin.system.param.controller;

import com.geshanzsq.admin.system.param.dto.SysParamAddDTO;
import com.geshanzsq.admin.system.param.dto.SysParamPageDTO;
import com.geshanzsq.admin.system.param.dto.SysParamUpdateDTO;
import com.geshanzsq.admin.system.param.mapstruct.SysParamConverter;
import com.geshanzsq.admin.system.param.po.SysParam;
import com.geshanzsq.admin.system.param.service.SysParamService;
import com.geshanzsq.admin.system.param.vo.SysParamVO;
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
import java.util.Arrays;

/**
 * 参数配置
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
@Api(tags = "参数配置")
@RestController
@RequestMapping("/system/param")
public class SysParamController extends BaseController {

    @Autowired
    private SysParamService sysParamService;

    @ApiOperation("分页列表")
    @GetMapping("/page")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<SysParamVO>> page(@Valid SysParamPageDTO pageDTO) {
        pageDTO.setOrderColumn("sort,id");
        PageVO<SysParam> pageVO = sysParamService.page(pageDTO);
        return ResponseResult.success(SysParamConverter.INSTANCE.convert(pageVO));
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysParamVO> getById(@PathVariable Long id) {
        return ResponseResult.success(SysParamConverter.INSTANCE.convert(sysParamService.getById(id)));
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "参数配置", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysParamAddDTO addDTO) {
        sysParamService.save(addDTO);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "参数配置", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysParamUpdateDTO updateDTO) {
        sysParamService.updateById(updateDTO);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "参数配置", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        sysParamService.removeByIds(ids);
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSort")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSort() {
        Integer maxSort = sysParamService.getMaxSort();
        return ResponseResult.success(maxSort);
    }

}
