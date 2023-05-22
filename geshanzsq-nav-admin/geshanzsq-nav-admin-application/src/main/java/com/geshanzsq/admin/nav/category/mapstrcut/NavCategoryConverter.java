package com.geshanzsq.admin.nav.category.mapstruct;

import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import com.geshanzsq.admin.client.nav.vo.NavCategorySiteClientVO;
import com.geshanzsq.admin.nav.category.dto.NavCategoryAddDTO;
import com.geshanzsq.admin.nav.category.dto.NavCategoryUpdateDTO;
import com.geshanzsq.admin.nav.category.po.NavCategory;
import com.geshanzsq.admin.nav.category.vo.NavCategoryTreeVO;
import com.geshanzsq.admin.nav.category.vo.NavCategoryVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 导航分类对象转换
 *
 * @author geshanzsq
 * @date 2022/11/20
 */
@Mapper
public interface NavCategoryConverter {

    NavCategoryConverter INSTANCE = Mappers.getMapper(NavCategoryConverter.class);

    List<NavCategoryVO> convert(List<NavCategory> list);

    List<NavCategoryTreeVO> convertTree(List<NavCategory> list);

    NavCategoryVO convert(NavCategory navCategory);

    NavCategory convert(NavCategoryAddDTO addDTO);

    NavCategory convert(NavCategoryUpdateDTO updateDTO);

    List<NavCategoryClientVO> convertClient(List<NavCategoryTreeVO> list);

    List<NavCategorySiteClientVO> convertSiteClient(List<NavCategoryClientVO> list);

}