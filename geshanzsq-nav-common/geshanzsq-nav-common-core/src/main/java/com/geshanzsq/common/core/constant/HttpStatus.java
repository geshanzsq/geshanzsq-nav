package com.geshanzsq.common.core.constant;

/**
 * 响应状态码
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
public class HttpStatus {

    /**
     * 成功
     */
    public static final int SUCCESS = 200;

    /**
     * 参数列表错误
     */
    public static final int BAD_PARAM = 400;

    /**
     * 未授权、未登录，登录已过期
     */
    public static final int UNAUTHORIZED = 401;

    /**
     * 访问受限、无权限
     */
    public static final int FORBIDDEN = 403;

    /**
     * 资源，服务未找到
     */
    public static final int NOT_FOUND = 404;

    /**
     * 参数不正确，不允许 http 方式
     */
    public static final int BAD_METHOD = 405;

    /**
     * 失败
     */
    public static final int FAIL = 500;



}
