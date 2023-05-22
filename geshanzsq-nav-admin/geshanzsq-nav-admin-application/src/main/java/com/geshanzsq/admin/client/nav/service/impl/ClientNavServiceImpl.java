package com.geshanzsq.admin.client.nav.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.client.nav.constant.NavClientConstant;
import com.geshanzsq.admin.client.nav.mapstruct.ClientNavConverter;
import com.geshanzsq.admin.client.nav.service.ClientNavService;
import com.geshanzsq.admin.client.nav.util.NavClientCategoryUtils;
import com.geshanzsq.admin.client.nav.util.NavClientUtils;
import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import com.geshanzsq.admin.client.nav.vo.NavCategorySiteClientVO;
import com.geshanzsq.admin.client.nav.vo.NavClientListVO;
import com.geshanzsq.admin.nav.category.mapper.NavCategoryMapper;
import com.geshanzsq.admin.nav.category.mapstruct.NavCategoryConverter;
import com.geshanzsq.admin.nav.category.po.NavCategory;
import com.geshanzsq.admin.nav.site.mapper.NavSiteMapper;
import com.geshanzsq.admin.nav.site.mapstruct.NavSiteConverter;
import com.geshanzsq.admin.nav.site.po.NavSite;
import com.geshanzsq.admin.nav.site.vo.NavSiteClientVO;
import com.geshanzsq.common.core.enums.CommonStatus;
import com.geshanzsq.common.redis.service.RedisService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 导航工具类
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
@Service
public class ClientNavServiceImpl implements ClientNavService {

    @Autowired
    private NavCategoryMapper navCategoryMapper;
    @Autowired
    private NavSiteMapper navSiteMapper;

    @Autowired
    private RedisService redisService;

    /**
     * 分类网站列表
     */
    @Override
    public NavClientListVO categorySiteList() {
        // 从缓存获取分类数据
        List<NavCategoryClientVO> categories = redisService.get(NavClientConstant.CATEGORY_CACHE_PREFIX);
        if (categories == null) {
            // 从数据库获取
            return buildCategoryAndSiteList();
        }

        // 从缓存获取分类网站数据
        List<NavCategorySiteClientVO> siteList = redisService.get(NavClientConstant.SITE_CACHE_PREFIX);
        if (siteList == null) {
            return buildCategoryAndSiteList();
        }

        // 分类数据和分类网站数据都是从缓存获取
        return NavClientListVO.builder().categories(categories).sites(siteList).build();
    }


    /**
     * 分类列表
     */
    @Override
    public List<NavCategoryClientVO> categoryList() {
        // 从缓存获取分类数据
        List<NavCategoryClientVO> categories = redisService.get(NavClientConstant.CATEGORY_CACHE_PREFIX);
        if (CollectionUtils.isEmpty(categories)) {
            // 从数据库获取
            categories = new ArrayList<>();
            List<NavCategorySiteClientVO> siteList = new ArrayList<>();
            buildCategoryAndSiteList();
        }
        return categories;
    }

    /**
     * 清除缓存
     */
    @Override
    public void removeCache() {
        // 清除缓存，等后续访问时会自动从数据库获取
        redisService.delete(NavClientConstant.CATEGORY_CACHE_PREFIX);
        redisService.delete(NavClientConstant.SITE_CACHE_PREFIX);
    }

    /**
     * 站内分类网站搜索列表
     */
    @Override
    public NavClientListVO categorySiteSearchList(String searchContent) {
        NavClientListVO clientListVO = new NavClientListVO();
        if (StringUtils.isBlank(searchContent)) {
            return clientListVO;
        }

        // 查询网站数据
        LambdaQueryWrapper<NavSite> siteWrapper = new LambdaQueryWrapper<>();
        siteWrapper.eq(NavSite::getStatus, CommonStatus.NORMAL.code);
        siteWrapper.and(wrapper -> {
            wrapper.or().like(NavSite::getSiteName, searchContent);
            wrapper.or().like(NavSite::getSiteDescription, searchContent);
        });
        siteWrapper.orderByAsc(NavSite::getCategoryId, NavSite::getSort);
        siteWrapper.select(NavSite::getId, NavSite::getCategoryId, NavSite::getSiteName, NavSite::getSitePath,
                NavSite::getSiteDescription, NavSite::getSiteUrl);
        List<NavSite> siteSearchList = navSiteMapper.selectList(siteWrapper);
        if (CollectionUtils.isEmpty(siteSearchList)) {
            return clientListVO;
        }

        // 通过分类 ids 获取所有上级分类
        Set<Long> categoryIds = siteSearchList.stream().map(NavSite::getCategoryId).collect(Collectors.toSet());
        List<NavCategory> navCategoryList = new ArrayList<>();
        getCategoryParent(categoryIds, navCategoryList);

        // 构建树形结构
        List<NavCategoryClientVO> categories = NavClientCategoryUtils.buildTree(
                ClientNavConverter.INSTANCE.convertCategory(navCategoryList), 0L);

        // 获取最后一级分类
        List<NavCategoryClientVO> lastLevelCategoryList = new ArrayList<>();
        NavClientCategoryUtils.buildLastLevelCategoryList(categories, lastLevelCategoryList);
        // 最后一级为空，直接返回
        if (CollectionUtils.isEmpty(lastLevelCategoryList)) {
            return clientListVO;
        }

        List<NavSiteClientVO> siteList = NavSiteConverter.INSTANCE.convertCilent(siteSearchList);

        // 构建分类下的网站
        List<NavCategorySiteClientVO> categorySiteList = NavCategoryConverter.INSTANCE.convertSiteClient(lastLevelCategoryList);
        categorySiteList.parallelStream().forEach(category -> {
            List<NavSiteClientVO> siteClientList = siteList.stream().filter(
                    site -> category.getId().equals(site.getCategoryId())).collect(Collectors.toList());
            category.setSites(siteClientList);
        });

        // 过滤没有网站的分类网站
        categorySiteList = categorySiteList.stream().filter(item -> !CollectionUtils.isEmpty(item.getSites())).collect(Collectors.toList());

        // 过滤没有网站的分类
        NavClientUtils.filterCategoryNotSite(categories, categorySiteList);

        clientListVO.setCategories(categories);
        clientListVO.setSites(categorySiteList);
        return clientListVO;
    }


