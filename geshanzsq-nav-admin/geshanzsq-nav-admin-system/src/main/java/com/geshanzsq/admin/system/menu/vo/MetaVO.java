package com.geshanzsq.admin.system.menu.vo;

import com.geshanzsq.common.core.util.string.StrUtils;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 路由显示信息
 *
 * @author geshanzsq
 * @date 2022/6/12
 */
@Data
@ApiModel("路由显示信息")
public class MetaVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("设置该路由在侧边栏和面包屑中展示的名字")
    private String title;

    @ApiModelProperty("设置该路由的图标，对应路径src/assets/icons/svg")
    private String icon;

    @ApiModelProperty("设置为true，则不会被 <keep-alive>缓存")
    private boolean noCache;

    @ApiModelProperty("内链地址（http(s)://开头）")
    private String link;

    public MetaVO() {
    }

    public MetaVO(String title, String icon) {
        this.title = title;
        this.icon = icon;
    }

    public MetaVO(String title, String icon, boolean noCache) {
        this.title = title;
        this.icon = icon;
        this.noCache = noCache;
    }

    public MetaVO(String title, String icon, String link) {
        this.title = title;
        this.icon = icon;
        this.link = link;
    }

    public MetaVO(String title, String icon, boolean noCache, String link) {
        this.title = title;
        this.icon = icon;
        this.noCache = noCache;
        if (StrUtils.isHttp(link)) {
            this.link = link;
        }
    }

}
