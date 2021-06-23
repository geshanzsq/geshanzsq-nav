package com.geshanzsq.nav.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import com.geshanzsq.common.utils.DateUtils;
import com.geshanzsq.nav.domain.vo.FrontCommentVO;
import com.geshanzsq.nav.enums.NavCommentStatusEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.geshanzsq.nav.mapper.NavCommentMapper;
import com.geshanzsq.nav.domain.NavComment;
import com.geshanzsq.nav.service.INavCommentService;

/**
 * 评论Service业务层处理
 * 
 * @author geshanzsq
 * @date 2021-06-23
 */
@Service
public class NavCommentServiceImpl implements INavCommentService 
{
    @Autowired
    private NavCommentMapper navCommentMapper;

    /**
     * 查询评论
     * 
     * @param commentId 评论ID
     * @return 评论
     */
    @Override
    public NavComment selectNavCommentById(Long commentId)
    {
        return navCommentMapper.selectNavCommentById(commentId);
    }

    /**
     * 查询评论列表
     * 
     * @param navComment 评论
     * @return 评论
     */
    @Override
    public List<NavComment> selectNavCommentList(NavComment navComment)
    {
        return navCommentMapper.selectNavCommentList(navComment);
    }

    /**
     * 新增评论
     * 
     * @param navComment 评论
     * @return 结果
     */
    @Override
    public int insertNavComment(NavComment navComment)
    {
        navComment.setCreateTime(DateUtils.getNowDate());
        return navCommentMapper.insertNavComment(navComment);
    }

    /**
     * 修改评论
     * 
     * @param navComment 评论
     * @return 结果
     */
    @Override
    public int updateNavComment(NavComment navComment)
    {
        navComment.setUpdateTime(DateUtils.getNowDate());
        return navCommentMapper.updateNavComment(navComment);
    }

    /**
     * 批量删除评论
     * 
     * @param commentIds 需要删除的评论ID
     * @return 结果
     */
    @Override
    public int deleteNavCommentByIds(Long[] commentIds)
    {
        return navCommentMapper.deleteNavCommentByIds(commentIds);
    }

    /**
     * 删除评论信息
     * 
     * @param commentId 评论ID
     * @return 结果
     */
    @Override
    public int deleteNavCommentById(Long commentId)
    {
        return navCommentMapper.deleteNavCommentById(commentId);
    }


    /**
     * 获取前台评论
     */
    @Override
    public List<FrontCommentVO> getFrontComment() {
        NavComment navComment = new NavComment();
        navComment.setStatus(NavCommentStatusEnum.PASS.code);
        return navCommentMapper.selectFrontComment(navComment);
    }

    /**
     * 构造树形结构
     */
    @Override
    public List<FrontCommentVO> buildTree(List<FrontCommentVO> list) {
        List<FrontCommentVO> resultList = buildCommentTree(list);
        return resultList;
    }

    private List<FrontCommentVO> buildCommentTree(List<FrontCommentVO> list) {
        List<FrontCommentVO> resultList = new ArrayList<>();
        for (Iterator<FrontCommentVO> iterator = list.iterator(); iterator.hasNext();) {
            FrontCommentVO comment = iterator.next();
            if (comment.getParentId() == 0) {
                recursionFn(list,comment);
                resultList.add(comment);
            }
        }
        if (resultList.isEmpty()) {
            resultList = list;
        }
        return resultList;
    }

    /**
     * 递归获取
     */
    private void recursionFn(List<FrontCommentVO> list, FrontCommentVO t) {
        List<FrontCommentVO> childrenList = getChildrenList(list, t);
        t.setChildren(childrenList);
        for (FrontCommentVO children : childrenList) {
            List<FrontCommentVO> tChildren = getChildrenList(list, children);
            if (tChildren.size() > 0) {
                recursionFn(list,children);
            }
        }
    }

    /**
     * 获取子节点
     */
    private List<FrontCommentVO> getChildrenList(List<FrontCommentVO> list, FrontCommentVO t) {
        List<FrontCommentVO> childrenList = new ArrayList<>();
        for (FrontCommentVO children : list) {
            if (t.getCommentId().equals(children.getParentId())) {
                childrenList.add(children);
            }
        }
        return childrenList;
    }
}
