package com.geshanzsq.admin.client.nav.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 导航客户端
 *
 * @author geshanzsq
 * @date 2023/1/7
 */
@Data
@Builder
@ApiModel("导航客户端")
@AllArgsConstructor
@NoArgsConstructor
public class NavClientListVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类")
    private List<NavCategoryClientVO> categories;

    @ApiModelProperty("网站")
    private List<NavCategorySiteClientVO> sites;

}
