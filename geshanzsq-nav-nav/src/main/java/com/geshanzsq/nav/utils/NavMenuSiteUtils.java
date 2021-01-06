package com.geshanzsq.nav.utils;

import com.geshanzsq.nav.domain.vo.FrontMenuVO;

import java.util.ArrayList;
import java.util.List;

/**
 * 导航菜单网站工具类
 * @author geshanzsq
 * @date 2020/12/23
 */
public class NavMenuSiteUtils {

    /**
     * 去除没有网站的导航菜单和网站
     */
    public static void removeNotSiteMenu(List<FrontMenuVO> menuList, List<FrontMenuVO> siteList) {
        if (menuList == null || siteList == null) {
            menuList = new ArrayList<>();
            siteList = new ArrayList<>();
            return;
        }
        if (menuList.size() == 0 || siteList.size() == 0) {
            menuList = new ArrayList<>();
            siteList = new ArrayList<>();
            return;
        }
        // 去除没有网站的最后一级菜单
        for (int i = 0 ; i < siteList.size(); i++) {
            if (siteList.get(i).getSiteList() == null ||
                    ( siteList.get(i).getSiteList() != null && siteList.get(i).getSiteList().size() == 0)) {
                siteList.remove(i--);
                continue;
            }
        }
        //深度
        int deep = 0;
        for (int i = 0; i < menuList.size(); i++) {
            int childrenDeep = getMenuDeep(menuList.get(i), 0);
            deep = childrenDeep > deep ? childrenDeep : deep;
        }

        // 依次剔除最后一级没有网站的菜单
        for (int i = 1; i <= deep; i++) {
            removeNoSite(menuList,siteList);
        }
    }

    /**
     * 获取菜单深度
     */
    private static int getMenuDeep(FrontMenuVO menu, int deep) {
        if (menu.getChildren().size() > 0) {
            int deepChildren = deep;
            for (int i = 0; i < menu.getChildren().size(); i++) {
                int child =  getMenuDeep(menu.getChildren().get(i),deep + 1);
                deepChildren = child > deepChildren ? child : deepChildren;
            }
            return deepChildren;
        }
        return deep + 1;
    }

    /**
     * 依次剔除最后一级没有网站的菜单
     */
    private static void removeNoSite(List<FrontMenuVO> menuList, List<FrontMenuVO> siteList) {
        for (int t = 0 ; t < menuList.size(); t++) {
            FrontMenuVO menu = menuList.get(t);

            if (menu.getChildren().size() == 0) {
                boolean isExist = false;
                for (int i = 0; i < siteList.size(); i++) {
                    if (menu.getMenuId().equals(siteList.get(i).getMenuId())) {
                        isExist = true;
                        break;
                    }
                }
                if (!isExist) {
                    menuList.remove(t--);
                }
            } else {
                removeNoSite(menu.getChildren(),siteList);
            }
        }
    }
}
