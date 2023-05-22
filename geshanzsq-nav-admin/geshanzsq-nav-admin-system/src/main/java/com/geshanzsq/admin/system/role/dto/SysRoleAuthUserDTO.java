package com.geshanzsq.admin.system.role.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * 授权用户
 *
 * @author geshanzsq
 * @date 2022/7/17
 */
@Data
@ApiModel("授权用户")
public class SysRoleAuthUserDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色 id", required = true)
    @NotNull(message = "角色 id 不能为空")
    private Long roleId;

    @ApiModelProperty(value = "用户 ids", required = true)
    @NotEmpty(message = "用户 ids 不能为空")
    private List<Long> userIds;

}
