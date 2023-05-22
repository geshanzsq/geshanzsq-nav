package com.geshanzsq.admin.nav.comment.service;

import com.geshanzsq.admin.client.nav.dto.ClientNavCommentAddDTO;
import com.geshanzsq.admin.client.nav.vo.ClientNavCommentTreeVO;
import com.geshanzsq.admin.nav.comment.dto.NavCommentPageDTO;
import com.geshanzsq.admin.nav.comment.dto.NavCommentRejectDTO;
import com.geshanzsq.admin.nav.comment.po.NavComment;
import com.geshanzsq.admin.nav.comment.vo.NavCommentVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.service.BaseService;

import java.util.List;

/**
 * 评论
 *
 * @author geshanzsq
 * @date 2022/11/29
 */
public interface NavCommentService extends BaseService<NavComment> {

    /**
     * 分页列表
     */
    PageVO<NavCommentVO> pageList(NavCommentPageDTO pageDTO);

    /**
     * 通过
     */
    void pass(Long[] ids);

    /**
     * 驳回
     */
    void reject(NavCommentRejectDTO rejectDTO);

    /**
     * 更新置顶
     *
     * @param id 评论 id
     * @param hasSticky 是否置顶
     */
    void updateSticky(Long id, Integer hasSticky);

    /**
     * 获取评论开启状态
     */
    boolean getOpenStatus();

    /**
     * 是否开启不用登录就能提交评论
     */
    boolean getNotLoginOpenStatus();

    /**
     * 树形列表
     */
    List<ClientNavCommentTreeVO> treeClient();

    /**
     * 新增
     */
    void add(ClientNavCommentAddDTO addDTO);
}
