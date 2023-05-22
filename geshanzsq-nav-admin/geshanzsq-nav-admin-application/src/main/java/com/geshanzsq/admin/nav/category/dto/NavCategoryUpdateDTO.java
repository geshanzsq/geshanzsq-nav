package com.geshanzsq.admin.nav.category.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 导航分类更新
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航分类更新")
public class NavCategoryUpdateDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "分类 id", required = true)
    @NotNull(message = "分类 id不能为空")
    private Long id;

    @ApiModelProperty(value = "上级分类 id", required = true)
    @NotNull(message = "上级分类不能为空")
    private Long parentId;

    @ApiModelProperty(value = "排序", required = true)
    @NotNull(message = "排序不能为空")
    private Integer sort;

    @ApiModelProperty(value = "分类名称", required = true)
    @NotBlank(message = "分类名称不能为空")
    private String categoryName;

    @ApiModelProperty("分类图标")
    private String categoryIcon;

    @ApiModelProperty(value = "状态（1 正常，2 停用）", required = true)
    @NotNull(message = "状态（1 正常，2 停用）不能为空")
    private Integer status;

}