package com.geshanzsq.framework.security.service.impl;

import com.geshanzsq.common.core.util.id.IdUtils;
import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.redis.service.RedisService;
import com.geshanzsq.framework.security.constant.SecurityConstant;
import com.geshanzsq.framework.security.domain.LoginUserDetail;
import com.geshanzsq.framework.security.property.TokenProperty;
import com.geshanzsq.framework.security.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * token 验证处理
 *
 * @author geshanzsq
 * @date 2022/3/23
 */
@Service
public class TokenServiceImpl implements TokenService {
    
    @Autowired
    private TokenProperty tokenProperty;

    @Autowired
    private RedisService redisService;

    /**
     * 创建登录令牌
     * @param loginUser 登录用户信息
     */
    @Override
    public String createLoginUser(LoginUserDetail loginUser) {
        // 生成令牌并去除横线
        String token = IdUtils.simpleUUID();
        // 设置用户信息到缓存
        setLoginUserCache(token, loginUser, tokenProperty.getExpireTime());
        return token;
    }

    /**
     * 获取登录用户信息
     */
    @Override
    public LoginUserDetail getLoginUser() {
        return getLoginUser(ServletUtils.getRequest());
    }

    /**
     * 获取登录用户信息
     * @param request
     */
    @Override
    public LoginUserDetail getLoginUser(HttpServletRequest request) {
        String token = getToken(request);
        if (StrUtils.isBlank(token)) {
            return null;
        }
        // 令牌标识
        String tokenKey = getTokenKey(token);
        Object loginUserObj = redisService.get(tokenKey);
        if (loginUserObj == null) {
            return null;
        }
        return (LoginUserDetail) loginUserObj;
    }

    /**
     * 删除登录用户
     * @param request
     * @param userId
     */
    @Override
    public boolean deleteLoginUser(HttpServletRequest request, Long userId) {
        String token = getToken(request);
        // 删除令牌
        String tokenKey = getTokenKey(token);
        redisService.delete(tokenKey);
        // 删除权限标识
        String refreshPermissionKey = getRefreshPermissionKey(userId, token);
        redisService.delete(refreshPermissionKey);
        return true;
    }

    /**
     * 设置刷新权限
     * @param userId 用户 id
     * @param token 令牌
     * @param hasRefresh 是否需要刷新
     */
    @Override
    public void setRefreshPermission(Long userId, String token, boolean hasRefresh) {
        String refreshKey = getRefreshPermissionKey(userId, token);
        redisService.set(refreshKey, hasRefresh, tokenProperty.getExpireTime(), TimeUnit.SECONDS);
    }

    /**
     * 设置需要刷新权限
     * @param userId 用户 id
     */
    @Override
    public void setNeedRefreshPermission(Long userId) {
        // 获取当前用户已登录的令牌键
        String refreshKey = getRefreshPermissionKey(userId, "*");
        Collection<String> refreshKeys = redisService.keys(refreshKey);
        for (String key : refreshKeys) {
            redisService.set(key, true, tokenProperty.getExpireTime(), TimeUnit.SECONDS);
        }
    }

    /**
     * 设置需要刷新权限
     * @param userIds 用户 id 集合
     */
    @Override
    public void setNeedRefreshPermission(List<Long> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            return;
        }
        for (Long userId : userIds) {
            setNeedRefreshPermission(userId);
        }
    }

    /**
     * 是否需要刷新权限
     * @param userId 用户 id
     * @param token 令牌
     */
    @Override
    public boolean hasRefreshPermission(Long userId, String token) {
        String refreshKey = getRefreshPermissionKey(userId, token);
        Boolean hasRefresh = redisService.get(refreshKey);
        return hasRefresh == null ? false : hasRefresh;
    }

    /**
     * 设置用户信息到缓存
     * @param token 令牌
     * @param loginUser 用户信息
     * @param expire 过期时间，单位为秒
     */
    @Override
    public void setLoginUserCache(String token, LoginUserDetail loginUser, long expire) {
        String tokenKey = getTokenKey(token);
        // 设置登录时间和过期时间
        Date nowDate = new Date();
        loginUser.setLoginTime(nowDate.getTime());
        loginUser.setExpireTime(nowDate.getTime() + expire * 1000);
        redisService.set(tokenKey, loginUser, expire, TimeUnit.SECONDS);
        // 设置用户不需要刷新权限，用于后续获取动态权限，当权限发生变动时，不刷新就能生效，刚登录时设置为 false，为后续变动权限做准备，以免设置大量未登录的用户
        setRefreshPermission(loginUser.getUserId(), token, false);
    }

    /**
     * 获取令牌过期时间
     * @param token 令牌
     */
    @Override
    public Long getTokenExpireTime(String token) {
        String tokenKey = getTokenKey(token);
        return redisService.getExpireTime(tokenKey);
    }

    /**
     * 获取令牌
     */
    @Override
    public String getToken() {
        return getToken(ServletUtils.getRequest());
    }

    /**
     * 获取令牌
     * @param request
     */
    public String getToken(HttpServletRequest request) {
        String token = request.getHeader(tokenProperty.getHeader());
        // 如果请求头为空，则从参数中获取
        if (StrUtils.isBlank(token)) {
            token = request.getParameter(tokenProperty.getTokenParam());
        } else {
            // 去除前缀
            token = token.replace(tokenProperty.getTokenPrefix() + " ", "");
        }
        return token;
    }

    /**
     * 获取令牌标识
     * @param token 令牌
     */
    private String getTokenKey(String token) {
        String tokenPrefix = StrUtils.isBlank(tokenProperty.getTokenRedisPrefix())
                ? SecurityConstant.TOKEN_PREFIX : tokenProperty.getTokenRedisPrefix();
        return tokenPrefix + token;
    }

    /**
     * 获取刷新令牌标识
     * @param userId
     * @param token
     */
    private String getRefreshPermissionKey(Long userId, String token) {
        String permissionRefreshPrefix = StrUtils.isBlank(tokenProperty.getPermissionRefreshRedisPrefix())
                ? SecurityConstant.PERMISSION_REFRESH_PREFIX : tokenProperty.getPermissionRefreshRedisPrefix();
        return permissionRefreshPrefix + userId + ":" + token;
    }
}
