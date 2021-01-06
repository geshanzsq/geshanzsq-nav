package com.geshanzsq.nav.domain;

import com.geshanzsq.common.core.domain.BaseEntity;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 导航网站信息对象 nav_site
 * 
 * @author geshanzsq
 * @date 2020-07-11
 */
@Data
public class NavSite extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 网站id */
    private Long siteId;

    /** 菜单id */
    @NotNull(message = "所属菜单不能为空")
    private Long menuId;

    /** 菜单名称 */
    private String menuName;

    /** 网站名称 */
    @NotBlank(message = "网站名称不能为空")
    private String siteName;

    /** 网站图片路径 */
    private String sitePath;

    /** 网站描述 */
    private String siteDescription;

    /** 网站地址 */
    @NotBlank(message = "网站地址不能为空")
    private String siteUrl;

    /** 状态，0 正常，1 删除 */
    private Integer status;

    /** 显示顺序 */
    private Integer orderNum;

    /** 点击量 */
    private Integer clickCount;

    public NavSite() {
    }
}
