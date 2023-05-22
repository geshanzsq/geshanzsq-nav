package com.geshanzsq.admin.system.log.operation.service.impl;

import com.geshanzsq.admin.system.log.operation.dto.LogOperationPageDTO;
import com.geshanzsq.admin.system.log.operation.mapper.LogOperationMapper;
import com.geshanzsq.admin.system.log.operation.mapstruct.LogOperationConverter;
import com.geshanzsq.admin.system.log.operation.po.LogOperation;
import com.geshanzsq.admin.system.log.operation.service.LogOperationService;
import com.geshanzsq.admin.system.log.operation.vo.LogOperationVo;
import com.geshanzsq.admin.system.user.service.SysUserService;
import com.geshanzsq.admin.system.user.vo.SysUserVO;
import com.geshanzsq.common.framework.mybatis.page.util.PageUtils;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Arrays;
import java.util.List;

/**
 * 操作日志
 *
 * @author geshanzsq
 * @date 2022/7/5
 */
@Service
public class LogOperationServiceImpl extends BaseServiceImpl<LogOperationMapper, LogOperation> implements LogOperationService {

    @Autowired
    private LogOperationMapper logOperationMapper;
    @Autowired
    private SysUserService sysUserService;

    /**
     * 分页列表
     */
    @Override
    public PageVO<LogOperationVo> pageList(LogOperationPageDTO pageDTO) {
        PageUtils.startPage(pageDTO);
        List<LogOperationVo> list = logOperationMapper.pageList(pageDTO);
        PageVO<LogOperationVo> pageVO = PageUtils.getPage(list);
        return pageVO;
    }

    /**
     * 获取详情
     */
    @Override
    public LogOperationVo getLogOperationById(Long id) {
        LogOperation logOperation = logOperationMapper.selectById(id);
        if (logOperation == null) {
            return null;
        }
        LogOperationVo logOperationVo = LogOperationConverter.INSTANCE.convert(logOperation);
        // 获取操作人信息
        List<SysUserVO> userList = sysUserService.getUsernameAndNickNameByUserIds(Arrays.asList(logOperationVo.getUserId()));
        if (!CollectionUtils.isEmpty(userList)) {
            SysUserVO sysUserVo = userList.get(0);
            logOperationVo.setUsername(sysUserVo.getUsername());
            logOperationVo.setNickName(sysUserVo.getNickName());
        }
        return logOperationVo;
    }
}
