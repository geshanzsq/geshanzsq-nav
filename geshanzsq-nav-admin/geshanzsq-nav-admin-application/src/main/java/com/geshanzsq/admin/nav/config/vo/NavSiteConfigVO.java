package com.geshanzsq.admin.nav.config.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 网站配置
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
@Data
@ApiModel("网站配置")
public class NavSiteConfigVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("配置 id")
    private Long id;

    @ApiModelProperty("关于本站描述")
    private String aboutSiteDescription;

    @ApiModelProperty("关于本站邮箱")
    private String aboutSiteEmail;

    @ApiModelProperty("关于本站内容")
    private String aboutSiteContent;

    @ApiModelProperty("关于本站访问量")
    private Integer aboutSiteVisitCount;

}