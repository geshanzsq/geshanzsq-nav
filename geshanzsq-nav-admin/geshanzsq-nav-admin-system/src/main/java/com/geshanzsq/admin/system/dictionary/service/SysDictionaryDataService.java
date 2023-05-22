package com.geshanzsq.admin.system.dictionary.service;

import com.geshanzsq.admin.system.dictionary.po.SysDictionaryData;
import com.geshanzsq.common.framework.web.service.BaseService;

/**
 * 字典数据
 *
 * @author geshanzsq
 * @date 2022/6/27
 */
public interface SysDictionaryDataService extends BaseService<SysDictionaryData> {

    /**
     * 获取最大排序
     * @param dictionaryId 字典 id
     */
    Integer getMaxSortByDictionaryId(Long dictionaryId);

}
