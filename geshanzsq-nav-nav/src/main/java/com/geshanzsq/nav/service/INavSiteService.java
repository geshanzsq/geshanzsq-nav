package com.geshanzsq.nav.service;

import com.geshanzsq.nav.domain.NavSite;

import java.util.List;

/**
 * 导航网站信息Service接口
 * 
 * @author geshanzsq
 * @date 2020-07-11
 */
public interface INavSiteService 
{
    /**
     * 查询导航网站信息
     * 
     * @param siteId 导航网站信息ID
     * @return 导航网站信息
     */
    public NavSite selectNavSiteById(Long siteId);

    /**
     * 查询导航网站信息列表
     * 
     * @param navSite 导航网站信息
     * @return 导航网站信息集合
     */
    public List<NavSite> selectNavSiteList(NavSite navSite);

    /**
     * 新增导航网站信息
     * 
     * @param navSite 导航网站信息
     * @return 结果
     */
    public int insertNavSite(NavSite navSite);

    /**
     * 修改导航网站信息
     * 
     * @param navSite 导航网站信息
     * @return 结果
     */
    public int updateNavSite(NavSite navSite);

    /**
     * 批量删除导航网站信息
     * 
     * @param siteIds 需要删除的导航网站信息ID
     * @return 结果
     */
    public int deleteNavSiteByIds(Long[] siteIds);

    /**
     * 删除导航网站信息信息
     * 
     * @param siteId 导航网站信息ID
     * @return 结果
     */
    public int deleteNavSiteById(Long siteId);

    /**
     * 更新点击量
     * @param siteId
     */
    boolean updateClickCountBySiteId(Long siteId);

    /**
     * 获取网站点击量
     */
    int getSiteClickCount(Integer status);

    /**
     * 网站数量
     */
    int getCount(Integer status);

    /**
     * 获取网站菜单下最大的排序
     * @param menuId 菜单id
     * @return
     */
    Integer getSiteMaxOrderNum(Long menuId);
}
