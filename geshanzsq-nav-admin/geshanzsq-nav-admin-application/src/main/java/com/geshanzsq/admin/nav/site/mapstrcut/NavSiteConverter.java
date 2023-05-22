package com.geshanzsq.admin.nav.site.mapstruct;

import com.geshanzsq.admin.nav.site.dto.NavSiteAddDTO;
import com.geshanzsq.admin.nav.site.dto.NavSiteUpdateDTO;
import com.geshanzsq.admin.nav.site.dto.NavSiteUpdateSortDTO;
import com.geshanzsq.admin.nav.site.po.NavSite;
import com.geshanzsq.admin.nav.site.vo.NavSiteClientVO;
import com.geshanzsq.admin.nav.site.vo.NavSiteLatestCollectVO;
import com.geshanzsq.admin.nav.site.vo.NavSiteMatchVO;
import com.geshanzsq.admin.nav.site.vo.NavSiteVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 导航网站对象转换
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Mapper
public interface NavSiteConverter {

    NavSiteConverter INSTANCE = Mappers.getMapper(NavSiteConverter.class);

    PageVO<NavSiteVO> convert(PageVO<NavSite> pageVO);

    NavSiteVO convert(NavSite navSite);

    NavSite convert(NavSiteAddDTO addDTO);

    NavSite convert(NavSiteUpdateDTO updateDTO);

    NavSiteMatchVO convertMatch(NavSite navSite);

    List<NavSite> convert(List<NavSiteUpdateSortDTO> list);

    List<NavSiteClientVO> convertCilent(List<NavSite> list);

    List<NavSiteLatestCollectVO> convertCollect(List<NavSite> list);

}