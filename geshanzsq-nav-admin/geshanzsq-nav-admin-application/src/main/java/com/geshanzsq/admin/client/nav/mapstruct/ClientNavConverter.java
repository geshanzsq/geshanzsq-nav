package com.geshanzsq.admin.client.nav.mapstruct;

import com.geshanzsq.admin.client.nav.vo.NavCategoryClientVO;
import com.geshanzsq.admin.nav.category.po.NavCategory;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 导航客户端对象转换
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
@Mapper
public interface ClientNavConverter {

    ClientNavConverter INSTANCE = Mappers.getMapper(ClientNavConverter.class);

    List<NavCategoryClientVO> convertCategory(List<NavCategory> list);

}
