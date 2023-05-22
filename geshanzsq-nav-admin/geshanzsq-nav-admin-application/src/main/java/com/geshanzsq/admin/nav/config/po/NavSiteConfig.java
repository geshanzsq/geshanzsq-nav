package com.geshanzsq.admin.nav.config.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 网站配置
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
@Data
public class NavSiteConfig implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 配置 id
    */
    @TableId
    private Long id;

    /**
     * 关于本站描述
    */
    private String aboutSiteDescription;

    /**
     * 关于本站邮箱
    */
    private String aboutSiteEmail;

    /**
     * 关于本站内容
    */
    private String aboutSiteContent;

    /**
     * 关于本站访问量
    */
    private Integer aboutSiteVisitCount;

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