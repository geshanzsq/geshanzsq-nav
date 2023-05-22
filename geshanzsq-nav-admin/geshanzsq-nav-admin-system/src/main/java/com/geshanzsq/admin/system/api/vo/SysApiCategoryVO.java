package com.geshanzsq.admin.system.api.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 接口分类
 *
 * @author geshanzsq
 * @date 2022/6/24
 */
@Data
@ApiModel("接口分类")
public class SysApiCategoryVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("接口分类id")
    private Long id;

    @ApiModelProperty("接口分类名称")
    private String categoryName;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty("备注")
    private String remark;
}
