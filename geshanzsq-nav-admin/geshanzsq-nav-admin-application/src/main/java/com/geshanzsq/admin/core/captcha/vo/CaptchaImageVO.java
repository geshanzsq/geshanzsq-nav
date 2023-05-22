package com.geshanzsq.admin.core.captcha.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 验证码
 *
 * @author geshanzsq
 * @date 2022/5/2
 */
@Data
@ApiModel("验证码")
public class CaptchaImageVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("验证码唯一标识")
    private String uuid;

    @ApiModelProperty("验证码图片")
    private String image;

}
