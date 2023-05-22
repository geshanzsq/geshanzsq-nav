package com.geshanzsq.admin.nav.site.service;

import com.geshanzsq.admin.client.search.vo.NavClientSiteSearchVO;
import com.geshanzsq.admin.nav.site.dto.*;
import com.geshanzsq.admin.nav.site.po.NavSite;
import com.geshanzsq.admin.nav.site.vo.NavSiteLatestCollectVO;
import com.geshanzsq.admin.nav.site.vo.NavSiteMatchVO;
import com.geshanzsq.admin.nav.site.vo.NavSiteVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.service.BaseService;

import java.util.List;
import java.util.Set;

/**
 * 导航网站
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
public interface NavSiteService extends BaseService<NavSite> {

    /**
     * 分页列表
     */
    PageVO<NavSiteVO> pageList(NavSitePageDTO pageDTO);

    /**
     * 新增
     */
    void save(NavSiteAddDTO addDTO);

    /**
     * 修改
     */
    void updateById(NavSiteUpdateDTO updateDTO);

    /**
     * 删除
     */
    void removeByIds(Long[] ids);

    /**
     * 获取最大排序
     */
    Integer getMaxSortByCategoryId(Long categoryId);

    /**
     * 更新点击量
     */
    void updateClickCountById(Long id);


    /**
     * 站內网站搜索
     */
    List<NavClientSiteSearchVO> siteSearch(String searchContent);

}
