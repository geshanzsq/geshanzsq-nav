package com.geshanzsq.admin.system.log.operation.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 操作日志
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
@Data
public class LogOperation implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 操作日志 id
     */
    @TableId
    private Long id;

    /**
     * 模块名称
     */
    private String moduleName;

    /**
     * 业务类型（1 其它，2 新增，3 修改，4 删除）
     */
    private Integer businessType;

    /**
     * 操作类型（1 其它，2 后台用户，3 手机端用户，4 博客用户）
     */
    private Integer operateType;

    /**
     * 操作用户 id
     */
    @TableField("fk_user_id")
    private Long userId;

    /**
     * 请求方式
     */
    private String requestMethod;

    /**
     * 类方法
     */
    private String classMethod;

    /**
     * 请求地址
     */
    private String requestUrl;

    /**
     * 操作 ip 地址
     */
    private String ipAddress;

    /**
     * 操作位置
     */
    private String operateLocation;

    /**
     * 请求参数
     */
    private String requestParam;

    /**
     * 返回结果
     */
    private String returnResult;

    /**
     * 状态（1 成功，2 异常）
     */
    private Integer status;

    /**
     * 操作时间
     */
    private Date gmtOperate;

    /**
     * 错误消息
     */
    private String errorMessage;

    /**
     * 浏览器类型
     */
    private String browserType;

    /**
     * 操作系统
     */
    private String operateSystem;
}
