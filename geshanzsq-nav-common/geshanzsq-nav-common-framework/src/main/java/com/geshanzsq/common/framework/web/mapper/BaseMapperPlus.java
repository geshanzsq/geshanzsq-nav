package com.geshanzsq.common.framework.web.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ReflectionKit;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.mybatis.plugin.query.QueryWrapperPlus;
import com.geshanzsq.common.framework.mybatis.util.MybatisUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 在 MyBatis Plus 的 BaseMapper 的基础上拓展，提供更多功能
 *
 * @author geshanzsq
 * @date 2022/6/26
 */
public interface BaseMapperPlus<T> extends BaseMapper<T> {

    /**
     * 查询分页
     */
    default PageVO<T> selectPage(PageDTO pageDTO, @Param("ew") Wrapper<T> queryWrapper) {
        // MyBatis Plus 分页查询
        IPage<T> myBatisPage = MybatisUtils.buildPage(pageDTO);
        selectPage(myBatisPage, queryWrapper);
        // 转换返回值
        return new PageVO<>(myBatisPage.getRecords(), myBatisPage.getTotal());
    }

    /**
     * 查询分页
     *
     * @param d             实体类参数对接
     * @param selectColumns 查询返回的列
     */
    default <D> PageVO<T> selectPage(D d, SFunction<T, ?>... selectColumns) {
        // 构造分页，不能强制转 pageDTO，否则如果没有继承的话，会报错
        PageDTO pageDTO = d instanceof PageDTO ? (PageDTO) d : null;
        IPage<T> myBatisPage = MybatisUtils.buildPage(pageDTO);
        // 查询数据
        selectPage(myBatisPage, buildQueryWrapper(d, selectColumns));
        // 转换返回值
        return new PageVO<>(myBatisPage.getRecords(), myBatisPage.getTotal());
    }

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param selectColumns 查询返回的列
     */
    default <D> List<T> selectList(D d, SFunction<T, ?>... selectColumns) {
        return selectList(buildQueryWrapper(d, selectColumns));
    }

    /**
     * 查询单条
     *
     * @param d 实体类参数对接
     */
    default <D> T selectOne(D d) {
        return selectOne(buildQueryWrapper(d));
    }

    /**
     * 查询总记录数
     *
     * @param d 实体类参数对接
     */
    default <D> Long selectCount(D d) {
        return selectCount(buildQueryWrapper(d));
    }

    /**
     * 构建 Wrapper 查询条件
     *
     * @param d             DTO 实体参数对象
     * @param selectColumns 查询返回的列
     * @return 查询构造器
     */
    default <D> QueryWrapperPlus<T> buildQueryWrapper(D d, SFunction<T, ?>... selectColumns) {
        Class<T> entityClass = (Class<T>) ReflectionKit.getSuperClassGenericType(getClass(), BaseMapperPlus.class, 0);
        return new QueryWrapperPlus<T>().buildQueryWrapper(entityClass, d, selectColumns);
    }

}
