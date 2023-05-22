package com.geshanzsq.common.rate.limiter.annotation;

import com.geshanzsq.common.rate.limiter.enums.RateLimiterType;

import java.lang.annotation.*;

/**
 * 限流
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimiter {

    /**
     * 限流 key，如果知道了 key，则限流类型为全局
     */
    String key() default "";

    /**
     * 限流类型
     */
    RateLimiterType type() default RateLimiterType.DEFAULT;

    /**
     * 限流时间，单位秒
     */
    public int time() default 60;

    /**
     * 限流次数
     */
    public int count() default 10;

    /**
     * 提示语
     */
    String hintMessage() default "操作频繁，请稍后再试";

}
