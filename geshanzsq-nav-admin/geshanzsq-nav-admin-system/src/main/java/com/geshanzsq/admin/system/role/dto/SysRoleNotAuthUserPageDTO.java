package com.geshanzsq.admin.system.role.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 角色未分配用户分页查询
 *
 * @author geshanzsq
 * @date 2022/7/17
 */
@Data
@ApiModel("角色未分配用户分页查询")
public class SysRoleNotAuthUserPageDTO extends PageDTO implements Serializable {

    private static final Long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色 id", required = true)
    @NotNull(message = "角色 id 不能为空")
    private Long roleId;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("昵称")
    private String nickName;

    @ApiModelProperty("状态，1 正常，2 停用")
    private Integer status;

    @ApiModelProperty("用户类型，1 后台用户，2 博客用户")
    private Integer userType;

}
