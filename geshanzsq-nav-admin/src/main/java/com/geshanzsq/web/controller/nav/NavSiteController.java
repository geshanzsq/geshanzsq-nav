package com.geshanzsq.web.controller.nav;

import com.geshanzsq.common.annotation.Log;
import com.geshanzsq.common.core.controller.BaseController;
import com.geshanzsq.common.core.domain.AjaxResult;
import com.geshanzsq.common.core.page.TableDataInfo;
import com.geshanzsq.common.enums.BusinessType;
import com.geshanzsq.common.utils.SecurityUtils;
import com.geshanzsq.nav.domain.NavSite;
import com.geshanzsq.nav.service.INavPictureService;
import com.geshanzsq.nav.service.INavSiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;

/**
 * 导航网站信息Controller
 * 
 * @author geshanzsq
 * @date 2020-07-11
 */
@RestController
@RequestMapping("/nav/site")
public class NavSiteController extends BaseController
{
    @Autowired
    private INavSiteService navSiteService;
    @Autowired
    private INavPictureService navPictureService;

    /**
     * 查询导航网站信息列表
     */
    @PreAuthorize("@ss.hasPermi('nav:site:list')")
    @GetMapping("/list")
    public TableDataInfo list(NavSite navSite)
    {
        startPage();
        List<NavSite> list = navSiteService.selectNavSiteList(navSite);
        return getDataTable(list);
    }


    /**
     * 获取导航网站信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('nav:site:query')")
    @GetMapping(value = "/{siteId}")
    public AjaxResult getInfo(@PathVariable("siteId") Long siteId)
    {
        return AjaxResult.success(navSiteService.selectNavSiteById(siteId));
    }

    /**
     * 新增导航网站信息
     */
    @PreAuthorize("@ss.hasPermi('nav:site:add')")
    @Log(title = "导航网站信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody NavSite navSite)
    {
        navSite.setCreateBy(SecurityUtils.getUsername());
        return toAjax(navSiteService.insertNavSite(navSite));
    }

    /**
     * 修改导航网站信息
     */
    @PreAuthorize("@ss.hasPermi('nav:site:edit')")
    @Log(title = "导航网站信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NavSite navSite)
    {
        navSite.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(navSiteService.updateNavSite(navSite));
    }

    /**
     * 删除导航网站信息
     */
    @PreAuthorize("@ss.hasPermi('nav:site:remove')")
    @Log(title = "导航网站信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{siteIds}")
    public AjaxResult remove(@PathVariable Long[] siteIds)
    {
        return toAjax(navSiteService.deleteNavSiteByIds(siteIds));
    }

    /**
     * 网站图片上传
     */
    @PreAuthorize("@ss.hasPermi('nav:site:uploadSiteImg')")
    @Log(title = "导航网站信息-网站图片上传", businessType = BusinessType.OTHER)
    @PostMapping("/uploadSiteImg")
    public AjaxResult uploadSiteImg(@RequestParam("pictureFile") MultipartFile file) {
        if (file == null) {
            return AjaxResult.error("请选择需要上传的图片！");
        }

        // 上传并返回新文件名称
        try {
            String fileName = navPictureService.getUploadFileName(SecurityUtils.getUsername(),"system",file);
            return AjaxResult.success("上传网站图片成功！",fileName);
        } catch (IOException e) {
            logger.error("上传图片出错：",e);
        }
        return AjaxResult.error("上传网站图片失败！");
    }

    /**
     * 获取网站菜单下最大的排序
     */
    @PreAuthorize("@ss.hasPermi('nav:site:getSiteMaxOrderNum')")
    @GetMapping("/getSiteMaxOrderNum")
    public AjaxResult getSiteMaxOrderNum(Long menuId) {
        return AjaxResult.success(navSiteService.getSiteMaxOrderNum(menuId));
    }
}
