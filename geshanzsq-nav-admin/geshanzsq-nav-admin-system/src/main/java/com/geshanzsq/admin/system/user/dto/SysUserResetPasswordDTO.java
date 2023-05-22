package com.geshanzsq.admin.system.user.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 用户重置密码
 *
 * @author geshanzsq
 * @date 2022/6/18
 */
@Data
@ApiModel("用户重置密码")
public class SysUserResetPasswordDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户 id", required = true)
    @NotNull(message = "重置的用户不能为空")
    private Long id;

    @ApiModelProperty(value = "密码", required = true)
    @NotBlank(message = "密码不能为空")
    private String password;
}
