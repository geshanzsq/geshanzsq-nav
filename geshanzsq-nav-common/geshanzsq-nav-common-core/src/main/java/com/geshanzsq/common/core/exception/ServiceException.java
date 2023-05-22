package com.geshanzsq.common.core.exception;

import com.geshanzsq.common.core.constant.HttpStatus;
import lombok.Data;

/**
 * 服务异常
 *
 * @author geshanzsq
 * @date 2022/3/21
 */
@Data
public class ServiceException extends RuntimeException {

    /**
     * 错误码
     */
    private int code;

    /**
     * 错误信息
     */
    private String message;

    public ServiceException(String message) {
        super(message);
        this.code = HttpStatus.FAIL;
        this.message = message;
    }

    public ServiceException(int code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public ServiceException(String message, Throwable e) {
        super(message, e);
        this.code = HttpStatus.FAIL;
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }
}
