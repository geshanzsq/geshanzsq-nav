package com.geshanzsq.admin.core.security.auth.service.impl;

import com.geshanzsq.admin.core.captcha.constant.CaptchaConstant;
import com.geshanzsq.admin.core.security.auth.dto.AuthLoginDTO;
import com.geshanzsq.admin.core.security.auth.service.AuthService;
import com.geshanzsq.admin.core.security.auth.vo.AuthLoginVO;
import com.geshanzsq.admin.system.log.login.enums.LogLoginStatus;
import com.geshanzsq.admin.system.log.login.factory.LogLoginAsyncFactory;
import com.geshanzsq.admin.system.user.service.SysUserService;
import com.geshanzsq.common.core.exception.ServiceException;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.framework.manager.AsyncManager;
import com.geshanzsq.common.redis.service.RedisService;
import com.geshanzsq.framework.security.domain.LoginUserDetail;
import com.geshanzsq.framework.security.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

/**
 * 认证中心
 *
 * @author geshanzsq
 * @date 2022/5/3
 */
@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private TokenService tokenService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private RedisService redisService;

    /**
     * 登录
     */
    @Override
    public AuthLoginVO login(AuthLoginDTO authLoginDTO) {
        // 校验登录验证码
        verifyLoginCode(authLoginDTO);

        Authentication authentication = null;
        // 用户名
        String username = authLoginDTO.getUsername();
        // 密码
        String password = authLoginDTO.getPassword();

        try {
            // 该方法会调用 UserDetailsServiceImpl.loadUserByUsername
            authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (Exception e) {
            if (e instanceof BadCredentialsException) {
                String message = MessageUtils.message("login.username.password.not.match");
                // 异步记录登录日志
                AsyncManager.me().execute(LogLoginAsyncFactory.add(username, LogLoginStatus.FAIL.code, message));
                throw new ServiceException(message);
            } else if (e instanceof InternalAuthenticationServiceException) {
                String message = e.getMessage();
                // 异步记录登录日志
                AsyncManager.me().execute(LogLoginAsyncFactory.add(username, LogLoginStatus.FAIL.code, message));
                throw new ServiceException(message);
            } else {
                String message = e.getMessage();
                // 异步记录登录日志
                AsyncManager.me().execute(LogLoginAsyncFactory.add(username, LogLoginStatus.FAIL.code, message));
                throw new RuntimeException(message);
            }
        }

        // 获取用户
        LoginUserDetail loginUserDetail = (LoginUserDetail) authentication.getPrincipal();
        // 设置用户权限
        sysUserService.setLoginUserPermission(loginUserDetail);
        // 创建令牌
        String token = tokenService.createLoginUser(loginUserDetail);
        AuthLoginVO authLoginVO = new AuthLoginVO();
        authLoginVO.setToken(token);
        // 异步记录登录日志
        AsyncManager.me().execute(LogLoginAsyncFactory.add(loginUserDetail.getUserId(), username, LogLoginStatus.SUCCESS.code,
                MessageUtils.message("login.success")));
        return authLoginVO;
    }

    /**
     * 校验登录验证码
     */
    private void verifyLoginCode(AuthLoginDTO authLoginDTO) {
        String verifyKey = CaptchaConstant.CAPTCHA_CODE_KEY + authLoginDTO.getUuid();
        String captcha = redisService.get(verifyKey);
        redisService.delete(verifyKey);
        if (captcha == null) {
            // 异步记录登录日志
            String message = MessageUtils.message("login.captcha.expire");
            AsyncManager.me().execute(LogLoginAsyncFactory.add(
                    authLoginDTO.getUsername(), LogLoginStatus.FAIL.code, message));
            throw new ServiceException(message);
        }
        if (!authLoginDTO.getCode().equalsIgnoreCase(captcha)) {
            String message = MessageUtils.message("login.captcha.error");
            // 异步记录登录日志
            AsyncManager.me().execute(LogLoginAsyncFactory.add(
                    authLoginDTO.getUsername(), LogLoginStatus.FAIL.code, message));
            throw new ServiceException(message);
        }
    }

}
