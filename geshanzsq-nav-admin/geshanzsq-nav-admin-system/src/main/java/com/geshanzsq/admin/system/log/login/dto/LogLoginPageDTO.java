package com.geshanzsq.admin.system.log.login.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 登录日志分页查询
 *
 * @author geshanzsq
 * @date 2022/7/3
 */
@Data
@ApiModel("登录日志分页查询")
public class LogLoginPageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("登录用户名")
    @Query(QueryWay.LIKE)
    private String username;

    @ApiModelProperty("登录 ip 地址")
    @Query(QueryWay.LIKE)
    private String ipAddress;

    @ApiModelProperty("登录状态（1 成功，2 失败）")
    private Integer status;

    @ApiModelProperty("开始登录时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Query(value = QueryWay.GE, fieldName = "gmtLogin")
    private Date startGmtLogin;

    @ApiModelProperty("结束登录时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Query(value = QueryWay.LE, fieldName = "gmtLogin")
    private Date endGmtLogin;
}
