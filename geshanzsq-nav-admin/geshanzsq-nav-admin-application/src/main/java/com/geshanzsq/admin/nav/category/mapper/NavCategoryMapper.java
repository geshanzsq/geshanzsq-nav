package com.geshanzsq.admin.nav.category.mapper;

import com.geshanzsq.admin.nav.category.po.NavCategory;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * 导航分类
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Mapper
public interface NavCategoryMapper extends BaseMapperPlus<NavCategory> {

    /**
     * 获取最大排序
     * @param parentId 上级分类 id
     */
    Integer selectMaxSortByParentId(Long parentId);

}