    /**
     * 通过分类 ids 获取所有上级分类
     *
     * @param categoryIds 分类 ids
     * @param categoryList 保存的分类
     */
    private void getCategoryParent(Set<Long> categoryIds, List<NavCategory> categoryList) {
        if (CollectionUtils.isEmpty(categoryIds)) {
            return;
        }
        // 获取分类
        LambdaQueryWrapper<NavCategory> categoryWrapper = new LambdaQueryWrapper<>();
        categoryWrapper.in(NavCategory::getId, categoryIds);
        categoryWrapper.eq(NavCategory::getStatus, CommonStatus.NORMAL.code);
        categoryWrapper.orderByAsc(NavCategory::getSort);
        List<NavCategory> childrenList = navCategoryMapper.selectList(categoryWrapper);
        if (CollectionUtils.isEmpty(childrenList)) {
            return;
        }
        categoryList.addAll(childrenList);
        categoryIds = childrenList.stream().filter(category -> category.getParentId() != null && category.getParentId() > 0)
                .map(NavCategory::getParentId).collect(Collectors.toSet());
        // 递归获取父分类
        getCategoryParent(categoryIds, categoryList);
    }

    /**
     * 构建分类和网站数据
     */
    private NavClientListVO buildCategoryAndSiteList() {
        // 获取分类列表并构建树形结构
        LambdaQueryWrapper<NavCategory> categoryWrapper = new LambdaQueryWrapper<>();
        categoryWrapper.eq(NavCategory::getStatus, CommonStatus.NORMAL.code);
        categoryWrapper.orderByAsc(NavCategory::getSort);
        // 构建树形结构
        List<NavCategoryClientVO> categories = NavClientCategoryUtils.buildTree(
                ClientNavConverter.INSTANCE.convertCategory(navCategoryMapper.selectList(categoryWrapper)), 0L);

        // 获取最后一级分类
        List<NavCategoryClientVO> lastLevelCategoryList = new ArrayList<>();
        NavClientCategoryUtils.buildLastLevelCategoryList(categories, lastLevelCategoryList);
        // 最后一级为空，更新缓存为空
        if (CollectionUtils.isEmpty(lastLevelCategoryList)) {
            setCategoryCache(new ArrayList<>());
            setSiteCache(new ArrayList<>());
            return NavClientListVO.builder().categories(new ArrayList<>()).sites(new ArrayList<>()).build();
        }
        // 获取最后一级分类所有 id
        Set<Long> categoryIds = lastLevelCategoryList.parallelStream().map(c -> c.getId()).collect(Collectors.toSet());

        // 获取网站数据
        LambdaQueryWrapper<NavSite> siteWrapper = new LambdaQueryWrapper<>();
        siteWrapper.in(NavSite::getCategoryId, categoryIds);
        siteWrapper.eq(NavSite::getStatus, CommonStatus.NORMAL.code);
        siteWrapper.orderByAsc(NavSite::getCategoryId, NavSite::getSort);
        siteWrapper.select(NavSite::getId, NavSite::getCategoryId, NavSite::getSiteName, NavSite::getSitePath,
                NavSite::getSiteDescription, NavSite::getSiteUrl);
        List<NavSiteClientVO> siteList = NavSiteConverter.INSTANCE.convertCilent(navSiteMapper.selectList(siteWrapper));

        // 构建分类下的网站
        List<NavCategorySiteClientVO> categorySiteList = NavCategoryConverter.INSTANCE.convertSiteClient(lastLevelCategoryList);
        categorySiteList.parallelStream().forEach(category -> {
            List<NavSiteClientVO> siteClientList = siteList.stream().filter(
                    site -> category.getId().equals(site.getCategoryId())).collect(Collectors.toList());
            category.setSites(siteClientList);
        });

        // 过滤没有网站的分类网站
        categorySiteList = categorySiteList.stream().filter(item -> !CollectionUtils.isEmpty(item.getSites())).collect(Collectors.toList());

        // 过滤没有网站的分类
        NavClientUtils.filterCategoryNotSite(categories, categorySiteList);

        // 存入缓存
        setCategoryCache(categories);
        setSiteCache(categorySiteList);

        NavClientListVO clientListVO = NavClientListVO.builder().categories(categories).sites(categorySiteList).build();
        return clientListVO;
    }


    /**
     * 设置分类缓存
     */
    private void setCategoryCache(List<NavCategoryClientVO> list) {
        // 存入缓存，默认为 7 天
        redisService.set(NavClientConstant.CATEGORY_CACHE_PREFIX, list, 7, TimeUnit.DAYS);
    }

    /**
     * 设置网站缓存
     */
    private void setSiteCache(List<NavCategorySiteClientVO> list) {
        // 存入缓存，默认为 7 天
        redisService.set(NavClientConstant.SITE_CACHE_PREFIX, list, 7, TimeUnit.DAYS);
    }


}
