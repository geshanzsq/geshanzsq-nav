package com.geshanzsq.nav.domain;

import com.geshanzsq.common.annotation.Excel;
import com.geshanzsq.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 评论对象 nav_comment
 * 
 * @author geshanzsq
 * @date 2021-06-23
 */
public class NavComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评论id */
    private Long commentId;

    /** 父级id */
    @Excel(name = "父级id")
    private Long parentId;

    /** 评论内容 */
    @Excel(name = "评论内容")
    private String commentContent;

    /** 是否置顶，0否，1是 */
    @Excel(name = "是否置顶，0否，1是")
    private Integer sticky;

    /** 昵称 */
    @Excel(name = "昵称")
    private String nickName;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 不通过理由 */
    @Excel(name = "不通过理由")
    private String reason;

    /** 状态，0 待审核，1 通过，2 不通过 */
    @Excel(name = "状态，0 待审核，1 通过，2 不通过")
    private Integer status;

    /** 评论id数组 */
    private Long[] commentIds;

    public void setCommentId(Long commentId) 
    {
        this.commentId = commentId;
    }

    public Long getCommentId() 
    {
        return commentId;
    }
    public void setParentId(Long parentId) 
    {
        this.parentId = parentId;
    }

    public Long getParentId() 
    {
        return parentId;
    }
    public void setCommentContent(String commentContent) 
    {
        this.commentContent = commentContent;
    }

    public String getCommentContent() 
    {
        return commentContent;
    }
    public void setSticky(Integer sticky)
    {
        this.sticky = sticky;
    }

    public Integer getSticky()
    {
        return sticky;
    }
    public void setNickName(String nickName) 
    {
        this.nickName = nickName;
    }

    public String getNickName() 
    {
        return nickName;
    }
    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }
    public void setReason(String reason) 
    {
        this.reason = reason;
    }

    public String getReason() 
    {
        return reason;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public Long[] getCommentIds() {
        return commentIds;
    }

    public void setCommentIds(Long[] commentIds) {
        this.commentIds = commentIds;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("commentId", getCommentId())
            .append("parentId", getParentId())
            .append("commentContent", getCommentContent())
            .append("sticky", getSticky())
            .append("nickName", getNickName())
            .append("email", getEmail())
            .append("reason", getReason())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("status", getStatus())
            .append("commentIds", getCommentIds())
            .toString();
    }
}
