import auth from '@/plugins/auth'
import router, { constantRoutes, dynamicRoutes } from '@/router'
import { getRouters } from '@/api/auth/user'
import Layout from '@/layout/index'
import ParentView from '@/components/ParentView'
import InnerLink from '@/layout/components/InnerLink'

const getters = {
  routes: (state) => state.routes,
  addRoutes: (state) => state.addRoutes,
  defaultRoutes: (state) => state.defaultRoutes,
  topbarRouters: (state) => state.topbarRouters,
  sidebarRouters: (state) => state.sidebarRouters
}

const state = {
  routes: [],
  addRoutes: [],
  defaultRoutes: [],
  topbarRouters: [],
  sidebarRouters: []
}

const mutations = {
  setRouters: (state, routes) => {
    state.addRoutes = routes
    state.routes = constantRoutes.concat(routes)
  },
  setDefaultRouters: (state, routes) => {
    state.defaultRoutes = constantRoutes.concat(routes)
  },
  setTopbarRouters: (state, routes) => {
    state.topbarRouters = routes
  },
  setSidebarRouters: (state, routes) => {
    state.sidebarRouters = routes
  }
}

const actions = {
  // 生成路由
  async generateRoutes({ commit, state }) {
    // 向后端请求路由数据
    const { data } = await getRouters()
    const sdata = JSON.parse(JSON.stringify(data))
    const rdata = JSON.parse(JSON.stringify(data))
    const defaultData = JSON.parse(JSON.stringify(data))
    const sidebarRoutes = filterAsyncRouter(sdata)
    const rewriteRoutes = filterAsyncRouter(rdata, false, true)
    const defaultRoutes = filterAsyncRouter(defaultData)
    // 动态路由
    const asyncRoutes = filterDynamicRoutes(dynamicRoutes)
    asyncRoutes.forEach((route) => {
      router.addRoute(route)
    })
    commit('setRouters', rewriteRoutes)
    commit('setSidebarRouters', constantRoutes.concat(sidebarRoutes))
    commit('setDefaultRouters', sidebarRoutes)
    commit('setTopbarRouters', defaultRoutes)
  }
}

// 遍历后台传来的路由字符串，转换为组件对象
function filterAsyncRouter(asyncRouterMap, lastRouter = false, type = false) {
  return asyncRouterMap.filter((route) => {
    if (type && route.children) {
      route.children = filterChildren(route.children)
    }
    if (route.component) {
      // Layout ParentView 组件特殊处理
      if (route.component === 'Layout') {
        route.component = Layout
      } else if (route.component === 'ParentView') {
        route.component = ParentView
      } else if (route.component === 'InnerLink') {
        route.component = InnerLink
      } else {
        route.component = loadView(route.component)
      }
    }
    if (route.children != null && route.children && route.children.length) {
      route.children = filterAsyncRouter(route.children, route, type)
    } else {
      delete route.children
      delete route.redirect
    }
    return true
  })
}

function filterChildren(childrenMap, lastRouter = false) {
  let children = []
  childrenMap.forEach((el, index) => {
    if (el.children && el.children.length) {
      if (el.component === 'ParentView' && !lastRouter) {
        el.children.forEach((c) => {
          c.path = el.path + '/' + c.path
          if (c.children && c.children.length) {
            children = children.concat(filterChildren(c.children, c))
            return
          }
          children.push(c)
        })
        return
      }
    }
    if (lastRouter) {
      el.path = lastRouter.path + '/' + el.path
    }
    children = children.concat(el)
  })
  return children
}

/**
 * 动态路由遍历，验证是否具备权限
 */
export function filterDynamicRoutes(routes) {
  const res = []
  routes.forEach((route) => {
    if (route.permissions) {
      if (auth.hasPermiOr(route.permissions)) {
        res.push(route)
      }
    } else if (route.roles) {
      if (auth.hasRoleOr(route.roles)) {
        res.push(route)
      }
    }
  })
  return res
}

// 路由懒加载
export const loadView = (view) => {
  // return (resolve) => require([`@/views/${view}`], resolve)
  return () => require.ensure([], (require) => require(`@/views/${view}`))
}

export default { namespaced: true, state, getters, mutations, actions }
