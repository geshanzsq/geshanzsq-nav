package com.geshanzsq.framework.security.handler;

import com.geshanzsq.common.core.constant.HttpStatus;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.web.response.ResponseResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 无权限异常全局捕获
 *
 * @author geshanzsq
 * @date 2022/5/8
 */
@RestControllerAdvice
public class AccessDeniedExceptionHandler {

    private final static Logger log = LoggerFactory.getLogger(AccessDeniedExceptionHandler.class);

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseResult handleAuthorizationException(AccessDeniedException e) {
        log.error(e.getMessage());
        return ResponseResult.fail(HttpStatus.FORBIDDEN, MessageUtils.message("security.forbidden"));
    }

}
