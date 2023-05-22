package com.geshanzsq.admin.client.nav.util;

import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import com.geshanzsq.admin.client.nav.vo.NavCategorySiteClientVO;
import org.springframework.util.CollectionUtils;
import java.util.List;

/**
 * 导航客户端工具类
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
public class NavClientUtils {

    /**
     * 过滤没有网站的分类
     */
    public static void filterCategoryNotSite(List<NavCategoryClientVO> categoryList, List<NavCategorySiteClientVO> siteList) {
        if (CollectionUtils.isEmpty(categoryList) || CollectionUtils.isEmpty(siteList)) {
            return;
        }

        // 获取深度
        int deep = 0;
        for (NavCategoryClientVO category: categoryList) {
            int childrenDeep = getCategoryDeep(category, 0);
            deep = childrenDeep > deep ? childrenDeep : deep;
        }

        // 依次剔除最后一级没有网站的菜单
        for (int i = 1; i <= deep; i++) {
            filterNoSite(categoryList,siteList);
        }
    }

    /**
     * 获取分类深度
     */
    private static int getCategoryDeep(NavCategoryClientVO category, int deep) {
        // 没有子分类，深度加 1
        if (CollectionUtils.isEmpty(category.getChildren())) {
            return deep + 1;
        }

        int deepChildren = deep;
        for (NavCategoryClientVO children: category.getChildren()) {
            int child = getCategoryDeep(children, deep + 1);
            deepChildren = child > deepChildren ? child : deepChildren;
        }
        return deepChildren;

    }

    /**
     * 依次剔除最后一级没有网站的菜单
     */
    private static void filterNoSite(List<NavCategoryClientVO> categoryList,List<NavCategorySiteClientVO> siteList) {
        for (int t = 0 ; t < categoryList.size(); t++) {
            NavCategoryClientVO category = categoryList.get(t);
            if (CollectionUtils.isEmpty(category.getChildren())) {
                NavCategorySiteClientVO site = siteList.parallelStream()
                        .filter(s -> category.getId().equals(s.getId())).findFirst().orElse(null);
                // 不存在，移除
                if (site == null) {
                    categoryList.remove(t--);
                }
            } else {
                filterNoSite(category.getChildren(),siteList);
            }
        }

    }

}
