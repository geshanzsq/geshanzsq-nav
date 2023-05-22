package com.geshanzsq.admin.system.menu.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * 分配 API
 *
 * @author geshanzsq
 * @date 2022/7/27
 */
@Data
@ApiModel("分配 API")
public class SysMenuAuthApiDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "菜单 id", required = true)
    @NotNull(message = "菜单 id 不能为空")
    private Long menuId;

    @ApiModelProperty("接口列表")
    private List<Long> apiIds;
}
