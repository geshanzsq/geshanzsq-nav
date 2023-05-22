package com.geshanzsq.admin.nav.site.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 用户查询列表
 *
 * @author geshanzsq
 * @date 2022/12/25
 */
@Data
@ApiModel("用户查询列表")
public class NavSiteListUserImportDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类 id")
    private Long categoryId;

    @ApiModelProperty("网站名称")
    private String siteName;

    @ApiModelProperty(value = "状态（1 正常，2 停用）", hidden = true)
    private Integer status;

}
