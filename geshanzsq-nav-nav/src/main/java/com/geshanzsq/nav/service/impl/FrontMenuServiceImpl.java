package com.geshanzsq.nav.service.impl;

import com.geshanzsq.common.core.domain.entity.SysUser;
import com.geshanzsq.common.core.redis.RedisCache;
import com.geshanzsq.common.enums.CommonStatus;
import com.geshanzsq.nav.constant.FrontNavConstants;
import com.geshanzsq.nav.domain.vo.FrontMenuVO;
import com.geshanzsq.nav.domain.vo.FrontSiteVO;
import com.geshanzsq.nav.mapper.FrontMenuMapper;
import com.geshanzsq.nav.service.IFrontMenuService;
import com.geshanzsq.nav.utils.NavMenuSiteUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

/**
 * 前台导航页面展示
 * @author geshanzsq
 * @date 2020/7/28
 */
@Service
public class FrontMenuServiceImpl implements IFrontMenuService {

    @Autowired
    private FrontMenuMapper frontMenuMapper;

    @Autowired
    private RedisCache redisCache;

    /**
     * 更新前台导航
     */
    @Override
    public void updateFrontNavRedis() {
        // 更新前台导航菜单
        List<FrontMenuVO> menuList = frontMenuMapper.findFrontAllMenu(CommonStatus.OK.code);

        // 更新前台导航站点
        List<FrontSiteVO> siteList = frontMenuMapper.findFrontAllSite(CommonStatus.OK.code);
        List<FrontMenuVO> lastLevelMenuList = getLastLevelMenuList(menuList);
        setSiteToMenu(lastLevelMenuList,siteList);

        // 去除没有网站的导航菜单和网站
        NavMenuSiteUtils.removeNotSiteMenu(buildMenuTree(menuList),lastLevelMenuList);

        redisCache.deleteObject(FrontNavConstants.MENU);
        redisCache.setCacheList(FrontNavConstants.MENU, menuList);
        redisCache.deleteObject(FrontNavConstants.SITE);
        redisCache.setCacheList(FrontNavConstants.SITE, lastLevelMenuList);
    }

    /**
     * 查询站点
     * @param siteName
     * @return
     */
    @Override
    public List<FrontMenuVO> searchSiteByName(String siteName) {
        //搜索系统导航站点
        return searchSystemNavSite(siteName);
    }

    /**
     * 获取最后一级的菜单列表
     * @param menuList
     */
    @Override
    public List<FrontMenuVO> getLastLevelMenuList(List<FrontMenuVO> menuList) {
        List<FrontMenuVO> lastMenuList = new ArrayList<>();
        for (FrontMenuVO menu : menuList) {
            getLastLevelMenu(menu,lastMenuList);
        }
        return lastMenuList;
    }

    /**
     * 把网站数据放入到菜单
     * @param lastLevelMenuList 菜单列表
     * @param siteList 网站列表
     */
    @Override
    public void setSiteToMenu(List<FrontMenuVO> lastLevelMenuList, List<FrontSiteVO> siteList) {
        //把同一个菜单的网站放入一个Map，减少排序
        Map<Long,List<FrontSiteVO>> siteMap = new HashMap<>();
        for (FrontSiteVO site: siteList) {
            if (siteMap.get(site.getMenuId()) == null) {
                List<FrontSiteVO> list = new ArrayList<>();
                list.add(site);
                siteMap.put(site.getMenuId(),list);
            } else {
                siteMap.get(site.getMenuId()).add(site);
            }
        }

        // 把网站依次放入最后菜单的集合
        for (int i = 0 ;i < lastLevelMenuList.size(); i++) {
            lastLevelMenuList.get(i).setSiteList(siteMap.get(lastLevelMenuList.get(i).getMenuId()));
        }
    }

    /**
     * 递归获取最后一级菜单
     * @param menu
     * @param lastMenuList
     * @return
     */
    private void getLastLevelMenu(FrontMenuVO menu, List<FrontMenuVO> lastMenuList) {
        if (menu.getChildren().isEmpty()) {
            lastMenuList.add(menu);
        } else {
            for (FrontMenuVO childMenu: menu.getChildren()) {
                getLastLevelMenu(childMenu, lastMenuList);
            }
        }
    }



