package com.geshanzsq.admin.core.config;

import com.geshanzsq.common.framework.mybatis.plugin.interceptor.InsertUpdateMyBatisInterceptor;
import com.geshanzsq.framework.security.util.SecurityUtils;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;
import org.springframework.stereotype.Component;

/**
 * MyBatis 插入更新拦截器配置
 *
 * @author geshanzsq
 * @date 2022/8/7
 */
@Intercepts({
        @Signature(type = Executor.class, method = "update", args = {
                MappedStatement.class, Object.class
        })
})
@Component
public class InsertUpdateMyBatisInterceptorConfig implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        // 当前用户 id
        Long currentUserId = null;
        try {
            currentUserId = SecurityUtils.getUserId();
        } catch (Exception e) {
        }
        // 调用拦截器
        return InsertUpdateMyBatisInterceptor.intercept(invocation, currentUserId);
    }
}
