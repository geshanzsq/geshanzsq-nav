package com.geshanzsq.common.core.exception;

import com.geshanzsq.common.core.constant.HttpStatus;
import lombok.Data;

/**
 * 基本异常
 *
 * @author geshanzsq
 * @date 2022/3/21
 */
@Data
public class BaseException extends RuntimeException {

    /**
     * 错误码
     */
    private int code;

    /**
     * 错误信息
     */
    private String message;

    /**
     * 所属模块
     */
    private String module;

    public BaseException(String message) {
        super(message);
        this.code = HttpStatus.FAIL;
    }

    public BaseException(int code, String message) {
        super(message);
        this.code = code;
    }

    public BaseException(int code, String message, Throwable e) {
        super(message, e);
        this.code = code;
    }

    public BaseException(String message, String module) {
        super(message);
        this.module = module;
    }

    public BaseException(int code, String message, String module) {
        super(message);
        this.code = code;
        this.module = module;
    }

    public BaseException(int code, String message, String module, Throwable e) {
        super(message, e);
        this.code = code;
        this.module = module;
    }

    @Override
    public String getMessage() {
        return super.getMessage();
    }


}
