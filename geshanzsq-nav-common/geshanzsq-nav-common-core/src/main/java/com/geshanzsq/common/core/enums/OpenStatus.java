package com.geshanzsq.common.core.enums;

/**
 * 开启状态
 *
 * @author geshanzsq
 * @date 2022/10/7
 */
public enum OpenStatus {
    /**
     * 开始
     */
    YES(1),

    /**
     * 不开启
     */
    NO(2)
    ;

    public final Integer code;

    OpenStatus(Integer code) {
        this.code = code;
    }
}
