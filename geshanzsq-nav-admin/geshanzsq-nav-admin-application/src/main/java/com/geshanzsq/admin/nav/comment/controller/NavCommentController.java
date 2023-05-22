package com.geshanzsq.admin.nav.comment.controller;

import com.geshanzsq.admin.nav.comment.dto.NavCommentPageDTO;
import com.geshanzsq.admin.nav.comment.dto.NavCommentRejectDTO;
import com.geshanzsq.admin.nav.comment.mapstruct.NavCommentConverter;
import com.geshanzsq.admin.nav.comment.po.NavComment;
import com.geshanzsq.admin.nav.comment.service.NavCommentService;
import com.geshanzsq.admin.nav.comment.vo.NavCommentVO;
import com.geshanzsq.common.core.enums.YesNo;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
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
 * 评论
 *
 * @author geshanzsq
 * @date 2022/11/29
 */
@Api(tags = "评论")
@RestController
@RequestMapping("/nav/comment")
public class NavCommentController {

    @Autowired
    private NavCommentService navCommentService;

    @ApiOperation("分页列表")
    @GetMapping("/page")
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<NavCommentVO>> page(NavCommentPageDTO pageDTO) {
        PageVO<NavCommentVO> pageVO = navCommentService.pageList(pageDTO);
        return ResponseResult.success(pageVO);
    }


    @ApiOperation("通过")
    @PutMapping("/pass/{ids}")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "评论-通过", businessType = BusinessType.UPDATE)
    public ResponseResult pass(@PathVariable Long[] ids) {
        navCommentService.pass(ids);
        return ResponseResult.success();
    }

    @ApiOperation("驳回")
    @PutMapping("/reject")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "评论-驳回", businessType = BusinessType.UPDATE)
    public ResponseResult reject(@Valid @RequestBody NavCommentRejectDTO rejectDTO) {
        navCommentService.reject(rejectDTO);
        return ResponseResult.success();
    }

    @ApiOperation("置顶")
    @PutMapping("/sticky/{id}")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "评论-置顶", businessType = BusinessType.UPDATE)
    public ResponseResult pass(@PathVariable Long id) {
        navCommentService.updateSticky(id, YesNo.YES.code);
        return ResponseResult.success();
    }

    @ApiOperation("取消置顶")
    @PutMapping("/cancelSticky/{id}")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "评论-取消置顶", businessType = BusinessType.UPDATE)
    public ResponseResult cancelSticky(@PathVariable Long id) {
        navCommentService.updateSticky(id, YesNo.NO.code);
        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{ids}")
    @ApiOperation("删除")
    @PreAuthorize("@auth.hasUrl()")
    @Log(moduleName = "评论", businessType = BusinessType.DELETE)
    public ResponseResult delete(@PathVariable Long[] ids) {
        navCommentService.removeByIds(Arrays.asList(ids));
        return ResponseResult.success();
    }

}
