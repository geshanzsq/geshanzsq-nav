package com.geshanzsq.common.framework.web.service;

import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.service.IService;
import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.mybatis.plugin.query.QueryWrapperPlus;

import java.util.Arrays;
import java.util.List;

/**
 * 在 MyBatis Plus 的 IService 的基础上拓展，提供更多功能
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
public interface BaseService<T> extends IService<T> {

    /**
     * 查询分页
     *
     * @param d             实体类参数对接
     * @param selectColumns 查询返回的列
     */
    <D> PageVO<T> page(D d, SFunction<T, ?>... selectColumns);

    /**
     * 查询分页
     *
     * @param pageNum  页码
     * @param pageSize 每页条数
     * @param selectColumns 查询返回的列
     */
    PageVO<T> page(Long pageNum, Long pageSize, SFunction<T, ?>... selectColumns);

    /**
     * 查询分页
     *
     * @param d             实体类参数对接
     * @param ascColumns 升序排序列
     */
    <D extends PageDTO> PageVO<T> pageAsc(D d, SFunction<T, ?>... ascColumns);

    /**
     * 查询分页
     *
     * @param pageNum  页码
     * @param pageSize 每页条数
     * @param ascColumns 升序排序列
     */
    PageVO<T> pageAsc(Long pageNum, Long pageSize, SFunction<T, ?>... ascColumns);

    /**
     * 查询分页
     *
     * @param d             实体类参数对接
     * @param descColumns 降序排序列
     */
    <D extends PageDTO> PageVO<T> pageDesc(D d, SFunction<T, ?>... descColumns);

    /**
     * 查询分页
     *
     * @param pageNum  页码
     * @param pageSize 每页条数
     * @param descColumns 降序排序列
     */
    PageVO<T> pageDesc(Long pageNum, Long pageSize, SFunction<T, ?>... descColumns);

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param selectColumns 查询返回的列
     */
    default <D> List<T> list(D d, SFunction<T, ?>... selectColumns) {
        return list(buildQueryWrapper(d, selectColumns));
    }

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param ascColumns 升序排序列
     * @param selectColumns 查询返回的列
     */
    default <D> List<T> listAsc(D d, List<SFunction<T, ?>> ascColumns, SFunction<T, ?>... selectColumns) {
        QueryWrapperPlus<T> queryWrapper = buildQueryWrapper(d, selectColumns);
        queryWrapper.lambda().orderByAsc(ascColumns);
        return list(queryWrapper);
    }

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param ascColumns 升序排序列
     */
    default <D> List<T> listAsc(D d, SFunction<T, ?>... ascColumns) {
        QueryWrapperPlus<T> queryWrapper = buildQueryWrapper(d);
        if (ascColumns != null) {
            queryWrapper.lambda().orderByAsc(Arrays.asList(ascColumns));
        }
        return list(queryWrapper);
    }

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param descColumns 降序序排序列
     * @param selectColumns 查询返回的列
     */
    default <D> List<T> listDesc(D d, List<SFunction<T, ?>> descColumns, SFunction<T, ?>... selectColumns) {
        QueryWrapperPlus<T> queryWrapper = buildQueryWrapper(d, selectColumns);
        queryWrapper.lambda().orderByDesc(descColumns);
        return list(queryWrapper);
    }

    /**
     * 查询列表
     *
     * @param d             实体类参数对接
     * @param descColumns 降序序排序列
     */
    default <D> List<T> listDesc(D d, SFunction<T, ?>... descColumns) {
        QueryWrapperPlus<T> queryWrapper = buildQueryWrapper(d);
        if (descColumns != null) {
            queryWrapper.lambda().orderByDesc(Arrays.asList(descColumns));
        }
        return list(queryWrapper);
    }

    /**
     * 查询单条
     *
     * @param d 实体类参数对接
     */
    default <D> T getOne(D d) {
        return getOne(buildQueryWrapper(d));
    }

    /**
     * 查询单条
     *
     * @param d       实体类参数对接
     * @param throwEx 有多个结果是否抛出异常
     */
    default <D> T getOne(D d, boolean throwEx) {
        return getOne(buildQueryWrapper( d), throwEx);
    }

    /**
     * 查询总记录数
     *
     * @param d 实体类参数对接
     */
    default <D> Long count(D d) {
        return count(buildQueryWrapper(d));
    }

    /**
     * 构建 Wrapper 查询条件
     *
     * @param d             DTO 实体参数对象
     * @param selectColumns 查询返回的列
     * @return 查询构造器
     */
    default <D> QueryWrapperPlus<T> buildQueryWrapper(D d, SFunction<T, ?>... selectColumns) {
        return new QueryWrapperPlus<T>().buildQueryWrapper(getEntityClass(), d, selectColumns);
    }

}
