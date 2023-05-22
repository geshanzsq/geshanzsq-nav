package com.geshanzsq.admin.system.menu.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 路由配置信息
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Data
@ApiModel("路由配置信息")
public class RouterVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("路由名字")
    private String name;

    @ApiModelProperty("路由地址")
    private String path;

    @ApiModelProperty("是否隐藏路由，当设置 true 的时候该路由不会再侧边栏出现")
    private boolean hidden;

    @ApiModelProperty("重定向地址，当设置 noRedirect 的时候该路由在面包屑导航中不可被点击")
    private String redirect;

    @ApiModelProperty("组件地址")
    private String component;


    @ApiModelProperty("路由参数：如 {\"id\": 1, \"name\": \"geshanzsq\"}")
    private String query;

    @ApiModelProperty("当你一个路由下面的 children 声明的路由大于 1 个时，自动会变成嵌套的模式--如组件页面")
    private Boolean alwaysShow;

    @ApiModelProperty("其他元素")
    private MetaVO meta;

    @ApiModelProperty("子路由")
    private List<RouterVO> children;

}
