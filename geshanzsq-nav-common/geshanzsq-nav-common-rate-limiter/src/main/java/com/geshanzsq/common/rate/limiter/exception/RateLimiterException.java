package com.geshanzsq.common.rate.limiter.exception;

/**
 * 限流异常
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
public class RateLimiterException extends RuntimeException {

    /**
     * 错误信息
     */
    private String message;


    public RateLimiterException(String message) {
        super(message);
        this.message = message;
    }

    public RateLimiterException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }


}
