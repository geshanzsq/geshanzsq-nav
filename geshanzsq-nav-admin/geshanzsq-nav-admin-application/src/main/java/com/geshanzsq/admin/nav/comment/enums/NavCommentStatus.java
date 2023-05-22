package com.geshanzsq.admin.nav.comment.enums;

/**
 * 评论状态
 *
 * @author geshanzsq
 * @date 2022/11/30
 */
public enum NavCommentStatus {

    /**
     * 审核中
     */
    AUDIT(1),

    /**
     * 已通过
     */
    PASS(2),

    /**
     * 已拒绝
     */
    REJECT(3)

    ;

    public final Integer code;

    NavCommentStatus(Integer code) {
        this.code = code;
    }
}
