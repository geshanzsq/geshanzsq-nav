package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.annotation.Log;
import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.enums.BusinessType;
import com.geshanzsq.common.enums.CommonStatus;
import com.geshanzsq.common.utils.SecurityUtils;
import com.geshanzsq.nav.domain.NavMenu;
import com.geshanzsq.nav.service.INavMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * 导航菜单Controller
 * 
 * @author geshanzsq
 * @date 2020-07-10
 */
@RestController
@RequestMapping("/nav/menu")
public class NavMenuController extends BaseController
{
    @Autowired
    private INavMenuService navMenuService;

    /**
     * 查询导航菜单列表
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:list')")
    @GetMapping("/list")
    public AjaxResult list(NavMenu navMenu)
    {
        List<NavMenu> menus = navMenuService.selectNavMenuTreeList(navMenu);
        return AjaxResult.success(menus);
    }

    /**
     * 获取导航菜单下拉树列表
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:treeSelect')")
    @GetMapping("/treeSelect")
    public AjaxResult treeSelect(NavMenu navMenu) {
        navMenu.setStatus(CommonStatus.OK.code);
        List<NavMenu> menus = navMenuService.selectNavMenuList(navMenu);
        return AjaxResult.success(navMenuService.buildNavMenuTreeSelect(menus));
    }

    /**
     * 获取导航菜单详细信息
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:query')")
    @GetMapping(value = "/{menuId}")
    public AjaxResult getInfo(@PathVariable("menuId") Long menuId)
    {
        return AjaxResult.success(navMenuService.selectNavMenuById(menuId));
    }

    /**
     * 新增导航菜单
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:add')")
    @Log(title = "导航菜单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody NavMenu navMenu)
    {
        navMenu.setCreateBy(SecurityUtils.getUsername());
        return toAjax(navMenuService.insertNavMenu(navMenu));
    }

    /**
     * 修改导航菜单
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:edit')")
    @Log(title = "导航菜单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NavMenu navMenu)
    {
        navMenu.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(navMenuService.updateNavMenu(navMenu));
    }

    /**
     * 删除导航菜单
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:remove')")
    @Log(title = "导航菜单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{menuId}")
    public AjaxResult remove(@PathVariable Long menuId)
    {
        NavMenu navMenu = new NavMenu();
        navMenu.setParentId(menuId);
        if (navMenuService.selectNavMenuList(navMenu).size() > 0) {
            return AjaxResult.error("当前菜单下有子菜单，删除失败！");
        }
        return toAjax(navMenuService.deleteNavMenuById(menuId));
    }

    /**
     * 获取该子菜单下最大的排序
     * @param menuId
     * @return
     */
    @PreAuthorize("@ss.hasPermi('nav:menu:getMaxChildrenMenuOrderNum')")
    @GetMapping("/getMaxChildrenMenuOrderNum")
    public AjaxResult getMaxChildrenMenuOrderNum(Long menuId) {
        Integer orderNum = navMenuService.getMaxChildrenMenuOrderNum(menuId);
        return AjaxResult.success(orderNum);
    }

}
