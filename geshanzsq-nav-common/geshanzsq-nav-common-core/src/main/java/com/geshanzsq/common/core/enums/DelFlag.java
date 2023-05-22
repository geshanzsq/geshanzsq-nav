package com.geshanzsq.common.core.enums;

/**
 * 删除枚举
 *
 * @author geshanzsq
 * @date 2022/6/18
 */
public enum DelFlag {

    /**
     * 未删除
     */
    NO_DELETE(1),

    /**
     * 已删除
     */
    DELETE(2)
    ;

    public final Integer code;

    DelFlag(Integer code) {
        this.code = code;
    }
}
