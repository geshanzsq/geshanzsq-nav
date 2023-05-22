package com.geshanzsq.framework.security.domain;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;

/**
 * 登录用户身份
 *
 * @author geshanzsq
 * @date 2022/3/20
 */
@Data
public class LoginUserDetail implements UserDetails {

    /**
     * 用户 id
     */
    private Long userId;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 用户登录 token
     */
    private String token;

    /**
     * 登录时间
     */
    private long loginTime;

    /**
     * 过期时间
     */
    private long expireTime;

    /**
     * 权限列表
     */
    private Set<String> permissionCodes = new HashSet<>();

    /**
     * 接口权限列表
     */
    private List<ApiPermission> apiPermissions = new ArrayList<>();

    /**
     * 角色编码
     */
    private Set<String> roleCodes = new HashSet<>();

    /**
     * 是否为超级管理员
     */
    private boolean hasSuperAdmin;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
