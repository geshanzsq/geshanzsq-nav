package com.geshanzsq.admin.system.menu.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@ApiModel("系统菜单")
@Data
public class SysMenuVO extends BaseVO implements Serializable {

    private static final Long serialVersionUID = 1L;

    @ApiModelProperty("菜单 id")
    private Long id;

    @ApiModelProperty("菜单名称")
    private String menuName;

    @ApiModelProperty("上级菜单 id")
    private Long parentId;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("菜单类型（D 目录，M 菜单，B 按钮）")
    private String menuType;

    @ApiModelProperty("权限标识")
    private String permissionCode;

    @ApiModelProperty("路由地址")
    private String routerUrl;

    @ApiModelProperty("组件路径")
    private String componentPath;

    @ApiModelProperty("路由参数")
    private String routerParam;

    @ApiModelProperty("是否为外链（1 是，2 否）")
    private Integer hasFrame;

    @ApiModelProperty("是否缓存（1 缓存，2 不缓存）")
    private Integer hasCache;

    @ApiModelProperty("是否需要权限（（1是，2 否））")
    private Integer hasPermission;

    @ApiModelProperty("菜单图标")
    private String menuIcon;

    @ApiModelProperty("显示状态（1 显示，2 隐藏）")
    private Integer showStatus;

    @ApiModelProperty("状态（1 正常，2 停用）")
    private Integer status;

    @ApiModelProperty("子菜单")
    private List<SysMenuVO> children = new ArrayList<>();

}
