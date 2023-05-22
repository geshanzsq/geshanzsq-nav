package com.geshanzsq.admin.nav.site.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航网站客户端
 *
 * @author geshanzsq
 * @date 2023/1/7
 */
@Data
@ApiModel("导航网站客户端")
public class NavSiteClientVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("网站 id")
    private Long id;

    @ApiModelProperty("分类 id")
    private Long categoryId;

    @ApiModelProperty("网站名称")
    private String siteName;

    @ApiModelProperty("网站图片路径")
    private String sitePath;

    @ApiModelProperty("网站描述")
    private String siteDescription;

    @ApiModelProperty("网站地址")
    private String siteUrl;


}
