package com.geshanzsq.system.service;

import com.geshanzsq.system.domain.SysWebConfig;

/**
 * 网站配置Service接口
 * 
 * @author geshanzsq
 * @date 2021-02-28
 */
public interface ISysWebConfigService 
{
    /**
     * 查询网站配置
     * 
     * @return 网站配置
     */
    public SysWebConfig selectSysWebConfig(String username);

    /**
     * 新增网站配置
     * 
     * @param sysWebConfig 网站配置
     * @return 结果
     */
    public int insertSysWebConfig(SysWebConfig sysWebConfig);

    /**
     * 修改网站配置
     * 
     * @param sysWebConfig 网站配置
     * @return 结果
     */
    public int updateSysWebConfig(SysWebConfig sysWebConfig);
}
