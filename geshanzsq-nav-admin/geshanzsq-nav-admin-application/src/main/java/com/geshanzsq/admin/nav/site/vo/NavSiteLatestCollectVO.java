package com.geshanzsq.admin.nav.site.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 最新收录
 *
 * @author geshanzsq
 * @date 2023/4/13
 */
@Data
@ApiModel("最新收录")
public class NavSiteLatestCollectVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("网站 id")
    private Long id;

    @ApiModelProperty("网站图片路径")
    private String sitePath;

    @ApiModelProperty("网站名称")
    private String siteName;

    @ApiModelProperty("网站描述")
    private String siteDescription;

    @ApiModelProperty("网站地址")
    private String siteUrl;

    @ApiModelProperty("创建时间")
    private Date gmtCreate;
}
