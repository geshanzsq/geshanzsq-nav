package com.geshanzsq.admin.client.nav.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 提交评论
 *
 * @author geshanzsq
 * @date 2023/4/15
 */
@Data
@ApiModel("评论")
public class ClientNavCommentAddDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("上级 id")
    private Long parentId;

    @ApiModelProperty(value = "评论内容", required = true)
    @NotBlank(message = "评论内容不能为空")
    private String commentContent;

    @ApiModelProperty("昵称")
    private String nickName;

    @ApiModelProperty("邮箱")
    @Email(message = "邮箱不正确")
    private String email;
}
