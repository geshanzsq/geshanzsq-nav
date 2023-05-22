package com.geshanzsq.admin.client.nav.util;

import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 客户端分类工具类
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
public class NavClientCategoryUtils {

    /**
     * 构建最后一级分类
     * @param categoryList 分类数据
     * @param lastLevelCategoryList 最后一级数据
     */
    public static void buildLastLevelCategoryList(List<NavCategoryClientVO> categoryList, List<NavCategoryClientVO> lastLevelCategoryList) {
        categoryList.stream().forEach(category -> {
            if (CollectionUtils.isEmpty(category.getChildren())) {
                // 最后一级
                lastLevelCategoryList.add(category);
            } else {
                // 不是最后一级，递归
                buildLastLevelCategoryList(category.getChildren(), lastLevelCategoryList);
            }
        });
    }

    /**
     * 根据父节点的 id 获取所有子节点
     *
     * @param allList 所有数据
     * @param parentId 传入的父节点 id
     */
    public static List<NavCategoryClientVO> buildTree(List<NavCategoryClientVO> allList, Long parentId) {
        List<NavCategoryClientVO> returnList = new ArrayList<>();
        for (NavCategoryClientVO category : allList) {
            // 根据传入的某个父节点 id，遍历该父节点的所有子节点
            if (parentId != null && parentId.equals(category.getParentId())) {
                // 递归
                recursive(allList, category);
                returnList.add(category);
            }
        }
        return returnList;
    }

    /**
     * 递归列表
     *
     * @param allList
     * @param category 当前分类
     */
    private static void recursive(List<NavCategoryClientVO> allList, NavCategoryClientVO category) {
        // 得到子节点列表
        List<NavCategoryClientVO> childList = getChildList(allList, category);
        category.setChildren(childList);
        for (NavCategoryClientVO tChild : childList) {
            if (hasChild(allList, tChild)) {
                recursive(allList, tChild);
            }
        }
    }

    /**
     * 判断是否有子节点
     */
    private static boolean hasChild(List<NavCategoryClientVO> allList, NavCategoryClientVO category) {
        return getChildList(allList, category).size() > 0;
    }

    /**
     * 得到子节点列表
     */
    private static List<NavCategoryClientVO> getChildList(List<NavCategoryClientVO> allList, NavCategoryClientVO category) {
        List<NavCategoryClientVO> childList = new ArrayList<>();
        Iterator<NavCategoryClientVO> it = allList.iterator();
        while (it.hasNext()) {
            NavCategoryClientVO child = it.next();
            if (category.getId().equals(child.getParentId())) {
                childList.add(child);
            }
        }
        return childList;
    }

}
