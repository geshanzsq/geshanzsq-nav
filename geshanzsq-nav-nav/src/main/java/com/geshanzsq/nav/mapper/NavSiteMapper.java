package com.geshanzsq.nav.mapper;

import com.geshanzsq.nav.domain.NavSite;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 导航网站信息Mapper接口
 * 
 * @author geshanzsq
 * @date 2020-07-11
 */
public interface NavSiteMapper 
{
    /**
     * 查询导航网站信息
     * 
     * @param siteId 导航网站信息ID
     * @return 导航网站信息
     */
    public NavSite selectNavSiteById(@Param("siteId") Long siteId);

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
     * 删除导航网站信息
     * 
     * @param siteId 导航网站信息ID
     * @return 结果
     */
    public int deleteNavSiteById(@Param("siteId") Long siteId);

    /**
     * 批量删除导航网站信息
     * 
     * @param siteIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteNavSiteByIds(Long[] siteIds);

    /**
     * 更新点击量
     * @param siteId
     */
    int updateClickCountBySiteId(@Param("siteId") Long siteId);

    /**
     * 获取网站点击量
     */
    int getSiteClickCount(@Param("status") Integer status);

    /**
     * 网站数量
     */
    int getCount(@Param("status") Integer status);

    /**
     * 获取网站菜单下最大的排序
     * @param menuId 菜单id
     * @return
     */
    Integer getSiteMaxOrderNum(@Param("menuId") Long menuId);

}
