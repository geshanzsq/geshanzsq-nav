package com.geshanzsq.admin.core.captcha.constant;

/**
 * 验证码常量
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
public class CaptchaConstant {

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha:codes:";

    /**
     * 验证码有效期（分钟）
     */
    public static final Integer CAPTCHA_EXPIRATION = 2;

}
