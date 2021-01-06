package com.geshanzsq.nav.service;

import com.geshanzsq.common.core.domain.entity.SysUser;
import com.geshanzsq.nav.domain.vo.FrontMenuVO;
import com.geshanzsq.nav.domain.vo.FrontSiteVO;

import java.util.List;

/**
 * 前台导航页面展示
 * @author geshanzsq
 * @date 2020/7/28
 */
public interface IFrontMenuService {

    /**
     * 更新前台导航
     */
    void updateFrontNavRedis();

    /**
     * 查询站点
     * @param siteName
     * @return
     */
    List<FrontMenuVO> searchSiteByName(String siteName);


    /**
     * 获取最后一级的菜单列表
     * @param menuList
     */
    List<FrontMenuVO> getLastLevelMenuList(List<FrontMenuVO> menuList);

    /**
     * 把网站数据放入到菜单
     * @param lastLevelMenuList 菜单列表
     * @param siteList 网站列表
     */
    void setSiteToMenu(List<FrontMenuVO> lastLevelMenuList, List<FrontSiteVO> siteList);

    List<FrontMenuVO> buildMenuTree(List<FrontMenuVO> menus);

    /**
     * 获取系统导航菜单
     */
    List<FrontMenuVO> getSystemNavMenu();

    /**
     * 获取系统导航站点
     * @param menuList
     */
    List<FrontMenuVO> getSystemNavSite(List<FrontMenuVO> menuList);
}
