package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.nav.domain.vo.FrontCommentVO;
import com.geshanzsq.nav.service.INavCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 前台获取评论
 * @author geshanzsq
 * @date 2021/6/23
 */
@RequestMapping("/frontNav/comment")
@RestController
public class FrontCommentController extends BaseController {

    @Autowired
    private INavCommentService commentService;

    @GetMapping("/getCommentList")
    public AjaxResult getCommentList() {
        List<FrontCommentVO> list = commentService.getFrontComment();
        AjaxResult ajaxResult = AjaxResult.success(commentService.buildTree(list));
        ajaxResult.put("rows",list.size());
        return ajaxResult;
    }


}
