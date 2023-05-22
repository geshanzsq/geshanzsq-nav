package com.geshanzsq.admin.system.param.mapstruct;

import com.geshanzsq.admin.system.param.dto.SysParamAddDTO;
import com.geshanzsq.admin.system.param.dto.SysParamUpdateDTO;
import com.geshanzsq.admin.system.param.po.SysParam;
import com.geshanzsq.admin.system.param.vo.SysParamVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * 参数配置对象转换
 *
 * @author geshanzsq
 * @date 2022/8/16
 */
@Mapper
public interface SysParamConverter {

    SysParamConverter INSTANCE = Mappers.getMapper(SysParamConverter.class);

    PageVO<SysParamVO> convert(PageVO<SysParam> pageVO);

    SysParamVO convert(SysParam sysParam);

    SysParam convert(SysParamAddDTO addDTO);

    SysParam convert(SysParamUpdateDTO updateDTO);

}
