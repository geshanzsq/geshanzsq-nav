package com.geshanzsq.admin.system.dictionary.mapstruct;

import com.geshanzsq.admin.system.dictionary.dto.SysDictionaryAddDTO;
import com.geshanzsq.admin.system.dictionary.dto.SysDictionaryUpdateDTO;
import com.geshanzsq.admin.system.dictionary.po.SysDictionary;
import com.geshanzsq.admin.system.dictionary.vo.SysDictionaryVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 字典对象转换
 *
 * @author geshanzsq
 * @date 2022/6/26
 */
@Mapper
public interface SysDictionaryConverter {

    SysDictionaryConverter INSTANCE = Mappers.getMapper(SysDictionaryConverter.class);


    SysDictionaryVO convert(SysDictionary sysDictionary);

    List<SysDictionaryVO> convertList(List<SysDictionary> list);

    PageVO<SysDictionaryVO> convert(PageVO<SysDictionary> pageVo);

    SysDictionary convert(SysDictionaryAddDTO addDTO);

    SysDictionary convert(SysDictionaryUpdateDTO updateDTO);

}
