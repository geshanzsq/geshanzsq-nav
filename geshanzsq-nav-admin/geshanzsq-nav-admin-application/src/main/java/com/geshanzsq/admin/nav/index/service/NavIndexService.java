package com.geshanzsq.admin.nav.index.service;

import com.geshanzsq.admin.nav.index.vo.NavIndexStatisticsVO;

/**
 * 后台首页
 *
 * @author geshanzsq
 * @date 2023/5/2
 */
public interface NavIndexService {

    /**
     * 获取统计数
     */
    NavIndexStatisticsVO getStatistics();
}
