package com.geshanzsq.nav.enums;

/**
 * @author geshanzsq
 * @date 2021/1/24
 */
public enum NavCommentStickyEnum {

    NO(0,"不置顶"),
    YES(1,"置顶");

    public final Integer code;
    public final String info;

    NavCommentStickyEnum(Integer code, String info) {
        this.code = code;
        this.info = info;
    }
}
