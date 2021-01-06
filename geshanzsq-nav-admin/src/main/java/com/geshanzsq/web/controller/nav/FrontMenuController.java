package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.nav.constant.FrontNavConstants;
import com.geshanzsq.nav.domain.vo.FrontMenuVO;
import com.geshanzsq.nav.service.IFrontMenuService;
import com.geshanzsq.nav.utils.NavMenuSiteUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 前台导航页面展示
 * @author geshanzsq
 * @date 2020/7/28
 */
@RequestMapping("/frontNav")
@RestController
public class FrontMenuController extends BaseController {

    @Autowired
    private IFrontMenuService frontNavService;

    /**
     * 获取导航菜单
     * @return
     */
    @GetMapping
    public AjaxResult menu() {
        AjaxResult ajaxResult = AjaxResult.success();
        //菜单列表
        List<FrontMenuVO> menuList = frontNavService.getSystemNavMenu();
        //获取网站列表
        List<FrontMenuVO> siteList = frontNavService.getSystemNavSite(menuList);
        ajaxResult.put(FrontNavConstants.FRONT_MENU,menuList);
        ajaxResult.put(FrontNavConstants.FRONT_SITE,siteList);
        return ajaxResult;
    }


    /**
     * 查询站点
     */
    @GetMapping("/search/{siteName}")
    public AjaxResult search(@PathVariable("siteName") String siteName) {

        //菜单列表
        List<FrontMenuVO> menuList = frontNavService.getSystemNavMenu();
        //查询站点
        List<FrontMenuVO> siteList = frontNavService.searchSiteByName(siteName);

        // 去除没有网站的导航菜单和网站
        NavMenuSiteUtils.removeNotSiteMenu(menuList,siteList);

        AjaxResult ajaxResult = AjaxResult.success();
        ajaxResult.put(FrontNavConstants.FRONT_MENU,menuList);
        ajaxResult.put(FrontNavConstants.FRONT_SITE,siteList);
        return ajaxResult;
    }

}
