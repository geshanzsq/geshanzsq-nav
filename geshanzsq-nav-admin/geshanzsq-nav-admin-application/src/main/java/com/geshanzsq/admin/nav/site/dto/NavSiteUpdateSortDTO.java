package com.geshanzsq.admin.nav.site.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 更新排序
 *
 * @author geshanzsq
 * @date 2022/12/25
 */
@Data
@ApiModel("更新排序")
public class NavSiteUpdateSortDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "网站 id", required = true)
    @NotNull(message = "网站 id不能为空")
    private Long id;

    @ApiModelProperty(value = "排序", required = true)
    @NotNull(message = "排序不能为空")
    private Integer sort;

}
