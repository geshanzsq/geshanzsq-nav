package com.geshanzsq.nav.enums;

/**
 * 评论状态枚举
 * @author geshanzsq
 * @date 2021/6/23
 */
public enum NavCommentStatusEnum {

    WAIT_AUDIT(0, "待审核"),
    PASS(1, "通过"),
    NO_PASS(2,"不通过");

    public final Integer code;
    public final String info;

    NavCommentStatusEnum(Integer code, String info)
    {
        this.code = code;
        this.info = info;
    }
}
