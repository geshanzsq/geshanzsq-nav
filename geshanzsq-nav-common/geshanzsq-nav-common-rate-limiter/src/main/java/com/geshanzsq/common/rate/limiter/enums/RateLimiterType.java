package com.geshanzsq.common.rate.limiter.enums;

/**
 * 限流类型
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
public enum RateLimiterType {

    /**
     * 默认策略全局限流
     */
    DEFAULT,

    /**
     * 根据请求 IP 进行限流
     */
    IP,

    /**
     * 根据用户限流
     */
    USER

}
