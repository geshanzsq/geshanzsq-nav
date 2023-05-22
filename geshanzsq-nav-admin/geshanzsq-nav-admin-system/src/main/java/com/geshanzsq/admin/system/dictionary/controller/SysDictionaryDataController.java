package com.geshanzsq.admin.system.dictionary.controller;

import com.geshanzsq.admin.system.dictionary.dto.SysDictionaryDataAddDTO;
import com.geshanzsq.admin.system.dictionary.dto.SysDictionaryDataPageDTO;
import com.geshanzsq.admin.system.dictionary.dto.SysDictionaryDataUpdateDTO;
import com.geshanzsq.admin.system.dictionary.mapstruct.SysDictionaryDataConverter;
import com.geshanzsq.admin.system.dictionary.po.SysDictionaryData;
import com.geshanzsq.admin.system.dictionary.service.SysDictionaryDataService;
import com.geshanzsq.admin.system.dictionary.vo.SysDictionaryDataVO;
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
 * 字典数据
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Api(tags = "系统字典数据")
@RestController
@RequestMapping("/system/dictionary/data")
public class SysDictionaryDataController extends BaseController {

    @Autowired
    private SysDictionaryDataService sysDictionaryDataService;

    @ApiOperation("分页列表")
    @GetMapping("/page")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<SysDictionaryDataVO>> page(@Valid SysDictionaryDataPageDTO pageDTO) {
        pageDTO.setOrderColumn("sort,id");
        PageVO<SysDictionaryData> pageVO = sysDictionaryDataService.page(pageDTO);
        return ResponseResult.success(SysDictionaryDataConverter.INSTANCE.convert(pageVO));
    }

    @GetMapping("/getById/{id}")
    @ApiOperation("详情")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<SysDictionaryDataVO> getById(@PathVariable Long id) {
        return ResponseResult.success(SysDictionaryDataConverter.INSTANCE.convert(sysDictionaryDataService.getById(id)));
    }

    @PostMapping()
    @ApiOperation("新增")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统字典数据", businessType = BusinessType.ADD)
    public ResponseResult add(@Valid @RequestBody SysDictionaryDataAddDTO addDTO) {
        SysDictionaryData sysDictionaryData = SysDictionaryDataConverter.INSTANCE.convert(addDTO);
        sysDictionaryDataService.save(sysDictionaryData);
        return ResponseResult.success();
    }

    @PutMapping()
    @ApiOperation("修改")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统字典数据", businessType = BusinessType.UPDATE)
    public ResponseResult update(@Valid @RequestBody SysDictionaryDataUpdateDTO updateDTO) {
        SysDictionaryData sysDictionaryData = SysDictionaryDataConverter.INSTANCE.convert(updateDTO);
        sysDictionaryDataService.updateById(sysDictionaryData);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "系统字典数据", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        sysDictionaryDataService.removeByIds(Arrays.asList(ids));
        return ResponseResult.success();
    }

    @GetMapping("/getMaxSortByDictionaryId")
    @ApiOperation("获取最大排序")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<Integer> getMaxSortByDictionaryId(Long dictionaryId) {
        Integer maxSort = sysDictionaryDataService.getMaxSortByDictionaryId(dictionaryId);
        return ResponseResult.success(maxSort);
    }

}
