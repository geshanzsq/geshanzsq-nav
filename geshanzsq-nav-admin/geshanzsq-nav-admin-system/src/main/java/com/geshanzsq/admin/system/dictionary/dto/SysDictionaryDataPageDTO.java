package com.geshanzsq.admin.system.dictionary.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 字典数据分页
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
@ApiModel("字典数据分页")
public class SysDictionaryDataPageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("字典标签")
    @Query(QueryWay.LIKE)
    private String dictionaryLabel;

    @ApiModelProperty(value = "所属字典", required = true)
    @NotNull(message = "所属字典不能为空")
    private Long dictionaryId;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;
}
