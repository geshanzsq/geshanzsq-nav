package com.geshanzsq.admin.system.api.mapstruct;

import com.geshanzsq.admin.system.api.dto.SysApiCategoryAddDTO;
import com.geshanzsq.admin.system.api.dto.SysApiCategoryUpdateDTO;
import com.geshanzsq.admin.system.api.po.SysApiCategory;
import com.geshanzsq.admin.system.api.vo.SysApiCategoryVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 系统接口对象转换
 *
 * @author geshanzsq
 * @date 2022/6/24
 */
@Mapper
public interface SysApiCategoryConverter {

    SysApiCategoryConverter INSTANCE = Mappers.getMapper(SysApiCategoryConverter.class);

    SysApiCategoryVO convert(SysApiCategory sysApiCategory);

    List<SysApiCategoryVO> convertList(List<SysApiCategory> list);

    PageVO<SysApiCategoryVO> convert(PageVO<SysApiCategory> pageVO);

    SysApiCategory convert(SysApiCategoryAddDTO addDTO);

    SysApiCategory convert(SysApiCategoryUpdateDTO updateDTO);

}
