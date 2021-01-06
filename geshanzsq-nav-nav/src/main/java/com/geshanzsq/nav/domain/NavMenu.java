package com.geshanzsq.nav.domain;

import com.geshanzsq.common.core.domain.BaseEntity;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 导航菜单对象 nav_menu
 * 
 * @author geshanzsq
 * @date 2020-07-10
 */
@Data
public class NavMenu extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 菜单id */
    private Long menuId;

    /** 父级名称 */
    private String parentName;

    /** 父级id */
    @NotNull(message = "上级菜单不能为空")
    private Long parentId;

    /** 显示顺序 */
    @NotNull(message = "显示顺序不能为空")
    private Integer orderNum;

    /** 标题 */
    @NotBlank(message = "菜单名称不能为空")
    private String menuName;

    /** 图标 */
    private String menuIcon;

    /** 状态，0 正常，1 删除 */
    private Integer status;

    /** 子菜单 */
    List<NavMenu> children = new ArrayList<>();

    public NavMenu() {
    }
}
