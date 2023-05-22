package com.geshanzsq.admin.nav.category.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航分类
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
@ApiModel("导航分类")
public class NavCategoryVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类 id")
    private Long id;

    @ApiModelProperty("上级 id")
    private Long parentId;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("分类名称")
    private String categoryName;

    @ApiModelProperty("分类图标")
    private String categoryIcon;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

}