package com.geshanzsq.admin.system.log.login.controller;

import com.geshanzsq.admin.system.log.login.dto.LogLoginPageDTO;
import com.geshanzsq.admin.system.log.login.mapstruct.LogLoginConverter;
import com.geshanzsq.admin.system.log.login.po.LogLogin;
import com.geshanzsq.admin.system.log.login.service.LogLoginService;
import com.geshanzsq.admin.system.log.login.vo.LogLoginVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.controller.BaseController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登录日志
 *
 * @author geshanzsq
 * @date 2022/7/3
 */
@Api(tags = "登录日志")
@RestController
@RequestMapping("/system/log/login")
public class LogLoginController extends BaseController {

    @Autowired
    private LogLoginService logLoginService;

    @GetMapping("/page")
    @ApiOperation(("分页列表"))
    @PreAuthorize("@auth.hasUrl()")
    public ResponseResult<PageVO<LogLoginVO>> page(LogLoginPageDTO pageDto) {
        PageVO<LogLogin> pageVO = logLoginService.page(pageDto);
        return ResponseResult.success(LogLoginConverter.INSTANCE.convert(pageVO));
    }

}
