package com.geshanzsq.common.framework.thread.property;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 线程池相关配置
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "thread")
public class ThreadPoolProperty {

    /**
     * 核心线程池大小
     */
    private int corePoolSize = 50;

    /**
     * 最大可创建的线程数
     */
    private int maxPoolSize = 200;

    /**
     * 队列最大长度
     */
    private int queueCapacity = 1000;

    /**
     * 线程池维护线程所允许的空闲时间
     */
    private int keepAliveSeconds = 300;

}
