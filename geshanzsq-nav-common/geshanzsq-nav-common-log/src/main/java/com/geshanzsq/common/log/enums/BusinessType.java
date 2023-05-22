package com.geshanzsq.common.log.enums;

/**
 * 业务类型
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
public enum BusinessType {

    /**
     * 其他
     */
    OTHER(1),

    /**
     * 新增
     */
    ADD(2),

    /**
     * 修改
     */
    UPDATE(3),

    /**
     * 删除
     */
    DELETE(4)
    ;

    public final Integer code;

    BusinessType(Integer code) {
        this.code = code;
    }
}
