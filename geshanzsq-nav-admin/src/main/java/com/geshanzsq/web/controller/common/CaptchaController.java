package com.geshanzsq.web.controller.common;

import com.geshanzsq.common.constant.Constants;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.core.redis.RedisCache;
import com.geshanzsq.common.utils.uuid.IdUtils;
import com.wf.captcha.SpecCaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.TimeUnit;

/**
 * 验证码操作处理
 * 
 * @author geshanzsq
 */
@RestController
public class CaptchaController
{

    @Autowired
    private RedisCache redisCache;

    /**
     * 生成验证码
     */
    @GetMapping("/captchaImage")
    public AjaxResult getCode() {
        String uuid = IdUtils.simpleUUID();
        String verifyKey = Constants.CAPTCHA_CODE_KEY + uuid;
        SpecCaptcha specCaptcha = new SpecCaptcha(105, 38, 4);
        String code = specCaptcha.text();
        // 保存验证码信息
        redisCache.setCacheObject(verifyKey, code, Constants.CAPTCHA_EXPIRATION, TimeUnit.MINUTES);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("uuid", uuid);
        ajax.put("img", specCaptcha.toBase64());
        return ajax;
    }
}