    /**
     * 构建前端所需要树结构
     *
     * @param menus 菜单列表
     * @return 树结构列表
     */
    @Override
    public List<FrontMenuVO> buildMenuTree(List<FrontMenuVO> menus) {
        List<FrontMenuVO> returnList = new ArrayList<>();
        for (Iterator<FrontMenuVO> iterator = menus.iterator(); iterator.hasNext();)
        {
            FrontMenuVO t = iterator.next();
            // 根据传入的某个父节点ID,遍历该父节点的所有子节点
            if (t.getParentId() == 0)
            {
                recursionFn(menus, t);
                returnList.add(t);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = menus;
        }
        return returnList;
    }

    /**
     * 递归列表
     *
     * @param list
     * @param t
     */
    private void recursionFn(List<FrontMenuVO> list, FrontMenuVO t)
    {
        // 得到子节点列表
        List<FrontMenuVO> childList = getChildList(list, t);
        t.setChildren(childList);
        for (FrontMenuVO tChild : childList)
        {
            if (hasChild(list, tChild))
            {
                // 判断是否有子节点
                Iterator<FrontMenuVO> it = childList.iterator();
                while (it.hasNext())
                {
                    FrontMenuVO n = (FrontMenuVO) it.next();
                    recursionFn(list, n);
                }
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<FrontMenuVO> getChildList(List<FrontMenuVO> list, FrontMenuVO t)
    {
        List<FrontMenuVO> tlist = new ArrayList<>();
        Iterator<FrontMenuVO> it = list.iterator();
        while (it.hasNext())
        {
            FrontMenuVO n = (FrontMenuVO) it.next();
            if (n.getParentId().longValue() == t.getMenuId().longValue())
            {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<FrontMenuVO> list, FrontMenuVO t)
    {
        return getChildList(list, t).size() > 0 ? true : false;
    }

    /**
     * 获取系统导航菜单
     */
    @Override
    public List<FrontMenuVO> getSystemNavMenu() {
        List<FrontMenuVO> navList = redisCache.getCacheList(FrontNavConstants.MENU);
        if (navList.isEmpty()) {
            navList = frontMenuMapper.findFrontAllMenu(CommonStatus.OK.code);
            redisCache.setCacheList(FrontNavConstants.MENU, navList);
        }
        return buildMenuTree(navList);
    }

    /**
     * 获取系统导航站点
     * @param menuList
     */
    @Override
    public List<FrontMenuVO> getSystemNavSite(List<FrontMenuVO> menuList) {
        List<FrontMenuVO> siteMenuList = redisCache.getCacheList(FrontNavConstants.SITE);
        if (!siteMenuList.isEmpty()) {
            return siteMenuList;
        }
        //获取所有导航站点
        List<FrontSiteVO> siteList = frontMenuMapper.findFrontAllSite(CommonStatus.OK.code);
        //获得最后一级菜单
        List<FrontMenuVO> lastLevelMenuList = getLastLevelMenuList(menuList);
        setSiteToMenu(lastLevelMenuList,siteList);
        // 去除没有网站的导航菜单和网站
        NavMenuSiteUtils.removeNotSiteMenu(menuList,lastLevelMenuList);
        redisCache.setCacheList(FrontNavConstants.SITE, lastLevelMenuList);
        return lastLevelMenuList;
    }

    /**
     * 搜索系统导航站点
     * @param siteName 网站名称
     */
    private List<FrontMenuVO> searchSystemNavSite(String siteName) {
        //系统导航站点
        List<FrontMenuVO> menuList = getSystemNavMenu();
        // 查询系统网站
        List<FrontSiteVO> siteList = frontMenuMapper.searchSiteByName(siteName, siteName, CommonStatus.OK.code);
        //获取最后一级的菜单列表
        List<FrontMenuVO> lastLevelMenuList = getLastLevelMenuList(menuList);
        setSiteToMenu(lastLevelMenuList,siteList);
        return lastLevelMenuList;
    }


}
