package com.geshanzsq.admin.system.user.enums;

/**
 * 用户类型
 *
 * @author geshanzsq
 * @date 2022/10/7
 */
public enum UserType {

    /**
     * 后台用户
     */
    ADMIN(1),

    /**
     * 导航用户
     */
    NAV(2)
    ;

    public final Integer code;

    UserType(Integer code) {
        this.code = code;
    }
}
