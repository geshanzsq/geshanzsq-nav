package com.geshanzsq.admin.nav.comment.mapstruct;

import com.geshanzsq.admin.client.nav.dto.ClientNavCommentAddDTO;
import com.geshanzsq.admin.client.nav.vo.ClientNavCommentTreeVO;
import com.geshanzsq.admin.nav.comment.po.NavComment;
import com.geshanzsq.admin.nav.comment.vo.NavCommentVO;
import com.geshanzsq.common.framework.mybatis.page.vo.PageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 评论对象转换
 *
 * @author geshanzsq
 * @date 2022/11/29
 */
@Mapper
public interface NavCommentConverter {

    NavCommentConverter INSTANCE = Mappers.getMapper(NavCommentConverter.class);

    PageVO<NavCommentVO> convert(PageVO<NavComment> pageVO);

    NavCommentVO convert(NavComment navComment);

    List<ClientNavCommentTreeVO> convertClient(List<NavComment> list);

    NavComment convert(ClientNavCommentAddDTO addDTO);

}