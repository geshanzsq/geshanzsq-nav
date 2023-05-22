package com.geshanzsq.common.core.enums;

/**
 * 通用状态枚举
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
public enum CommonStatus {

    /**
     * 正常
     */
    NORMAL(1),

    /**
     * 停用
     */
    DISABLE(2)
    ;

    public final Integer code;

    CommonStatus(Integer code) {
        this.code = code;
    }
}
