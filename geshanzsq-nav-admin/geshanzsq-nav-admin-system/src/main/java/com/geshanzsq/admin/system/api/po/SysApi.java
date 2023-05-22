package com.geshanzsq.admin.system.api.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统接口
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Data
public class SysApi implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 接口 id
     */
    @TableId
    private Long id;

    /**
     * 接口名称
     */
    private String apiName;

    /**
     * 接口地址
     */
    private String apiUrl;

    /**
     * 接口请求方式（如：get，post）
     */
    private String apiMethod;

    /**
     * 所属分类 id
     */
    @TableField("fk_api_category_id")
    private String apiCategoryId;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 状态（1 正常，2 停用）
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

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
