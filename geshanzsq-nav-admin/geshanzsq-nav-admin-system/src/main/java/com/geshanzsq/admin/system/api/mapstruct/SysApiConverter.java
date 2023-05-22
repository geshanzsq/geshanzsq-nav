package com.geshanzsq.admin.system.api.mapstruct;

import com.geshanzsq.admin.system.api.dto.SysApiAddDTO;
import com.geshanzsq.admin.system.api.dto.SysApiUpdateDTO;
import com.geshanzsq.admin.system.api.po.SysApi;
import com.geshanzsq.admin.system.api.vo.SysApiVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.framework.security.domain.ApiPermission;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 接口对象转换
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Mapper
public interface SysApiConverter {

    SysApiConverter INSTANCE = Mappers.getMapper(SysApiConverter.class);

    List<ApiPermission> convertList(List<SysApiVO> list);

    PageVO<SysApiVO> convert(PageVO<SysApi> pageVo);

    SysApiVO convert(SysApi sysApi);

    SysApi convert(SysApiAddDTO addDTO);

    SysApi convert(SysApiUpdateDTO updateDTO);
}
