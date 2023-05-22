package com.geshanzsq.admin.core.security.auth.service;

import com.geshanzsq.admin.core.security.auth.dto.AuthLoginDTO;
import com.geshanzsq.admin.core.security.auth.vo.AuthLoginVO;

/**
 * 认证中心
 *
 * @author geshanzsq
 * @date 2022/5/3
 */
public interface AuthService {

    /**
     * 登录
     */
    AuthLoginVO login(AuthLoginDTO authLoginDTO);
}
