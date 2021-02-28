package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.core.domain.entity.SysUser;
import com.geshanzsq.nav.domain.dto.NavAboutDto;
import com.geshanzsq.system.domain.SysWebConfig;
import com.geshanzsq.system.service.ISysUserService;
import com.geshanzsq.system.service.ISysWebConfigService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author geshanzsq
 * @date 2021/1/17
 */
@RestController
@RequestMapping("/frontNav")
public class FrontNavAbout extends BaseController {

    @Autowired
    private ISysWebConfigService webConfigService;
    @Autowired
    private ISysUserService userService;


    @GetMapping("/getNavAbout")
    public AjaxResult getNavAbout() {
        SysWebConfig webConfig = webConfigService.selectSysWebConfig(null);
        SysUser sysUser = userService.selectUserById(1L);
        NavAboutDto navAboutDto = new NavAboutDto();
        BeanUtils.copyProperties(webConfig,navAboutDto);
        navAboutDto.setNickName(sysUser.getNickName());
        navAboutDto.setAvatar(sysUser.getAvatar());
        return AjaxResult.success(navAboutDto);
    }

}
