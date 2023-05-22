package com.geshanzsq.admin.system.user.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Set;

/**
 * 系统用户
 *
 * @author geshanzsq
 * @date 2022/3/20
 */
@Data
@ApiModel("系统用户")
public class SysUserVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("用户 id")
    private Long id;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("密码")
    private String password;

    @ApiModelProperty("昵称")
    private String nickName;

    @ApiModelProperty("性别，1 保密，2 男，3 女")
    private Integer sex;

    @ApiModelProperty("用户类型，1 后台用户，2 博客用户")
    private Integer userType;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("手机号码")
    private String mobilePhone;

    @ApiModelProperty("头像")
    private String avatar;

    @ApiModelProperty("状态，1 正常，2 停用")
    private Integer status;

    @ApiModelProperty("备注")
    private String remark;

    @ApiModelProperty("角色编码")
    private Set<String> roleCodes;

    @ApiModelProperty("权限标识")
    private Set<String> permissionCodes;

    @ApiModelProperty("角色名称")
    private Set<String> roleNames;
}
