package com.geshanzsq.admin.nav.site.mapper;

import com.geshanzsq.admin.client.search.vo.NavClientSiteSearchVO;
import com.geshanzsq.admin.nav.site.dto.NavSiteListUserImportDTO;
import com.geshanzsq.admin.nav.site.po.NavSite;
import com.geshanzsq.admin.nav.site.vo.NavSiteVO;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 导航网站
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Mapper
public interface NavSiteMapper extends BaseMapperPlus<NavSite> {

    /**
     * 获取最大排序
     */
    Integer selectMaxSortByCategoryId(@Param("categoryId") Long categoryId);

    /**
     * 更新点击量
     */
    void updateClickCountById(@Param("id") Long id);

    /**
     * 查询列表
     */
    List<NavSiteVO> selectListByUserImport(NavSiteListUserImportDTO userImportDTO);

    /**
     * 站內网站搜索
     */
    List<NavClientSiteSearchVO> selectSiteSearchList(@Param("searchContent") String searchContent, @Param("status") Integer status);

    /**
     * 获取点击量
     */
    Long selectClickCount();
}