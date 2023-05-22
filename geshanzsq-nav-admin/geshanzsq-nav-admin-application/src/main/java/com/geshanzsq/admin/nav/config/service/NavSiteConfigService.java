package com.geshanzsq.admin.nav.config.service;

import com.geshanzsq.admin.nav.config.dto.NavSiteConfigUpdateDTO;
import com.geshanzsq.admin.nav.config.po.NavSiteConfig;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigAboutVO;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigVO;
import com.geshanzsq.common.framework.web.service.BaseService;

/**
 * 网站配置
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
public interface NavSiteConfigService extends BaseService<NavSiteConfig> {


    /**
     * 获取配置
     */
    NavSiteConfigVO getConfig();

    /**
     * 更新
     */
    void updateById(NavSiteConfigUpdateDTO updateDTO);


    /**
     * 关于本站
     */
    NavSiteConfigAboutVO about();

}
