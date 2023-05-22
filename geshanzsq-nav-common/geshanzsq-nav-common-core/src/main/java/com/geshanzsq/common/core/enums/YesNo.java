package com.geshanzsq.common.core.enums;

/**
 * 是否枚举
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
public enum YesNo {

    /**
     * 是
     */
    YES(1),

    /**
     * 否
     */
    NO(2)
    ;

    public final Integer code;

    YesNo(Integer code) {
        this.code = code;
    }
}
