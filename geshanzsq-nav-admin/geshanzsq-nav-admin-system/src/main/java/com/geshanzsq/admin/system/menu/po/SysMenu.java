package com.geshanzsq.admin.system.menu.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@Data
public class SysMenu implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 菜单 id
     */
    @TableId
    private Long id;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 上级菜单 id
     */
    private Long parentId;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 菜单类型（D 目录，M 菜单，B 按钮）
     */
    private String menuType;

    /**
     * 权限标识
     */
    private String permissionCode;

    /**
     * 路由地址
     */
    private String routerUrl;

    /**
     * 组件路径
     */
    private String componentPath;

    /**
     * 路由参数
     */
    private String routerParam;

    /**
     * 是否为外链（1是，2否）
     */
    private Integer hasFrame;

    /**
     * 是否缓存（1缓存，2不缓存）
     */
    private Integer hasCache;

    /**
     * 是否需要权限（（1是，2 否））
     */
    private Integer hasPermission;

    /**
     * 菜单图标
     */
    private String menuIcon;

    /**
     * 显示状态（1 显示，2 隐藏）
     */
    private Integer showStatus;

    /**
     * 状态（1 正常，2 停用）
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 创建人用户 id
     */
    @TableField("fk_create_user_id")
    private Long createUserId;

    /**
     * 修改时间
     */
    private Date gmtModify;

    /**
     * 修改人用户 id
     */
    @TableField("fk_modify_user_id")
    private Long modifyUserId;

}
