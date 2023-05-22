package com.geshanzsq.admin.system.menu.mapstruct;

import com.geshanzsq.admin.system.menu.dto.SysMenuAddDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuUpdateDTO;
import com.geshanzsq.admin.system.menu.po.SysMenu;
import com.geshanzsq.admin.system.menu.vo.SysMenuVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 菜单对象转换
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Mapper
public interface SysMenuConverter {

    SysMenuConverter INSTANCE = Mappers.getMapper(SysMenuConverter.class);

    SysMenuVO convert(SysMenu menus);

    List<SysMenuVO> convertList(List<SysMenu> menus);

    SysMenu convert(SysMenuAddDTO addDto);

    SysMenu convert(SysMenuUpdateDTO updateDto);

}
