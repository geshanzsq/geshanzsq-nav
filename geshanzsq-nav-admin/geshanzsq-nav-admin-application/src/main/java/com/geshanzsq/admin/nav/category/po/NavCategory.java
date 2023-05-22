package com.geshanzsq.admin.nav.category.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 导航分类
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
public class NavCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 分类 id
    */
    @TableId
    private Long id;

    /**
     * 上级 id
    */
    private Long parentId;

    /**
     * 排序
    */
    private Integer sort;

    /**
     * 分类名称
    */
    private String categoryName;

    /**
     * 分类图标
    */
    private String categoryIcon;

    /**
     * 状态（1 正常，2 停用）
    */
    private Integer status;

    /**
     * 创建人用户 id
    */
    @TableField("fk_create_user_id")
    private Long createUserId;

    /**
     * 创建时间
    */
    private Date gmtCreate;

    /**
     * 修改人用户 id
    */
    @TableField("fk_modify_user_id")
    private Long modifyUserId;

    /**
     * 修改时间
    */
    private Date gmtModify;

}