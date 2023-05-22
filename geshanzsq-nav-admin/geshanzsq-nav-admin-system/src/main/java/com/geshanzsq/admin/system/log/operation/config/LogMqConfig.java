package com.geshanzsq.admin.system.log.operation.config;

import com.geshanzsq.admin.system.log.operation.mq.LogOperationMq;
import com.geshanzsq.common.log.constant.LogConstant;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;

/**
 * 日志消息中心配置，目前采用 Redis 消息队列方式
 *
 * @author geshanzsq
 * @date 2022/7/5
 */
@Configuration
public class LogMqConfig {

    /**
     * 监听器初始化
     */
    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(RedisConnectionFactory connectionFactory,
                                                                       MessageListenerAdapter messageListenerAdapter) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        container.addMessageListener(messageListenerAdapter, new PatternTopic(LogConstant.LOG_MQ_TOPIC));
        return container;
    }

    /**
     * 绑定消费者的接收方法
     */
    @Bean
    public MessageListenerAdapter messageListenerAdapter(LogOperationMq logOperationMq) {
        // 接收消息中心方法
        return new MessageListenerAdapter(logOperationMq, "consumeMqLog");
    }

}
