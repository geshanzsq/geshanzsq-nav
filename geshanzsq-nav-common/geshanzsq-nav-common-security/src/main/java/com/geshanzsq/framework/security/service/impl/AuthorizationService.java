package com.geshanzsq.framework.security.service.impl;

import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.framework.security.domain.ApiPermission;
import com.geshanzsq.framework.security.domain.LoginUserDetail;
import com.geshanzsq.framework.security.util.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Geshanzsq 首创，实现自定义权限，auth 取自 Authorization
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@Service("auth")
public class AuthorizationService {

    private AntPathMatcher antPathMatcher = new AntPathMatcher();

    /**
     * 验证是否拥有当前请求地址的访问权限
     */
    public boolean hasUrl() {
        // 请求地址
        HttpServletRequest request = ServletUtils.getRequest();
        String requestPath = request.getServletPath();
        // 当前登录用户
        LoginUserDetail loginUser = SecurityUtils.getLoginUser();

        // 如果是超级管理员，直接返回
        if (loginUser.isHasSuperAdmin()) {
            return true;
        }
        // 校验请求权限
        return verifyUrlPermission(requestPath, loginUser.getApiPermissions());
    }

    /**
     * 验证是否有权限标识
     */
    public boolean hasPerm(String permissionCode) {
        if (StrUtils.isBlank(permissionCode)) {
            return false;
        }

        // 当前登录用户
        LoginUserDetail loginUser = SecurityUtils.getLoginUser();
        // 如果是超级管理员，直接返回
        if (loginUser.isHasSuperAdmin()) {
            return true;
        }

        // 验证权限标识
        for (String targetPermissionCode : loginUser.getPermissionCodes()) {
            if (permissionCode.equals(targetPermissionCode)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 验证是否有某个角色
     * @param roleCode
     */
    public boolean hasRole(String roleCode) {
        if (StrUtils.isBlank(roleCode)) {
            return false;
        }
        // 当前登录用户
        LoginUserDetail loginUser = SecurityUtils.getLoginUser();
        for (String targetRoleCode : loginUser.getRoleCodes()) {
            if (roleCode.equals(targetRoleCode)) {
                return true;
            }
        }
        return false;
    }


    /**
     * 验证是否包含有请求权限
     * @param requestPath 请求地址
     * @param apiPermissions 所拥有的接口权限
     */
    private boolean verifyUrlPermission(String requestPath, List<ApiPermission> apiPermissions) {
        // 没有所拥有的权限
        if (CollectionUtils.isEmpty(apiPermissions)) {
            return false;
        }
        HttpServletRequest request = ServletUtils.getRequest();
        // 开始验证
        for (ApiPermission apiPermission : apiPermissions) {
            // 权限地址
            String apiUrl = apiPermission.getApiUrl();
            String apiMethod = apiPermission.getApiMethod();
            // 如果地址匹配并且请求方式也一致，直接返回
            if (antPathMatcher.matchStart(apiUrl, requestPath) && request.getMethod().equalsIgnoreCase(apiMethod)) {
                return true;
            }

        }
        return false;
    }

}
