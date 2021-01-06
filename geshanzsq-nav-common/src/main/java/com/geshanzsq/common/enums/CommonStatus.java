package com.geshanzsq.common.enums;

/**
 * 公共状态
 * @author geshanzsq
 * @date 2020/7/28
 */
public enum CommonStatus {
    OK(0, "正常"),DISABLE(1, "停用"),DELETE(2,"删除");

    public final Integer code;
    public final String info;

    CommonStatus(Integer code, String info)
    {
        this.code = code;
        this.info = info;
    }
}
