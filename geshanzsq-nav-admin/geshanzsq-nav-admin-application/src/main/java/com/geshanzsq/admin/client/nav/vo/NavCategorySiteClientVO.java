package com.geshanzsq.admin.client.nav.vo;

import com.geshanzsq.admin.nav.site.vo.NavSiteClientVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 导航分类网站客户端
 *
 * @author geshanzsq
 * @date 2023/1/8
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("导航分类网站客户端")
public class NavCategorySiteClientVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分类 id")
    private Long id;

    @ApiModelProperty("分类名称")
    private String categoryName;

    @ApiModelProperty("网站")
    private List<NavSiteClientVO> sites;

}
