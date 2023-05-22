package com.geshanzsq.admin.core.exception;

import com.geshanzsq.common.core.constant.HttpStatus;
import com.geshanzsq.common.core.exception.BaseException;
import com.geshanzsq.common.core.exception.ParamException;
import com.geshanzsq.common.core.exception.ServiceException;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.rate.limiter.exception.RateLimiterException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;

/**
 * 全局异常处理
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 请求参数校验不通过，兼容不通注解
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseResult methodArgumentNotValidException(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        return ResponseResult.fail(HttpStatus.BAD_PARAM, message);
    }

    /**
     * 请求参数校验不通过，兼容不通注解
     */
    @ExceptionHandler(BindException.class)
    public ResponseResult handleBindException(BindException e) {
        String message = e.getAllErrors().get(0).getDefaultMessage();
        return ResponseResult.fail(HttpStatus.BAD_PARAM, message);
    }

    /**
     * 参数异常
     */
    @ExceptionHandler(ParamException.class)
    public ResponseResult paramException(ParamException e) {
        return ResponseResult.fail(HttpStatus.BAD_PARAM, e.getMessage());
    }

    /**
     * 请求方式不支持
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseResult handleHttpRequestMethodNotSupported(HttpRequestMethodNotSupportedException e, HttpServletRequest request) {
        String requestURI = request.getRequestURI();
        log.error("请求地址 {},不支持 {} 请求", requestURI, e.getMethod());
        return ResponseResult.fail(HttpStatus.BAD_METHOD, MessageUtils.message("bad.request.method"));
    }

    /**
     * 无权限访问
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseResult accessDeniedException(AccessDeniedException e) {
        log.error(e.getMessage());
        return ResponseResult.fail(HttpStatus.FORBIDDEN, MessageUtils.message("security.forbidden"));
    }

    /**
     * 服务异常
     */
    @ExceptionHandler(ServiceException.class)
    public ResponseResult serviceException(ServiceException e) {
        e.printStackTrace();
        return ResponseResult.fail(e.getCode(), e.getMessage());
    }

    /**
     * 自定义基本异常
     */
    @ExceptionHandler(BaseException.class)
    public ResponseResult baseException(BaseException e) {
        log.error("所属模块：{}，异常信息：{}", e.getModule(), e);
        return ResponseResult.fail(e.getCode(), e.getMessage());
    }

    /**
     * 限流
     */
    @ExceptionHandler(RateLimiterException.class)
    public ResponseResult rateLimiterException(RateLimiterException e) {
        return ResponseResult.fail(HttpStatus.FORBIDDEN, e.getMessage());
    }

    /**
     * 其他异常
     */
    @ExceptionHandler(Exception.class)
    public ResponseResult handleException(Exception e) {
        e.printStackTrace();
        return ResponseResult.fail(MessageUtils.message("system.exception"));
    }

}
