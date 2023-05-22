package com.geshanzsq.admin.system.user.mapstruct;

import com.geshanzsq.admin.system.user.dto.SysUserAddDTO;
import com.geshanzsq.admin.system.user.dto.SysUserResetPasswordDTO;
import com.geshanzsq.admin.system.user.dto.SysUserUpdateDTO;
import com.geshanzsq.admin.system.user.dto.SysUserUpdateInfoDTO;
import com.geshanzsq.admin.system.user.po.SysUser;
import com.geshanzsq.admin.system.user.vo.SysUserVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import com.geshanzsq.framework.security.domain.LoginUserDetail;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 用户对象转换
 *
 * @author geshanzsq
 * @date 2022/3/27
 */
@Mapper
public interface SysUserConverter {

    SysUserConverter INSTANCE = Mappers.getMapper(SysUserConverter.class);

    @Mapping(source = "id", target = "userId")
    LoginUserDetail convertDetail(SysUser sysUser);

    SysUserVO convert(SysUser sysUser);

    List<SysUserVO> convertList(List<SysUser> list);

    PageVO<SysUserVO> convert(PageVO<SysUser> pageVo);

    SysUser convert(SysUserAddDTO addDTO);

    SysUser convert(SysUserUpdateDTO updateDTO);

    SysUser convert(SysUserUpdateInfoDTO updateInfoDTO);

    SysUser convert(SysUserResetPasswordDTO sysUserResetPasswordDTO);

}
