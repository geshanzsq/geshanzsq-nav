package com.geshanzsq.admin.nav.config.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.nav.config.dto.NavSiteConfigUpdateDTO;
import com.geshanzsq.admin.nav.config.mapper.NavSiteConfigMapper;
import com.geshanzsq.admin.nav.config.mapstruct.NavSiteConfigConverter;
import com.geshanzsq.admin.nav.config.po.NavSiteConfig;
import com.geshanzsq.admin.nav.config.service.NavSiteConfigService;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigAboutVO;
import com.geshanzsq.admin.nav.config.vo.NavSiteConfigVO;
import com.geshanzsq.admin.system.user.mapper.SysUserMapper;
import com.geshanzsq.admin.system.user.po.SysUser;
import com.geshanzsq.common.framework.manager.AsyncManager;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 网站配置
 *
 * @author geshanzsq
 * @date 2022/12/11
 */
@Service
public class NavSiteConfigServiceImpl extends BaseServiceImpl<NavSiteConfigMapper, NavSiteConfig> implements NavSiteConfigService {

    @Autowired
    private NavSiteConfigMapper navSiteConfigMapper;
    @Autowired
    private SysUserMapper sysUserMapper;


    /**
     * 获取配置
     */
    @Override
    public NavSiteConfigVO getConfig() {
        LambdaQueryWrapper<NavSiteConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.last(" limit 1");
        NavSiteConfig navSiteConfig = navSiteConfigMapper.selectOne(wrapper);
        return NavSiteConfigConverter.INSTANCE.convert(navSiteConfig);
    }

    /**
     * 更新
     */
    @Override
    public void updateById(NavSiteConfigUpdateDTO updateDTO) {
        NavSiteConfig navSiteConfig = NavSiteConfigConverter.INSTANCE.convert(updateDTO);
        if (navSiteConfig.getId() == null) {
            navSiteConfigMapper.insert(navSiteConfig);
        } else {
            navSiteConfigMapper.updateById(navSiteConfig);
        }
        updateDTO.setId(navSiteConfig.getId());
    }

    /**
     * 关于本站
     */
    @Override
    public NavSiteConfigAboutVO about() {
        LambdaQueryWrapper<NavSiteConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.last(" limit 1");
        NavSiteConfig navSiteConfig = navSiteConfigMapper.selectOne(wrapper);
        if (navSiteConfig == null) {
            return null;
        }

        NavSiteConfigAboutVO navSiteConfigAboutVO = NavSiteConfigConverter.INSTANCE.convertAbout(navSiteConfig);

        // 获取作者
        LambdaQueryWrapper<SysUser> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(SysUser::getId, navSiteConfig.getCreateUserId());
        userWrapper.select(SysUser::getNickName, SysUser::getAvatar);
        SysUser sysUser = sysUserMapper.selectOne(userWrapper);
        if (sysUser != null) {
            navSiteConfigAboutVO.setNickName(sysUser.getNickName());
            navSiteConfigAboutVO.setAvatar(sysUser.getAvatar());
        }

        // 更新访问量
        AsyncManager.me().execute(() -> navSiteConfigMapper.updateVisitCount(navSiteConfig.getId()));

        return navSiteConfigAboutVO;
    }
}
