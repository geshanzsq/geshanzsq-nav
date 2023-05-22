package com.geshanzsq.common.log.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.geshanzsq.common.log.constant.LogConstant;
import com.geshanzsq.common.log.dto.LogDTO;
import com.geshanzsq.common.log.service.LogMqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

/**
 * 日志消息中心
 *
 * @author geshanzsq
 * @date 2022/7/5
 */
@Service
public class LogMqServiceImpl implements LogMqService {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    /**
     * 添加日志消息中心
     */
    @Override
    public void addLogToMq(LogDTO logDTO) {
        stringRedisTemplate.convertAndSend(LogConstant.LOG_MQ_TOPIC, JSONObject.toJSONString(logDTO));
    }
}
