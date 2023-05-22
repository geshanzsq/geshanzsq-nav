package com.geshanzsq.admin.system.api.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 接口分类分页查询
 *
 * @author geshanzsq
 * @date 2022/6/24
 */
@Data
@ApiModel("接口分类分页")
public class SysApiCategoryPageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("接口分类名称")
    @Query(QueryWay.LIKE)
    private String categoryName;

    @ApiModelProperty("状态，1 正常，2 停用")
    private Integer status;
}
