package com.geshanzsq.admin.system.menu.enums;

/**
 * 显示状态
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
public enum MenuShowStatus {

    /**
     * 显示
     */
    SHOW(1),

    /**
     * 隐藏
     */
    HIDDEN(2)
    ;


    public final Integer code;

    MenuShowStatus(Integer code) {
        this.code = code;
    }
}
