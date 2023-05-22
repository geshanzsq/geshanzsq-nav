package com.geshanzsq.common.core.exception;

import lombok.Data;

/**
 * 服务异常
 *
 * @author geshanzsq
 * @date 2022/3/21
 */
@Data
public class ParamException extends RuntimeException {

    /**
     * 错误信息
     */
    private String message;

    public ParamException(String message) {
        super(message);
        this.message = message;
    }

    public ParamException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }
}
