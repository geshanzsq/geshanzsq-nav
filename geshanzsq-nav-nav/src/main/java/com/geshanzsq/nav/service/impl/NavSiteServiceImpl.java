package com.geshanzsq.nav.service.impl;

import com.geshanzsq.common.utils.DateUtils;
import com.geshanzsq.nav.domain.NavSite;
import com.geshanzsq.nav.mapper.NavSiteMapper;
import com.geshanzsq.nav.service.IFrontMenuService;
import com.geshanzsq.nav.service.INavSiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 导航网站信息Service业务层处理
 * 
 * @author geshanzsq
 * @date 2020-07-11
 */
@Service
public class NavSiteServiceImpl implements INavSiteService
{
    @Autowired
    private NavSiteMapper navSiteMapper;

    @Autowired
    private IFrontMenuService frontMenuService;

    /**
     * 查询导航网站信息
     * 
     * @param siteId 导航网站信息ID
     * @return 导航网站信息
     */
    @Override
    public NavSite selectNavSiteById(Long siteId)
    {
        return navSiteMapper.selectNavSiteById(siteId);
    }

    /**
     * 查询导航网站信息列表
     * 
     * @param navSite 导航网站信息
     * @return 导航网站信息
     */
    @Override
    public List<NavSite> selectNavSiteList(NavSite navSite)
    {
        return navSiteMapper.selectNavSiteList(navSite);
    }

    /**
     * 新增导航网站信息
     * 
     * @param navSite 导航网站信息
     * @return 结果
     */
    @Override
    public int insertNavSite(NavSite navSite)
    {
        navSite.setCreateTime(DateUtils.getNowDate());
        int result = navSiteMapper.insertNavSite(navSite);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 修改导航网站信息
     * 
     * @param navSite 导航网站信息
     * @return 结果
     */
    @Override
    public int updateNavSite(NavSite navSite)
    {
        navSite.setUpdateTime(DateUtils.getNowDate());
        int result = navSiteMapper.updateNavSite(navSite);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 批量删除导航网站信息
     * 
     * @param siteIds 需要删除的导航网站信息ID
     * @return 结果
     */
    @Override
    public int deleteNavSiteByIds(Long[] siteIds)
    {
        int result = navSiteMapper.deleteNavSiteByIds(siteIds);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 删除导航网站信息信息
     * 
     * @param siteId 导航网站信息ID
     * @return 结果
     */
    @Override
    public int deleteNavSiteById(Long siteId)
    {
        int result = navSiteMapper.deleteNavSiteById(siteId);
        if (result > 0) {
            //更新前台导航
            frontMenuService.updateFrontNavRedis();
        }
        return result;
    }

    /**
     * 更新点击量
     * @param siteId
     */
    @Override
    public boolean updateClickCountBySiteId(Long siteId) {
        return navSiteMapper.updateClickCountBySiteId(siteId) > 0;
    }

    /**
     * 获取网站点击量
     */
    @Override
    public int getSiteClickCount(Integer status) {
        return navSiteMapper.getSiteClickCount(status);
    }

    /**
     * 网站数量
     */
    @Override
    public int getCount(Integer status) {
        return navSiteMapper.getCount(status);
    }

    /**
     * 获取网站菜单下最大的排序
     * @param menuId 菜单id
     * @return
     */
    @Override
    public Integer getSiteMaxOrderNum(Long menuId) {
        return navSiteMapper.getSiteMaxOrderNum(menuId);
    }

}
