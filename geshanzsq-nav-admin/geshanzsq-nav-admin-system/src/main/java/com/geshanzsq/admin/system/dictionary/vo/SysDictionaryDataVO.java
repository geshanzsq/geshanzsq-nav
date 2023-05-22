package com.geshanzsq.admin.system.dictionary.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典数据
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
@ApiModel("字典数据")
public class SysDictionaryDataVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("字典数据 id")
    private Long id;

    @ApiModelProperty("字典标签")
    private String dictionaryLabel;

    @ApiModelProperty("字典值")
    private String dictionaryValue;

    @ApiModelProperty("所属字典 id")
    private String dictionaryId;

    @ApiModelProperty("样式类型（primary，success等）")
    private String classType;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty("备注")
    private String remark;

}
