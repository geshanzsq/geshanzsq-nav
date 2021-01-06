package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.enums.CommonStatus;
import com.geshanzsq.nav.domain.vo.NavIndexVO;
import com.geshanzsq.nav.service.INavMenuService;
import com.geshanzsq.nav.service.INavSiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登录后的首页展示
 * @author geshanzsq
 * @date 2020/8/9
 */
@RestController
@RequestMapping("/nav")
public class NavIndexController {

    @Autowired
    private INavMenuService navMenuService;
    @Autowired
    private INavSiteService navSiteService;

    @GetMapping("/index")
    public AjaxResult index() {
        Integer status = CommonStatus.OK.code;
        Integer menuCount = navMenuService.getCount(status);
        Integer siteCount = navSiteService.getCount(status);
        NavIndexVO navIndexVo = new NavIndexVO(menuCount,siteCount);
        return AjaxResult.success(navIndexVo);
    }

}
