package com.geshanzsq.admin.system.dictionary.dto;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 字典数据新增
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
@ApiModel("字典数据新增")
public class SysDictionaryDataAddDTO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "字典标签", required = true)
    @NotBlank(message = "字典标签不能为空")
    private String dictionaryLabel;

    @ApiModelProperty(value = "字典值", required = true)
    @NotBlank(message = "字典值不能为空")
    private String dictionaryValue;

    @ApiModelProperty(value = "所属字典 id", required = true)
    @NotNull(message = "所属字典不能为空")
    private Long dictionaryId;

    @ApiModelProperty("样式类型（primary，success等）")
    private String classType;

    @ApiModelProperty(value = "排序", required = true)
    @NotNull(message = "排序不能为空")
    private Integer sort;

    @ApiModelProperty(value = "状态（1 正常，2 停用）", required = true)
    @NotNull(message = "状态不能为空")
    private Integer status;

    @ApiModelProperty("备注")
    private String remark;

}
