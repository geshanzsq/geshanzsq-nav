package com.geshanzsq.web.controller.nav;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.geshanzsq.common.utils.SecurityUtils;
import com.geshanzsq.nav.enums.NavCommentStatusEnum;
import com.geshanzsq.nav.enums.NavCommentStickyEnum;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.geshanzsq.common.annotation.Log;
import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.enums.BusinessType;
import com.geshanzsq.nav.domain.NavComment;
import com.geshanzsq.nav.service.INavCommentService;
import com.geshanzsq.common.utils.poi.ExcelUtil;
import com.geshanzsq.common.core.page.TableDataInfo;

import javax.validation.Valid;

/**
 * 评论Controller
 * 
 * @author geshanzsq
 * @date 2021-06-23
 */
@RestController
@RequestMapping("/nav/comment")
public class NavCommentController extends BaseController
{
    @Autowired
    private INavCommentService navCommentService;

    /**
     * 查询评论列表
     */
    @PreAuthorize("@ss.hasPermi('nav:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(NavComment navComment)
    {
        startPage();
        List<NavComment> list = navCommentService.selectNavCommentList(navComment);
        return getDataTable(list);
    }

    /**
     * 导出评论列表
     */
    @PreAuthorize("@ss.hasPermi('nav:comment:export')")
    @Log(title = "评论", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(NavComment navComment)
    {
        List<NavComment> list = navCommentService.selectNavCommentList(navComment);
        ExcelUtil<NavComment> util = new ExcelUtil<NavComment>(NavComment.class);
        return util.exportExcel(list, "comment");
    }

    /**
     * 获取评论详细信息
     */
    @PreAuthorize("@ss.hasPermi('nav:comment:query')")
    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") Long commentId)
    {
        return AjaxResult.success(navCommentService.selectNavCommentById(commentId));
    }

    /**
     * 新增评论
     */
    @PostMapping("/addComment")
    public AjaxResult add(@Valid @RequestBody NavComment navComment)
    {
        String username = null;
        try {
            username = SecurityUtils.getUsername();
        } catch (Exception e) {}
        // 未登录
        if (StringUtils.isBlank(username)) {
            if (StringUtils.isBlank(navComment.getNickName())) {
                return AjaxResult.error("昵称不能为空");
            }
            if (StringUtils.isBlank(navComment.getEmail())) {
                return AjaxResult.error("邮箱不能为空！");
            }
            String regEx1 = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
            Pattern p = Pattern.compile(regEx1);
            Matcher m = p.matcher(navComment.getEmail());
            if (!m.matches()) {
                return AjaxResult.error("请输入正确的邮箱！");
            }
        }

        navComment.setCreateBy(username);
        navComment.setStatus(NavCommentStatusEnum.WAIT_AUDIT.code);
        boolean isAdmin = false;
        if (StringUtils.isNotBlank(username)) {
            // 是否为超级用户
            isAdmin = SecurityUtils.getLoginUser().getUser().isAdmin();
            if (isAdmin) {
                // 直接设置为通过
                navComment.setStatus(NavCommentStatusEnum.PASS.code);
            }
        }
        return toAjax(navCommentService.insertNavComment(navComment));
    }

    /**
     * 修改评论
     */
    @PreAuthorize("@ss.hasPermi('nav:comment:edit')")
    @Log(title = "评论", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NavComment navComment)
    {
        return toAjax(navCommentService.updateNavComment(navComment));
    }

    /**
     * 删除评论
     */
    @PreAuthorize("@ss.hasPermi('nav:comment:remove')")
    @Log(title = "评论", businessType = BusinessType.DELETE)
	@DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds)
    {
        return toAjax(navCommentService.deleteNavCommentByIds(commentIds));
    }


    /**
     * 通过评论
     */
    @PreAuthorize("@ss.hasPermi('nav:commment:pass')")
    @Log(title = "评论-通过", businessType = BusinessType.UPDATE)
    @PutMapping("/passComment")
    public AjaxResult passComment(@RequestBody NavComment comment) {
        if (comment.getCommentIds().length == 0) {
            return AjaxResult.error("请选择需要通过的评论");
        }
        String username = SecurityUtils.getUsername();
        for (Long commentId : comment.getCommentIds()) {
            NavComment oldComment = navCommentService.selectNavCommentById(commentId);
            if (oldComment == null) {
                continue;
            }
            // 不是待通过状态，直接跳过
            if ( !NavCommentStatusEnum.WAIT_AUDIT.code.equals(oldComment.getStatus())) {
                continue;
            }
            NavComment navComment = new NavComment();
            navComment.setCommentId(commentId);
            navComment.setUpdateBy(username);
            navComment.setStatus(NavCommentStatusEnum.PASS.code);
            navCommentService.updateNavComment(navComment);
        }
        return AjaxResult.success();
    }

    /**
     * 不通过评论
     */
    @PreAuthorize("@ss.hasPermi('nav:commment:noPass')")
    @Log(title = "评论-不通过", businessType = BusinessType.UPDATE)
    @PutMapping("/noPassComment")
    public AjaxResult noPassComment(@RequestBody NavComment comment) {
        if (comment.getCommentIds().length == 0) {
            return AjaxResult.error("请选择不通过的评论");
        }
        if (StringUtils.isBlank(comment.getReason())) {
            return AjaxResult.error("请输入不通过评论理由");
        }
        String username = SecurityUtils.getUsername();
        for (Long commentId : comment.getCommentIds()) {
            NavComment oldComment = navCommentService.selectNavCommentById(commentId);
            if (oldComment == null) {
                continue;
            }
            // 不是待通过状态，直接跳过
            if (NavCommentStatusEnum.NO_PASS.code.equals(oldComment.getStatus())) {
                continue;
            }
            NavComment navComment = new NavComment();
            navComment.setCommentId(commentId);
            navComment.setUpdateBy(username);
            navComment.setStatus(NavCommentStatusEnum.NO_PASS.code);
            navComment.setReason(comment.getReason());
            navCommentService.updateNavComment(navComment);
        }
        return AjaxResult.success();
    }

    /**
     * 置顶评论
     */
    @PreAuthorize("@ss.hasPermi('nav:commment:sticky')")
    @Log(title = "评论-置顶", businessType = BusinessType.UPDATE)
    @PutMapping("/stickyComment")
    public AjaxResult stickyComment(Long commentId) {
        NavComment oldComment = navCommentService.selectNavCommentById(commentId);
        if (oldComment == null) {
            return AjaxResult.error("未找到此评论记录");
        }
        // 已经置顶
        if (NavCommentStickyEnum.YES.code.equals(oldComment.getSticky())) {
            return AjaxResult.success();
        }
        // 不是通过状态
        if (!NavCommentStatusEnum.PASS.code.equals(oldComment.getStatus())) {
            return AjaxResult.error("评论通过后才能置顶哦！");
        }

        NavComment navComment = new NavComment();
        navComment.setCommentId(commentId);
        navComment.setUpdateBy(SecurityUtils.getUsername());
        navComment.setSticky(NavCommentStickyEnum.YES.code);
        navCommentService.updateNavComment(navComment);
        return AjaxResult.success();
    }
    /**
     * 取消置顶
     */
    @PreAuthorize("@ss.hasPermi('nav:commment:cancelSticky')")
    @Log(title = "评论-取消置顶", businessType = BusinessType.UPDATE)
    @PutMapping("/cancelStickyComment")
    public AjaxResult noSticky(Long commentId) {
        NavComment oldComment = navCommentService.selectNavCommentById(commentId);
        if (oldComment == null) {
            return AjaxResult.error("未找到此评论记录");
        }
        // 已经置顶
        if (NavCommentStickyEnum.NO.code.equals(oldComment.getSticky())) {
            return AjaxResult.success();
        }

        NavComment navComment = new NavComment();
        navComment.setCommentId(commentId);
        navComment.setUpdateBy(SecurityUtils.getUsername());
        navComment.setSticky(NavCommentStickyEnum.NO.code);
        navCommentService.updateNavComment(navComment);
        return AjaxResult.success();
    }
}
