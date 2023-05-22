package com.geshanzsq.admin.nav.site.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航网站匹配
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航网站匹配")
public class NavSiteMatchVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("网站名称")
    private String siteName;

    @ApiModelProperty("网站图片路径")
    private String sitePath;

    @ApiModelProperty("网站描述")
    private String siteDescription;

}