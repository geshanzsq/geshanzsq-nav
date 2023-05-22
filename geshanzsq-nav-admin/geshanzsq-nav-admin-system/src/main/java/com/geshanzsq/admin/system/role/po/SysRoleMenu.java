package com.geshanzsq.admin.system.role.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

/**
 * 系统角色菜单
 *
 * @author geshanzsq
 * @date 2022/6/22
 */
@Data
public class SysRoleMenu implements Serializable {

    private static final Long serialVersionUID = 1L;
    /**
     * 角色菜单 id
     */
    @TableId
    private Long id;

    /**
     * 角色 id
     */
    @TableField("fk_role_id")
    private Long roleId;

    /**
     * 菜单 id
     */
    @TableField("fk_menu_id")
    private Long menuId;
}
