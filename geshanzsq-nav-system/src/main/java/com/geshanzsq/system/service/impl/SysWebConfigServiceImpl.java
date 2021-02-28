package com.geshanzsq.system.service.impl;

import com.geshanzsq.common.utils.DateUtils;
import com.geshanzsq.system.domain.SysWebConfig;
import com.geshanzsq.system.mapper.SysWebConfigMapper;
import com.geshanzsq.system.service.ISysWebConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 网站配置Service业务层处理
 * 
 * @author geshanzsq
 * @date 2021-02-28
 */
@Service
public class SysWebConfigServiceImpl implements ISysWebConfigService 
{
    @Autowired
    private SysWebConfigMapper sysWebConfigMapper;

    /**
     * 查询网站配置
     * 
     * @return 网站配置
     */
    @Override
    public SysWebConfig selectSysWebConfig(String username)
    {
        SysWebConfig webConfig = sysWebConfigMapper.selectSysWebConfig();
        if (webConfig == null) {
            // 新增
            webConfig = new SysWebConfig();
            webConfig.setCreateBy(username);
            webConfig.setCreateTime(new Date());
            sysWebConfigMapper.insertSysWebConfig(webConfig);
        }
        return webConfig;
    }

    /**
     * 新增网站配置
     * 
     * @param sysWebConfig 网站配置
     * @return 结果
     */
    @Override
    public int insertSysWebConfig(SysWebConfig sysWebConfig)
    {
        sysWebConfig.setCreateTime(DateUtils.getNowDate());
        return sysWebConfigMapper.insertSysWebConfig(sysWebConfig);
    }

    /**
     * 修改网站配置
     * 
     * @param sysWebConfig 网站配置
     * @return 结果
     */
    @Override
    public int updateSysWebConfig(SysWebConfig sysWebConfig)
    {
        sysWebConfig.setUpdateTime(DateUtils.getNowDate());
        return sysWebConfigMapper.updateSysWebConfig(sysWebConfig);
    }
}
