package com.geshanzsq.admin.core.bing.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 微软 Bing 图片
 *
 * @author geshanzsq
 * @date 2022/5/14
 */
@Data
@ApiModel("微软 Bing 图片")
public class BingImageVO implements Serializable {

    private static final Long serialVersionUID = 1L;

    @ApiModelProperty("图片链接")
    private String imageUrl;

    public BingImageVO(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
