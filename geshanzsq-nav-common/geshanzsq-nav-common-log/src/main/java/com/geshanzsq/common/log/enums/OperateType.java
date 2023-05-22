package com.geshanzsq.common.log.enums;

/**
 * 操作类型
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
public enum OperateType {
    /**
     * 其他
     */
    OTHER(1),

    /**
     * 后台用户
     */
    ADMIN(2),

    /**
     * 手机端用户
     */
    MOBILE(3),

    /**
     * 导航用户
     */
    NAV(4)
    ;


    public final Integer code;

    OperateType(Integer code) {
        this.code = code;
    }
}
