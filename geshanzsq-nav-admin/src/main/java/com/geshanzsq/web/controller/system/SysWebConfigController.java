package com.geshanzsq.web.controller.system;

import com.geshanzsq.common.annotation.Log;
import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.enums.BusinessType;
import com.geshanzsq.common.utils.SecurityUtils;
import com.geshanzsq.system.domain.SysWebConfig;
import com.geshanzsq.system.service.ISysWebConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 网站配置Controller
 * 
 * @author geshanzsq
 * @date 2021-02-28
 */
@RestController
@RequestMapping("/system/webConfig")
public class SysWebConfigController extends BaseController
{
    @Autowired
    private ISysWebConfigService sysWebConfigService;

    /**
     * 获取网站配置详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:webConfig:getWebConfig')")
    @GetMapping("/getWebConfig")
    public AjaxResult getWebConfig()
    {
        return AjaxResult.success(sysWebConfigService.selectSysWebConfig(SecurityUtils.getUsername()));
    }

    /**
     * 修改网站配置
     */
    @PreAuthorize("@ss.hasPermi('system:webConfig:updateWebConfig')")
    @Log(title = "网站配置", businessType = BusinessType.UPDATE)
    @PutMapping("/updateWebConfig")
    public AjaxResult edit(@RequestBody SysWebConfig sysWebConfig)
    {
        sysWebConfig.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(sysWebConfigService.updateSysWebConfig(sysWebConfig));
    }
}
