package com.geshanzsq.admin.system.role.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 角色分页查询
 *
 * @author geshanzsq
 * @date 2022/6/19
 */
@Data
@ApiModel("角色分页查询")
public class SysRolePageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("角色名称")
    @Query(QueryWay.LIKE)
    private String roleName;

    @ApiModelProperty("角色编码")
    @Query(QueryWay.LIKE)
    private String roleCode;

    @ApiModelProperty("状态，1 正常，2 停用")
    private Integer status;

}
