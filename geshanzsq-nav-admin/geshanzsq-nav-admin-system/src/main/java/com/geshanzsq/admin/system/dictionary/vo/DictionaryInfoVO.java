package com.geshanzsq.admin.system.dictionary.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 字典详情
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
@ApiModel("字典详情")
public class DictionaryInfoVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("字典 id")
    private Long id;

    @ApiModelProperty("字典名称")
    private String dictionaryName;

    @ApiModelProperty("字典编码")
    private String dictionaryCode;

    @ApiModelProperty("字典数据")
    private List<DictionaryDataInfoVO> dictionaryDataList;

}
