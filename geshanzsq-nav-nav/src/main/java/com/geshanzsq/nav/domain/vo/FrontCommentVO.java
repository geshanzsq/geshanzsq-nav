package com.geshanzsq.nav.domain.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 前台获取评论
 * @author geshanzsq
 * @date 2021/6/23
 */
@Data
public class FrontCommentVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 评论用户昵称 */
    private String nickName;

    /** 评论用户头像 */
    private String avatar;

    private Long commentId;

    /** 父级id */
    private Long parentId;

    /** 评论内容 */
    private String commentContent;

    /** 是否置顶，0否，1是 */
    private Integer sticky;

    /** 评论时间  */
    private Date commentTime;

    /** 是否为站长 */
    private Boolean webMaster;

    List<FrontCommentVO> children;

    public FrontCommentVO() {
    }
}
