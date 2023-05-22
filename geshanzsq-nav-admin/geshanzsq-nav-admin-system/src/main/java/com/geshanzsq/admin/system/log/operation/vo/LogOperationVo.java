package com.geshanzsq.admin.system.log.operation.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 日志操作
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
@Data
@ApiModel("日志操作")
public class LogOperationVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("操作日志 id")
    private Long id;

    @ApiModelProperty("模块名称")
    private String moduleName;

    @ApiModelProperty("业务类型（1 其它，2 新增，3 修改，4 删除）")
    private Integer businessType;

    @ApiModelProperty("操作类型（1 其它，2 后台用户，3 手机端用户，4 博客用户）")
    private Integer operateType;

    @ApiModelProperty("操作用户 id")
    private Long userId;

    @ApiModelProperty("请求方式")
    private String requestMethod;

    @ApiModelProperty("类方法")
    private String classMethod;

    @ApiModelProperty("请求地址")
    private String requestUrl;

    @ApiModelProperty("操作 ip 地址")
    private String ipAddress;

    @ApiModelProperty("操作位置")
    private String operateLocation;

    @ApiModelProperty("请求参数")
    private String requestParam;

    @ApiModelProperty("返回结果")
    private String returnResult;

    @ApiModelProperty("状态（1 成功，2 异常）")
    private Integer status;

    @ApiModelProperty("操作时间")
    private Date gmtOperate;

    @ApiModelProperty("错误消息")
    private String errorMessage;

    @ApiModelProperty("浏览器类型")
    private String browserType;

    @ApiModelProperty("操作系统")
    private String operateSystem;

    @ApiModelProperty("操作人用户名")
    private String username;

    @ApiModelProperty("操作人昵称")
    private String nickName;

}
