package com.geshanzsq.nav.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Treeselect树结构实体类
 * 
 * @author geshanzsq
 */
@Data
public class TreeSelectNav implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 节点ID */
    private Long id;

    /** 节点名称 */
    private String label;

    /** 子节点 */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TreeSelectNav> children;

    public TreeSelectNav() {
    }

    public TreeSelectNav(NavMenu navMenu) {
        this.id = navMenu.getMenuId();
        this.label = navMenu.getMenuName();
        this.children = navMenu.getChildren().stream().map(TreeSelectNav::new).collect(Collectors.toList());
    }

}
