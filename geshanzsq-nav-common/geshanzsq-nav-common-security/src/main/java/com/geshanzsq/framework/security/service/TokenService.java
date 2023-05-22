package com.geshanzsq.framework.security.service;

import com.geshanzsq.framework.security.domain.LoginUserDetail;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * token 验证处理
 *
 * @author geshanzsq
 * @date 2022/3/23
 */
public interface TokenService {

    /**
     * 创建登录令牌
     * @param loginUser 登录用户信息
     */
    String createLoginUser(LoginUserDetail loginUser);

    /**
     * 获取登录用户信息
     */
    LoginUserDetail getLoginUser();

    /**
     * 获取登录用户信息
     * @param request
     */
    LoginUserDetail getLoginUser(HttpServletRequest request);

    /**
     * 删除登录用户
     * @param request
     * @param userId
     */
    boolean deleteLoginUser(HttpServletRequest request, Long userId);

    /**
     * 设置刷新权限
     * @param userId 用户 id
     * @param token 令牌
     * @param hasRefresh 是否需要刷新
     */
    void setRefreshPermission(Long userId, String token, boolean hasRefresh);

    /**
     * 设置需要刷新权限
     * @param userId 用户 id
     */
    void setNeedRefreshPermission(Long userId);

    /**
     * 设置需要刷新权限
     * @param userIds 用户 id 集合
     */
    void setNeedRefreshPermission(List<Long> userIds);

    /**
     * 是否需要刷新权限
     * @param userId 用户 id
     * @param token 令牌
     */
    boolean hasRefreshPermission(Long userId, String token);

    /**
     * 设置用户信息到缓存
     * @param token 令牌
     * @param loginUser 用户信息
     * @param expire 过期时间，单位为秒
     */
    void setLoginUserCache(String token, LoginUserDetail loginUser, long expire);

    /**
     * 获取令牌过期时间
     * @param token 令牌
     */
    Long getTokenExpireTime(String token);

    /**
     * 获取令牌
     */
    String getToken();

}
