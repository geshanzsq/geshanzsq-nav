package com.geshanzsq.admin.nav.category.dto;

import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航分类分页
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航分类分页")
public class NavCategoryListDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类名称")
    @Query(QueryWay.LIKE)
    private String categoryName;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty(value = "排序列，多个用逗号分开", hidden = true)
    @Query(ignore = true)
    private String orderColumn;

    @ApiModelProperty(value = "排序类型(asc 或 desc)，多个用逗号分开", hidden = true)
    @Query(ignore = true)
    private String orderType;

}