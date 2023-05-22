package com.geshanzsq.common.rate.limiter.aspect;

import com.geshanzsq.common.core.util.ip.IpUtils;
import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.rate.limiter.annotation.RateLimiter;
import com.geshanzsq.common.rate.limiter.constant.RateLimitConstant;
import com.geshanzsq.common.rate.limiter.enums.RateLimiterType;
import com.geshanzsq.common.rate.limiter.exception.RateLimiterException;
import com.geshanzsq.common.redis.service.RedisService;
import com.geshanzsq.framework.security.util.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 限流
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
@Component
@Aspect
public class RateLimiterAspect {

    @Autowired
    private RedisService redisService;

    @Before("@annotation(rateLimiter)")
    public void doBefore(JoinPoint joinPoint, RateLimiter rateLimiter) {
        // 获取限流标识
        String limitKey = getLimitKey(joinPoint, rateLimiter);
        boolean isLimit = redisService.limit(limitKey, rateLimiter.time(), rateLimiter.count());
        if (isLimit) {
            throw new RateLimiterException(rateLimiter.hintMessage());
        }
    }

    /**
     * 获取限流标识
     */
    private String getLimitKey(JoinPoint joinPoint, RateLimiter rateLimiter) {
        if (StrUtils.isNotBlank(rateLimiter.key())) {
            return RateLimitConstant.CACHE_PREFIX + rateLimiter.key();
        }
        // 获取注解作用域的类名和方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        String limitKey = RateLimitConstant.CACHE_PREFIX + className.replace(".", ":") + methodName;
        switch (rateLimiter.type()) {
            case IP: {
                // ip 地址
                String ip = IpUtils.getIpAddr(ServletUtils.getRequest());
                return limitKey + ":" + ip.split(",")[0];
            }
            case USER: {
                return limitKey + ":" + SecurityUtils.getUserId();
            }
            default: {
                return limitKey;
            }
        }
    }

}
