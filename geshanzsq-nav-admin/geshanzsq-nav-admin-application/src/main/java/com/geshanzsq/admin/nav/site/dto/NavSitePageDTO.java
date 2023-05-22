package com.geshanzsq.admin.nav.site.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航网站分页
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航网站分页")
public class NavSitePageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类 id")
    private Long categoryId;

    @ApiModelProperty("网站名称")
    @Query(ignore = true)
    private String siteNameDescription;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

}