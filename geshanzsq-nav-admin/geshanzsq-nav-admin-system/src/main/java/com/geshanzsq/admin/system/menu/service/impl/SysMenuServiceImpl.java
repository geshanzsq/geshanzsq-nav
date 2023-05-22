package com.geshanzsq.admin.system.menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.system.api.mapper.SysApiMenuMapper;
import com.geshanzsq.admin.system.api.po.SysApi;
import com.geshanzsq.admin.system.api.po.SysApiMenu;
import com.geshanzsq.admin.system.api.service.SysApiService;
import com.geshanzsq.admin.system.menu.constant.MenuConstant;
import com.geshanzsq.admin.system.menu.dto.SysMenuAuthApiDTO;
import com.geshanzsq.admin.system.menu.dto.SysMenuListDTO;
import com.geshanzsq.admin.system.menu.enums.MenuShowStatus;
import com.geshanzsq.admin.system.menu.enums.MenuStatus;
import com.geshanzsq.admin.system.menu.enums.MenuType;
import com.geshanzsq.admin.system.menu.mapper.SysMenuMapper;
import com.geshanzsq.admin.system.menu.mapstruct.SysMenuConverter;
import com.geshanzsq.admin.system.menu.po.SysMenu;
import com.geshanzsq.admin.system.menu.service.SysMenuService;
import com.geshanzsq.admin.system.menu.vo.MetaVO;
import com.geshanzsq.admin.system.menu.vo.RouterVO;
import com.geshanzsq.admin.system.menu.vo.SysMenuVO;
import com.geshanzsq.common.core.constant.CommonConstant;
import com.geshanzsq.common.core.enums.CommonStatus;
import com.geshanzsq.common.core.enums.YesNo;
import com.geshanzsq.common.core.exception.ParamException;
import com.geshanzsq.common.core.exception.ServiceException;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import com.geshanzsq.framework.security.domain.LoginUserDetail;
import com.geshanzsq.framework.security.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 系统菜单
 *
 * @author geshanzsq
 * @date 2022/3/26
 */
