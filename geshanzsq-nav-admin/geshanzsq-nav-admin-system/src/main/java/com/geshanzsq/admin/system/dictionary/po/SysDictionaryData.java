package com.geshanzsq.admin.system.dictionary.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 字典数据
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Data
public class SysDictionaryData implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 字典数据 id
     */
    @TableId
    private Long id;

    /**
     * 字典标签
     */
    private String dictionaryLabel;

    /**
     * 字典值
     */
    private String dictionaryValue;

    /**
     * 所属字典 id
     */
    @TableField("fk_dictionary_id")
    private String dictionaryId;

    /**
     * 样式类型（primary，success等）
     */
    private String classType;

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
