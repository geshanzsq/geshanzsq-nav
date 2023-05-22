package com.geshanzsq.admin.system.user.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 用户修改信息
 *
 * @author geshanzsq
 * @date 2022/6/18
 */
@Data
@ApiModel("用户修改信息")
public class SysUserUpdateInfoDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户名", required = true)
    @NotBlank(message = "用户名不能为空")
    private String username;

    @ApiModelProperty(value = "昵称", required = true)
    @NotBlank(message = "昵称 不能为空")
    private String nickName;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("手机号码")
    private String mobilePhone;

    @ApiModelProperty("性别，1 保密，2 男，3 女")
    private Integer sex;

}
