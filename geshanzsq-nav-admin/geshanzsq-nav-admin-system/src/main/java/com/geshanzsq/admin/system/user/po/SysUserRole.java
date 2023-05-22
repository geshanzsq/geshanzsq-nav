package com.geshanzsq.admin.system.user.po;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.io.Serializable;

/**
 * 系统用户角色
 *
 * @author geshanzsq
 * @date 2022/7/17
 */
@Data
public class SysUserRole implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户角色 id
     */
    private Long id;

    /**
     * 用户 id
     */
    @TableField("fk_user_id")
    private Long userId;

    /**
     * 角色 id
     */
    @TableField("fk_role_id")
    private Long roleId;

}
