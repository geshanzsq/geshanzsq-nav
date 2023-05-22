package com.geshanzsq.admin.system.log.operation.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 操作日志分页查询
 *
 * @author geshanzsq
 * @date 2022/7/9
 */
@Data
@ApiModel("操作日志分页查询")
public class LogOperationPageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("模块名称")
    private String moduleName;

    @ApiModelProperty("操作 ip 地址")
    private String ipAddress;

    @ApiModelProperty("操作用户")
    private String operateUser;

    @ApiModelProperty("业务类型（1 其它，2 新增，3 修改，4 删除）")
    private Integer businessType;

    @ApiModelProperty("操作类型（1 其它，2 后台用户，3 手机端用户，4 博客用户）")
    private Integer operateType;

    @ApiModelProperty("状态（1 成功，2 异常）")
    private Integer status;

    @ApiModelProperty("开始操作时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date beginGmtOperate;

    @ApiModelProperty("结束操作时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endGmtOperate;
}
