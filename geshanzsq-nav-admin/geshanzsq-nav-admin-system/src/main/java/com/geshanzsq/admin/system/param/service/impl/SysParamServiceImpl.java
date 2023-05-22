package com.geshanzsq.admin.system.param.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.param.constant.SysParamConstant;
import com.geshanzsq.admin.system.param.dto.SysParamAddDTO;
import com.geshanzsq.admin.system.param.dto.SysParamUpdateDTO;
import com.geshanzsq.admin.system.param.mapper.SysParamMapper;
import com.geshanzsq.admin.system.param.mapstruct.SysParamConverter;
import com.geshanzsq.admin.system.param.po.SysParam;
import com.geshanzsq.admin.system.param.service.SysParamService;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import com.geshanzsq.common.redis.service.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 参数配置
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
@Service
public class SysParamServiceImpl extends BaseServiceImpl<SysParamMapper, SysParam> implements SysParamService {

    @Autowired
    private SysParamMapper sysParamMapper;

    @Autowired
    private RedisService redisService;

    @Override
    public void save(SysParamAddDTO addDTO) {
        SysParam sysParam = SysParamConverter.INSTANCE.convert(addDTO);
        sysParamMapper.insert(sysParam);
        // 清除缓存
        removeCache(addDTO.getParamKey());
    }

    /**
     * 更新
     */
    @Override
    public void updateById(SysParamUpdateDTO updateDTO) {
        SysParam oldSysParam = sysParamMapper.selectById(updateDTO.getId());
        if (oldSysParam == null) {
            return;
        }
        SysParam sysParam = SysParamConverter.INSTANCE.convert(updateDTO);
        sysParamMapper.updateById(sysParam);
        // 清除缓存
        removeCache(oldSysParam.getParamKey());
    }


    /**
     * 删除
     */
    @Override
    public void removeByIds(Long[] ids) {
        if (ids == null || ids.length == 0) {
            return;
        }
        sysParamMapper.deleteBatchIds(Arrays.asList(ids));
        // 清除缓存
        LambdaQueryWrapper<SysParam> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(SysParam::getId, ids);
        wrapper.select(SysParam::getParamKey);
        List<SysParam> sysParams = sysParamMapper.selectList(wrapper);
        sysParams.forEach(param -> {
            removeCache(param.getParamKey());
        });
    }

    /**
     * 获取最大排序
     */
    @Override
    public Integer getMaxSort() {
        return sysParamMapper.selectMaxSort();
    }

    /**
     * 获取参数值
     *
     * @param paramKey 参数键
     */
    @Override
    public String getParamValueByKey(String paramKey) {
        if (StrUtils.isBlank(paramKey)) {
            return paramKey;
        }
        String value = redisService.get(SysParamConstant.CACHE_PREFIX + paramKey);
        if (value != null) {
            return value;
        }
        // 从数据库获取
        LambdaQueryWrapper<SysParam> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysParam::getParamKey, paramKey);
        SysParam sysParam = sysParamMapper.selectOne(wrapper);
        value = sysParam == null ? null : sysParam.getParamValue();
        // 存入缓存，有效期为 3 天
        redisService.set(SysParamConstant.CACHE_PREFIX + paramKey, value, 3, TimeUnit.DAYS);
        return value;
    }

    /**
     * 清除缓存
     *
     * @param paramKey 参数键
     */
    @Override
    public void removeCache(String paramKey) {
        redisService.delete(SysParamConstant.CACHE_PREFIX + paramKey);
    }
}
