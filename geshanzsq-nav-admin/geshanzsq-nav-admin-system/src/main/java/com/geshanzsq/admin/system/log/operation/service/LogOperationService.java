package com.geshanzsq.admin.system.log.operation.service;

import com.geshanzsq.admin.system.log.operation.dto.LogOperationPageDTO;
import com.geshanzsq.admin.system.log.operation.po.LogOperation;
import com.geshanzsq.admin.system.log.operation.vo.LogOperationVo;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.service.BaseService;

/**
 * 操作日志
 *
 * @author geshanzsq
 * @date 2022/7/5
 */
public interface LogOperationService extends BaseService<LogOperation> {

    /**
     * 分页列表
     */
    PageVO<LogOperationVo> pageList(LogOperationPageDTO pageDTO);

    /**
     * 获取详情
     */
    LogOperationVo getLogOperationById(Long id);
}
