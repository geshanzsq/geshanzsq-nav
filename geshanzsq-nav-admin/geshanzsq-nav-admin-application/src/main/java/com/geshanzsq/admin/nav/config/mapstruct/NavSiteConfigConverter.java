package com.geshanzsq.admin.nav.config.mapstruct;

import com.geshanzsq.admin.nav.config.dto.NavSiteConfigUpdateDTO;
import com.geshanzsq.admin.nav.config.po.NavSiteConfig;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigAboutVO;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * 网站配置对象转换
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
@Mapper
public interface NavSiteConfigConverter {

    NavSiteConfigConverter INSTANCE = Mappers.getMapper(NavSiteConfigConverter.class);

    PageVO<NavSiteConfigVO> convert(PageVO<NavSiteConfig> pageVO);

    NavSiteConfigVO convert(NavSiteConfig navSiteConfig);

    NavSiteConfig convert(NavSiteConfigUpdateDTO updateDTO);

    NavSiteConfigAboutVO convertAbout(NavSiteConfig navSiteConfig);

}