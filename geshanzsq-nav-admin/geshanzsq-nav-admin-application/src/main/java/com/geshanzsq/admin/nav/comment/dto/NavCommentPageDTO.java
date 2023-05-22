package com.geshanzsq.admin.nav.comment.dto;

import com.geshanzsq.common.framework.mybatis.page.dto.PageDTO;
import com.geshanzsq.common.framework.mybatis.plugin.annotation.Query;
import com.geshanzsq.common.framework.mybatis.plugin.enums.QueryWay;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 评论分页
 *
 * @author geshanzsq
 * @date 2022/11/29
 */
@Data
@ApiModel("评论分页")
public class NavCommentPageDTO extends PageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("评论内容")
    @Query(QueryWay.LIKE)
    private String commentContent;

    @ApiModelProperty("状态（1 待审核，2 通过，3 驳回）")
    private Integer status;

    @ApiModelProperty(value = "用户 id", hidden = true)
    private Long createUserId;

}