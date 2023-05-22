package com.geshanzsq.admin.nav.site.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 导航网站
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Data
public class NavSite implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 网站 id
    */
    @TableId
    private Long id;

    /**
     * 分类 id
    */
    @TableField("fk_category_id")
    private Long categoryId;

    /**
     * 网站名称
    */
    private String siteName;

    /**
     * 网站图片路径
    */
    private String sitePath;

    /**
     * 网站描述
    */
    private String siteDescription;

    /**
     * 网站地址
    */
    private String siteUrl;

    /**
     * 排序
    */
    private Integer sort;

    /**
     * 点击量
    */
    private Integer clickCount;

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