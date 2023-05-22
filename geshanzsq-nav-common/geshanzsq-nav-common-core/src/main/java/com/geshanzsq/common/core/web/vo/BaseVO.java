package com.geshanzsq.common.core.web.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 基本返回数据
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Data
@ApiModel("基本返回数据")
public class BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("创建时间")
    private Date gmtCreate;

    @ApiModelProperty("创建人用户 id")
    private Long createUserId;

    @ApiModelProperty("修改时间")
    private Date gmtModify;

    @ApiModelProperty("修改人用户 id")
    private Long modifyUserId;

}
