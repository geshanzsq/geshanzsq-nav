package com.geshanzsq.admin.nav.comment.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.io.Serializable;
import java.util.List;

/**
 * 评论驳回
 *
 * @author geshanzsq
 * @date 2022/11/30
 */
@Data
@ApiModel("评论驳回")
public class NavCommentRejectDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("评论 ids")
    @NotEmpty(message = "评论 ids 不能为空")
    private List<Long> ids;

    @ApiModelProperty("备注(驳回原因)")
    private String remark;

}
