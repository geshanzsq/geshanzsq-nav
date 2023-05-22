package com.geshanzsq.admin.nav.config.mapper;

import com.geshanzsq.admin.nav.config.po.NavSiteConfig;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * 网站配置
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
@Mapper
public interface NavSiteConfigMapper extends BaseMapperPlus<NavSiteConfig> {

    /**
     * 更新访问量
     */
    void updateVisitCount(Long id);
}