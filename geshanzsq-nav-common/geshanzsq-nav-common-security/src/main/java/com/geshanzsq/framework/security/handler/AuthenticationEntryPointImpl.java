package com.geshanzsq.framework.security.handler;

import com.geshanzsq.common.core.constant.HttpStatus;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.framework.security.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 认证失败处理，返回未认证
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
@Component
public class AuthenticationEntryPointImpl implements AuthenticationEntryPoint {


    @Autowired
    private TokenService tokenService;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
        int code = HttpStatus.UNAUTHORIZED;
        // 默认未登录
        String message = MessageUtils.message("security.not.login");
        String token = tokenService.getToken();
        // 如果存在令牌，则提示登录已过期
        if (StrUtils.isNotBlank(token)) {
            message = MessageUtils.message("security.login.expire");
        }

        ServletUtils.renderString(ResponseResult.fail(code, message), response);
    }
}
