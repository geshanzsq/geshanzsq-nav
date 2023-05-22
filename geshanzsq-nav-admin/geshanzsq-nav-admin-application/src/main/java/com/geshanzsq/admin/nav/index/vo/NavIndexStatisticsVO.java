package com.geshanzsq.admin.nav.index.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 首页统计
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
@Data
@ApiModel("首页统计")
public class NavIndexStatisticsVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类数")
    private Long categoryCount;

    @ApiModelProperty("网站数")
    private Long siteCount;

    @ApiModelProperty("网站点击数")
    private Long siteClickCount;

}
