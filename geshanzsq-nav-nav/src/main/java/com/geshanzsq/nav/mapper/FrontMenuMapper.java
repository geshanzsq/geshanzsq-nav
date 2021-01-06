package com.geshanzsq.nav.mapper;


import com.geshanzsq.nav.domain.vo.FrontMenuVO;
import com.geshanzsq.nav.domain.vo.FrontSiteVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author geshanzsq
 * @date 2020/7/30
 */
public interface FrontMenuMapper {

    /**
     * 前台导航页面展示，获取所有导航菜单
     */
    List<FrontMenuVO> findFrontAllMenu(@Param("status") Integer status);

    /**
     * 前台导航页面展示，获取所有导航站点
     */
    List<FrontSiteVO> findFrontAllSite(@Param("status")Integer status);


    /**
     * 查询站点
     * @param siteName
     * @param siteDescription
     * @param status
     * @return
     */
    List<FrontSiteVO> searchSiteByName(@Param("siteName") String siteName,
                                       @Param("siteDescription") String siteDescription,
                                       @Param("status") Integer status);

}
