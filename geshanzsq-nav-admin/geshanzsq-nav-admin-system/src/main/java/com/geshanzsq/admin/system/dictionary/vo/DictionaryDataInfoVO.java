package com.geshanzsq.admin.system.dictionary.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典数据详情
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
@ApiModel("字典数据详情")
public class DictionaryDataInfoVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("字典数据 id")
    private Long id;

    @ApiModelProperty("字典标签")
    private String dictionaryLabel;

    @ApiModelProperty("字典值")
    private String dictionaryValue;

    @ApiModelProperty("样式类型（primary，success等）")
    private String classType;
}
