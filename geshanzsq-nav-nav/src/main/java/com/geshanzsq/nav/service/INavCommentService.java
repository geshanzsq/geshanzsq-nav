package com.geshanzsq.nav.service;

import java.util.List;
import com.geshanzsq.nav.domain.NavComment;
import com.geshanzsq.nav.domain.vo.FrontCommentVO;

/**
 * 评论Service接口
 * 
 * @author geshanzsq
 * @date 2021-06-23
 */
public interface INavCommentService 
{
    /**
     * 查询评论
     * 
     * @param commentId 评论ID
     * @return 评论
     */
    public NavComment selectNavCommentById(Long commentId);

    /**
     * 查询评论列表
     * 
     * @param navComment 评论
     * @return 评论集合
     */
    public List<NavComment> selectNavCommentList(NavComment navComment);

    /**
     * 新增评论
     * 
     * @param navComment 评论
     * @return 结果
     */
    public int insertNavComment(NavComment navComment);

    /**
     * 修改评论
     * 
     * @param navComment 评论
     * @return 结果
     */
    public int updateNavComment(NavComment navComment);

    /**
     * 批量删除评论
     * 
     * @param commentIds 需要删除的评论ID
     * @return 结果
     */
    public int deleteNavCommentByIds(Long[] commentIds);

    /**
     * 删除评论信息
     * 
     * @param commentId 评论ID
     * @return 结果
     */
    public int deleteNavCommentById(Long commentId);

    /**
     * 获取前台评论
     */
    public List<FrontCommentVO> getFrontComment();

    /**
     * 构造树形结构
     */
    List<FrontCommentVO> buildTree(List<FrontCommentVO> list);
}
