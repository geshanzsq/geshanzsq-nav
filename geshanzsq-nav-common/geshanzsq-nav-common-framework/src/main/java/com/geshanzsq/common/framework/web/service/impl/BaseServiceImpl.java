package com.geshanzsq.common.framework.web.service.impl;

import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.mapper.BaseMapperPlus;
import com.geshanzsq.common.framework.web.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 在 MyBatis Plus 的 ServiceImpl 的基础上拓展，后续提供更多功能
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
public class BaseServiceImpl<M extends BaseMapperPlus<T>, T> extends ServiceImpl<M, T> implements BaseService<T> {

    @Autowired
    private M baseMapper;

    /**
     * 查询分页
     *
     * @param d             实体类参数对接
     * @param selectColumns 查询返回的列
     */
    @Override
    public <D> PageVO<T> page(D d, SFunction<T, ?>... selectColumns) {
        return baseMapper.selectPage(d, selectColumns);
    }


    /**
     * 查询分页
     *
     * @param pageNum       页码
     * @param pageSize      每页条数
     * @param selectColumns 查询返回的列
     */
    @Override
    public PageVO<T> page(Long pageNum, Long pageSize, SFunction<T, ?>... selectColumns) {
        return baseMapper.selectPage(pageNum, pageSize, selectColumns);
    }

    /**
     * 查询分页
     *
     * @param d          实体类参数对接
     * @param ascColumns 升序排序列
     */
    @Override
    public <D extends PageDTO> PageVO<T> pageAsc(D d, SFunction<T, ?>... ascColumns) {
        return baseMapper.selectPageAsc(d, ascColumns);
    }

    /**
     * 查询分页
     *
     * @param pageNum    页码
     * @param pageSize   每页条数
     * @param ascColumns 升序排序列
     */
    @Override
    public PageVO<T> pageAsc(Long pageNum, Long pageSize, SFunction<T, ?>... ascColumns) {
        return baseMapper.selectPageAsc(pageNum, pageSize, ascColumns);
    }

    /**
     * 查询分页
     *
     * @param d           实体类参数对接
     * @param descColumns 降序排序列
     */
    @Override
    public <D extends PageDTO> PageVO<T> pageDesc(D d, SFunction<T, ?>... descColumns) {
        return baseMapper.selectPageDesc(d, descColumns);
    }

    /**
     * 查询分页
     *
     * @param pageNum     页码
     * @param pageSize    每页条数
     * @param descColumns 降序排序列
     */
    @Override
    public PageVO<T> pageDesc(Long pageNum, Long pageSize, SFunction<T, ?>... descColumns) {
        return baseMapper.selectPageDesc(pageNum, pageSize, descColumns);
    }
}
