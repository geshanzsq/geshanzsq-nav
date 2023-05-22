package com.geshanzsq.admin.nav.site.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 导航网站新增
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航网站新增")
public class NavSiteAddDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "分类 id", required = true)
    @NotNull(message = "分类 id不能为空")
    private Long categoryId;

    @ApiModelProperty(value = "网站名称", required = true)
    @NotBlank(message = "网站名称不能为空")
    private String siteName;

    @ApiModelProperty(value = "网站图片路径", required = true)
    @NotBlank(message = "网站图片路径不能为空")
    private String sitePath;

    @ApiModelProperty(value = "网站描述", required = true)
    @NotBlank(message = "网站描述不能为空")
    private String siteDescription;

    @ApiModelProperty(value = "网站地址", required = true)
    @NotBlank(message = "网站地址不能为空")
    private String siteUrl;

    @ApiModelProperty(value = "排序", required = true)
    @NotNull(message = "排序不能为空")
    private Integer sort;

    @ApiModelProperty("点击量")
    private Integer clickCount;

    @ApiModelProperty(value = "状态（1 正常，2 停用）", required = true)
    @NotNull(message = "状态（1 正常，2 停用）不能为空")
    private Integer status;

}