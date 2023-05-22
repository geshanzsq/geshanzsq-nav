package com.geshanzsq.admin.system.user.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * 用户重置密码
 *
 * @author geshanzsq
 * @date 2023/1/4
 */
@Data
@ApiModel("用户重置密码")
public class SysUserResetUserPasswordDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("旧密码")
    private String oldPassword;

    @ApiModelProperty(value = "新密码", required = true)
    @NotBlank(message = "新密码不能为空")
    @Size(min = 6, max = 20, message = "长度在 6 到 20 个字符")
    private String newPassword;

}
