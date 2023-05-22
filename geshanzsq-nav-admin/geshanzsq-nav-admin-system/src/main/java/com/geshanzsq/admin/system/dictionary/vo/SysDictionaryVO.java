package com.geshanzsq.admin.system.dictionary.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典
 *
 * @author geshanzsq
 * @date 2022/6/26
 */
@Data
@ApiModel("字典")
public class SysDictionaryVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("字典 id")
    private Long id;

    @ApiModelProperty("字典名称")
    private String dictionaryName;

    @ApiModelProperty("字典编码")
    private String dictionaryCode;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty("备注")
    private String remark;
}
