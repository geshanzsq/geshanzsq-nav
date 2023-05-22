package com.geshanzsq.admin.client.search.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 客户端网站
 *
 * @author geshanzsq
 * @date 2023/4/7
 */
@Data
@ApiModel("客户端网站")
public class NavClientSiteSearchVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("网站 id")
    private Long id;

    @ApiModelProperty("分类名称")
    private String categoryName;

    @ApiModelProperty("网站名称")
    private String siteName;

    @ApiModelProperty("网站地址")
    private String siteUrl;

    @ApiModelProperty("网站描述")
    private String siteDescription;

}
