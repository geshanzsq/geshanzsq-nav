package com.geshanzsq.admin.nav.comment.vo;

import com.geshanzsq.common.core.web.vo.BaseVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 评论
 *
 * @author geshanzsq
 * @date 2022/11/29
 */
@Data
@ApiModel("评论")
public class NavCommentVO extends BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("评论 id")
    private Long id;

    @ApiModelProperty("上级 id")
    private Long parentId;

    @ApiModelProperty("是否置顶（1 是，2 否）")
    private Integer hasSticky;

    @ApiModelProperty("评论内容")
    private String commentContent;

    @ApiModelProperty("昵称")
    private String nickName;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("备注")
    private String remark;

    @ApiModelProperty("状态（1 待审核，2 通过，3 驳回）")
    private Integer status;

    @ApiModelProperty("用户名")
    private String username;

}