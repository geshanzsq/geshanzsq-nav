package com.geshanzsq.admin.system.api.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

/**
 * 接口菜单
 *
 * @author geshanzsq
 * @date 2022/6/26
 */
@Data
public class SysApiMenu implements Serializable {

    private static final Long serialVersionUID = 1L;
    /**
     * 接口菜单 id
     */
    @TableId
    private Long id;

    /**
     * 接口 id
     */
    @TableField("fk_api_id")
    private Long apiId;

    /**
     * 菜单 id
     */
    @TableField("fk_menu_id")
    private Long menuId;
}
