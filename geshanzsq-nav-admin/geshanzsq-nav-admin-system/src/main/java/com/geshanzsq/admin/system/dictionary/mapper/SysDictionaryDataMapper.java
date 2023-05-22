package com.geshanzsq.admin.system.dictionary.mapper;

import com.geshanzsq.admin.system.dictionary.po.SysDictionaryData;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * 字典数据
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
@Mapper
public interface SysDictionaryDataMapper extends BaseMapperPlus<SysDictionaryData> {

    /**
     * 获取最大排序
     * @param dictionaryId 字典 id
     */
    Integer selectMaxSortByDictionaryId(Long dictionaryId);

}
