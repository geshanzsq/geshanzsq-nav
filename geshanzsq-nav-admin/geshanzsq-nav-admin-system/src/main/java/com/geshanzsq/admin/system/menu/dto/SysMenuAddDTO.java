package com.geshanzsq.admin.system.menu.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 菜单新增
 *
 * @author geshanzsq
 * @date 2022/6/15
 */
@Data
@ApiModel("菜单新增")
public class SysMenuAddDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "菜单名称", required = true)
    @NotBlank(message = "菜单名称不能为空")
    private String menuName;

    @ApiModelProperty("上级菜单 id")
    private Long parentId;

    @ApiModelProperty("菜单图标")
    private String menuIcon;

    @ApiModelProperty(value = "菜单类型（D 目录，M 菜单，B 按钮）", required = true)
    @NotBlank(message = "请选择菜单类型")
    private String menuType;

    @ApiModelProperty("路由地址")
    private String routerUrl;

    @ApiModelProperty(value = "排序", required = true)
    @NotNull(message = "排序顺序不能为空")
    private Integer sort;

    @ApiModelProperty("是否为外链（1是 2否）")
    private Integer frame;

    @ApiModelProperty("是否缓存（1缓存 2不缓存）")
    private Integer cache;

    @ApiModelProperty("组件路径")
    private String componentPath;

    @ApiModelProperty("路由参数")
    private String routerParam;

    @ApiModelProperty("权限标识")
    private String permissionCode;

    @ApiModelProperty("显示状态（1显示 2隐藏）")
    private Integer showStatus;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty("是否需要权限（（1是，2 否））")
    private Integer hasPermission;

}
