package com.geshanzsq.admin.client.nav.service;

import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import com.geshanzsq.admin.client.nav.vo.NavClientListVO;

import java.util.List;

/**
 * 导航客户端
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
public interface ClientNavService {

    /**
     * 分类网站列表
     */
    NavClientListVO categorySiteList();

    /**
     * 分类列表
     */
    List<NavCategoryClientVO> categoryList();

    /**
     * 清除缓存
     */
    void removeCache();

    /**
     * 站内分类网站搜索列表
     */
    NavClientListVO categorySiteSearchList(String searchContent);
}
