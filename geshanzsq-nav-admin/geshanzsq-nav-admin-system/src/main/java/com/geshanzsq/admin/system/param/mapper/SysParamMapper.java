package com.geshanzsq.admin.system.param.mapper;

import com.geshanzsq.admin.system.param.po.SysParam;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * 参数配置
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
@Mapper
public interface SysParamMapper extends BaseMapperPlus<SysParam> {

    /**
     * 获取最大排序
     */
    Integer selectMaxSort();
}
