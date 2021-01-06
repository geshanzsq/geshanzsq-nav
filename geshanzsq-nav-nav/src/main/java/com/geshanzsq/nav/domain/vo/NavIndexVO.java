package com.geshanzsq.nav.domain.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 登录后的首页展示
 * @author geshanzsq
 * @date 2020/8/9
 */
@Data
public class NavIndexVO implements Serializable {

    private static final long serialVersionUID = 1L;


    /**
     * 菜单数
     */
    private Integer menuCount;

    /**
     * 网站数
     */
    private Integer siteCount;

    public NavIndexVO() {
    }

    public NavIndexVO( Integer menuCount, Integer siteCount) {
        this.menuCount = menuCount;
        this.siteCount = siteCount;
    }
}
