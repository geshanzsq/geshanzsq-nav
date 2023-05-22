package com.geshanzsq.admin.system.menu.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 菜单分配接口
 *
 * @author geshanzsq
 * @date 2022/7/27
 */
@Data
@ApiModel("菜单分配接口")
public class SysMenuAuthApiVO implements Serializable {

    private static final Long serialVersionUID = 1L;

    @ApiModelProperty("接口 id")
    private Long apiId;

    @ApiModelProperty("接口名称")
    private String apiName;

    @ApiModelProperty("接口分类 id")
    private Long apiCategoryId;

    @ApiModelProperty("接口分类名称")
    private String apiCategoryName;

}