@Service
public class SysMenuServiceImpl extends BaseServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    @Autowired
    private SysMenuMapper sysMenuMapper;
    @Autowired
    private SysApiService sysApiService;
    @Autowired
    private SysApiMenuMapper sysApiMenuMapper;

    /**
     * 通过角色 ids 获取菜单
     * @param roleIds 角色 ids
     */
    @Override
    public List<SysMenuVO> getMenuByRoleIds(Set<Long> roleIds) {
        if (CollectionUtils.isEmpty(roleIds)) {
            return new ArrayList<>();
        }

        // 只获取菜单和按钮
        List<String> menuTypes = Arrays.asList(MenuType.MENU.code, MenuType.BUTTON.code);
        return sysMenuMapper.getMenuByRoleIds(roleIds, menuTypes, MenuStatus.NORMAL.code);
    }

    /**
     * 获取菜单路由
     * @return
     */
    @Override
    public List<RouterVO> getRouters() {
        LoginUserDetail loginUser = SecurityUtils.getLoginUser();

        // 菜单类型
        List<String> menuTypes = Arrays.asList(MenuType.DIRECTORY.code, MenuType.MENU.code);

        // 1 获取菜单
        List<SysMenuVO> menuVos = new ArrayList<>();
        // 管理员，获取所有菜单
        if (loginUser.isHasSuperAdmin()) {
            LambdaQueryWrapper<SysMenu> menuWrapper = new LambdaQueryWrapper<>();
            menuWrapper.eq(SysMenu::getStatus, CommonStatus.NORMAL.code);
            menuWrapper.in(SysMenu::getMenuType, menuTypes);
            menuWrapper.orderByAsc(SysMenu::getParentId, SysMenu::getSort);
            List<SysMenu> menus = sysMenuMapper.selectList(menuWrapper);
            menuVos = SysMenuConverter.INSTANCE.convertList(menus);
        } else {
            // 根据用户获取菜单
            menuVos = sysMenuMapper.getMenuByUserId(loginUser.getUserId(), CommonStatus.NORMAL.code,
                    CommonStatus.NORMAL.code, YesNo.NO.code, menuTypes);
        }

        if (CollectionUtils.isEmpty(menuVos)) {
            return new ArrayList<>();
        }

        // 2 构造树形结构
        List<SysMenuVO> treeMenus = buildMenuTree(menuVos, 0L);

        // 3 构造路由
        return buildRouters(treeMenus, null);
    }

    /**
     * 获取菜单列表
     */
    @Override
    public List<SysMenuVO> getMenuList(SysMenuListDTO sysMenuListDTO) {
        sysMenuListDTO.setOrderColumn("sort,parentId");
        List<SysMenu> menus = sysMenuMapper.selectList(sysMenuListDTO);
        return SysMenuConverter.INSTANCE.convertList(menus);
    }

    /**
     * 菜单树形
     */
    @Override
    public List<SysMenuVO> getMenuTree() {
        List<SysMenuVO> menuList = getMenuList(new SysMenuListDTO());
        return buildMenuTree(menuList, 0L);
    }

    /**
     * 获取最大排序
     * @param parentId 上级菜单 id
     */
    @Override
    public Integer getMaxSortByParentId(Long parentId) {
        return sysMenuMapper.selectMaxSortByParentId(parentId == null ? 0 : parentId);
    }

    /**
     * 删除
     * @param id 菜单 id
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void remove(Long id) {
        if (id == null) {
            return;
        }
        // 判断是否有下级菜单，如果有，则不能删除
        LambdaQueryWrapper<SysMenu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SysMenu::getParentId, id);
        Long count = sysMenuMapper.selectCount(wrapper);
        if (count > 0) {
            throw new ServiceException(MessageUtils.message("menu.has.child"));
        }

        // 删除菜单数据
        sysMenuMapper.deleteById(id);

        // 删除菜单和接口对应关系
        LambdaQueryWrapper<SysApiMenu> amWrapper = new LambdaQueryWrapper<>();
        amWrapper.eq(SysApiMenu::getMenuId, id);
        sysApiMenuMapper.delete(amWrapper);
    }

    /**
     * 分配 API
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void authApi(SysMenuAuthApiDTO authApiDto) {
        // 判断菜单是否存在
        LambdaQueryWrapper<SysMenu> menuWrapper = new LambdaQueryWrapper<>();
        menuWrapper.eq(SysMenu::getId, authApiDto.getMenuId());
        if (sysMenuMapper.selectCount(menuWrapper) == 0) {
            throw new ParamException(MessageUtils.message("menu.not.exist"));
        }

        // 过滤不存在的 API
        if (!CollectionUtils.isEmpty(authApiDto.getApiIds())) {
            LambdaQueryWrapper<SysApi> apiWrapper = new LambdaQueryWrapper<>();
            apiWrapper.in(SysApi::getId, authApiDto.getApiIds());
            apiWrapper.select(SysApi::getId);
            List<Long> apiIds = sysApiService.list(apiWrapper).stream().map(api -> api.getId()).collect(Collectors.toList());
            authApiDto.setApiIds(apiIds);
        }

        // 分配 API
        sysApiService.authApi(authApiDto.getMenuId(), authApiDto.getApiIds());
    }

    /**
     * 根据父节点的 id 获取所有子节点
     *
     * @param allList 所有数据
     * @param parentId 传入的父节点 id
     * @return String
     */
    public List<SysMenuVO> buildMenuTree(List<SysMenuVO> allList, Long parentId) {
        List<SysMenuVO> returnList = new ArrayList<>();
        for (SysMenuVO menu : allList) {
            // 根据传入的某个父节点 id，遍历该父节点的所有子节点
            if (parentId != null && parentId.equals(menu.getParentId())) {
                // 递归菜单
                recursiveMenu(allList, menu);
                returnList.add(menu);
            }
        }
        return returnList;
    }

    /**
     * 递归菜单列表
     *
     * @param allList
     * @param menu 当前菜单
     */
    private void recursiveMenu(List<SysMenuVO> allList, SysMenuVO menu) {
        // 得到子节点列表
        List<SysMenuVO> childList = getChildList(allList, menu);
        menu.setChildren(childList);
        for (SysMenuVO tChild : childList) {
            if (hasChild(allList, tChild)) {
                recursiveMenu(allList, tChild);
            }
        }
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<SysMenuVO> allList, SysMenuVO menu) {
        return getChildList(allList, menu).size() > 0;
    }

    /**
     * 得到子节点列表
     */
    private List<SysMenuVO> getChildList(List<SysMenuVO> allList, SysMenuVO menu) {
        List<SysMenuVO> childList = new ArrayList<>();
        Iterator<SysMenuVO> it = allList.iterator();
        while (it.hasNext()) {
            SysMenuVO child = it.next();
            if (menu.getId().equals(child.getParentId())) {
                childList.add(child);
            }
        }
        return childList;
    }

    /**
     * 构建前端路由所需要的菜单
     * @param menus 菜单列表
     * @return 路由列表
     */
    private List<RouterVO> buildRouters(List<SysMenuVO> menus, SysMenuVO parentMenu) {
        List<RouterVO> routers = new LinkedList<RouterVO>();
        for (SysMenuVO menu : menus) {
            RouterVO router = new RouterVO();
            router.setHidden(MenuShowStatus.HIDDEN.code.equals(menu.getShowStatus()));
            router.setName(getRouteName(menu, parentMenu));
            router.setPath(getRouterPath(menu));
            router.setComponent(getComponent(menu));
            router.setQuery(menu.getRouterParam());
            router.setMeta(new MetaVO(menu.getMenuName(), menu.getMenuIcon(), YesNo.NO.code.equals(menu.getHasCache()), menu.getRouterUrl()));
            List<SysMenuVO> cMenus = menu.getChildren();
            if (!CollectionUtils.isEmpty(cMenus) && MenuType.DIRECTORY.code.equals(menu.getMenuType())) {
                router.setAlwaysShow(true);
                router.setRedirect("noRedirect");
                router.setChildren(buildRouters(cMenus, menu));
            } else if (isMenuFrame(menu)) {
                router.setMeta(null);
                List<RouterVO> childrenList = new ArrayList<RouterVO>();
                RouterVO children = new RouterVO();
                children.setPath(menu.getRouterUrl());
                children.setComponent(menu.getComponentPath());
                children.setName(StrUtils.capitalize(menu.getRouterUrl()));
                children.setMeta(new MetaVO(menu.getMenuName(), menu.getMenuIcon(), YesNo.NO.code.equals(menu.getHasCache()), menu.getRouterUrl()));
                children.setQuery(menu.getRouterParam());
                childrenList.add(children);
                router.setChildren(childrenList);
            } else if (isRootMenu(menu.getParentId()) && isInnerLink(menu)) {
                router.setMeta(new MetaVO(menu.getMenuName(), menu.getMenuIcon()));
                router.setPath("/");
                List<RouterVO> childrenList = new ArrayList<RouterVO>();
                RouterVO children = new RouterVO();
                String routerPath = innerLinkReplaceEach(menu.getRouterUrl());
                children.setPath(routerPath);
                children.setComponent(MenuConstant.INNER_LINK);
                children.setName(StrUtils.capitalize(routerPath));
                children.setMeta(new MetaVO(menu.getMenuName(), menu.getMenuIcon(), menu.getRouterUrl()));
                childrenList.add(children);
                router.setChildren(childrenList);
            }
            routers.add(router);
        }
        return routers;
    }


    /**
     * 获取路由名称
     * @param menu 菜单信息
     * @return 路由名称
     */
    public String getRouteName(SysMenuVO menu, SysMenuVO parentMenu) {
        String routerName = (parentMenu != null ? StrUtils.capitalize(parentMenu.getRouterUrl()) : "")
                + StrUtils.capitalize(menu.getRouterUrl());
        // 非外链并且是一级目录（类型为目录）
        if (isMenuFrame(menu)) {
            routerName = StrUtils.EMPTY;
        }
        return routerName;
    }

    /**
     * 是否为菜单内部跳转
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean isMenuFrame(SysMenuVO menu) {
        return isRootMenu(menu.getParentId()) && MenuType.MENU.code.equals(menu.getMenuType())
                && menu.getHasFrame().equals(YesNo.NO.code);
    }

    /**
     * 获取路由地址
     * @param menu 菜单信息
     * @return 路由地址
     */
    public String getRouterPath(SysMenuVO menu) {
        String routerPath = menu.getRouterUrl();
        // 内链打开外网方式
        if (!isRootMenu(menu.getParentId()) && isInnerLink(menu)) {
            routerPath = innerLinkReplaceEach(routerPath);
        }
        // 非外链并且是一级目录（类型为目录）
        if (isRootMenu(menu.getParentId()) && MenuType.DIRECTORY.code.equals(menu.getMenuType())
                && YesNo.NO.code.equals(menu.getHasFrame())) {
            routerPath = "/" + menu.getRouterUrl();
        } else if (isMenuFrame(menu)) {
            // 非外链并且是一级目录（类型为菜单）
            routerPath = "/";
        }
        return routerPath;
    }

    /**
     * 是否为内链组件
     * @param menu 菜单信息
     */
    public boolean isInnerLink(SysMenuVO menu) {
        return YesNo.NO.code.equals(menu.getHasFrame()) && StrUtils.isHttp(menu.getRouterUrl());
    }

    /**
     * 内链域名特殊字符替换
     */
    public String innerLinkReplaceEach(String path) {
        return StrUtils.replaceEach(path, new String[] { CommonConstant.HTTP, CommonConstant.HTTPS },
                new String[] { "", "" });
    }

    /**
     * 获取组件信息
     *
     * @param menu 菜单信息
     * @return 组件信息
     */
    public String getComponent(SysMenuVO menu) {
        String component = MenuConstant.LAYOUT;
        if (StrUtils.isNotBlank(menu.getComponentPath()) && !isMenuFrame(menu)) {
            component = menu.getComponentPath();
        } else if (StrUtils.isBlank(menu.getComponentPath()) && !isRootMenu(menu.getParentId()) && isInnerLink(menu)) {
            component = MenuConstant.INNER_LINK;
        } else if (StrUtils.isBlank(menu.getComponentPath()) && isParentView(menu)) {
            component = MenuConstant.PARENT_VIEW;
        }
        return component;
    }

    /**
     * 是否为parent_view组件
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean isParentView(SysMenuVO menu) {
        return !isRootMenu(menu.getParentId()) && MenuType.DIRECTORY.code.equals(menu.getMenuType());
    }

    /**
     * 是否为根菜单
     * @param parentId 上级菜单 id
     * @return
     */
    private boolean isRootMenu(Long parentId) {
        return parentId == null || parentId == 0;
    }

}
