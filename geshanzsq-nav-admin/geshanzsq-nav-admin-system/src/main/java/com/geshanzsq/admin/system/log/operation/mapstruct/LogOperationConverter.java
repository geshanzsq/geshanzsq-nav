package com.geshanzsq.admin.system.log.operation.mapstruct;

import com.geshanzsq.admin.system.log.operation.po.LogOperation;
import com.geshanzsq.admin.system.log.operation.vo.LogOperationVo;
import com.geshanzsq.common.log.dto.LogDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * 操作日志转换
 *
 * @author geshanzsq
 * @date 2022/7/9
 */
@Mapper
public interface LogOperationConverter {

    LogOperationConverter INSTANCE = Mappers.getMapper(LogOperationConverter.class);

    LogOperationVo convert(LogOperation logOperation);

    LogOperation convert(LogDTO logDto);

}
