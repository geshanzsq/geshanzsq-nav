package com.geshanzsq.system.mapper;

import com.geshanzsq.system.domain.SysWebConfig;

/**
 * 网站配置Mapper接口
 * 
 * @author geshanzsq
 * @date 2021-02-28
 */
public interface SysWebConfigMapper 
{

    /**
     * 查询网站配置
     */
    public SysWebConfig selectSysWebConfig();

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
