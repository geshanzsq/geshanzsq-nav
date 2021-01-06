package com.geshanzsq.nav.domain.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author geshanzsq
 * @date 2020/7/28
 */
@Data
public class FrontMenuVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 导航id
     */
    private Long menuId;

    /**
     * 导航菜单
     */
    private String menuName;

    /**
     * 导航图标
     */
    private String menuIcon;

    /**
     * 父级id
     */
    private Long parentId;

    /**
     * 子菜单
     */
    List<FrontMenuVO> children = new ArrayList<>();

    /**
     * 站点列表
     */
    List<FrontSiteVO> siteList;

    public FrontMenuVO() {
    }
}
