import { createRouter, createWebHistory } from 'vue-router'
import Layout from '@/layout'

/**
 * 公共路由
 */
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login')
  },
  {
    path: '/',
    component: () => import('@/views/client/index'),
    hidden: true
  },
  {
    path: '/search/:searchContent',
    component: () => import('@/views/client/search'),
    hidden: true,
    meta: { title: '搜索' }
  },
  {
    path: '/about',
    component: () => import('@/views/client/about'),
    hidden: true,
    meta: { title: '关于本站' }
  },
  {
    path: '/index',
    component: Layout,
    redirect: '/index',
    children: [
      {
        path: '',
        component: () => import('@/views/index'),
        name: 'Index',
        meta: { title: '首页', icon: 'dashboard', affix: true }
      }
    ]
  },
  {
    path: '/user',
    component: Layout,
    hidden: true,
    children: [
      {
        path: 'profile',
        component: () => import('@/views/system/user/profile'),
        name: 'Profile',
        meta: { title: '个人中心', icon: 'user' }
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*',
    component: () => import('@/views/error/404'),
    hidden: true
  },
  {
    path: '/403',
    component: () => import('@/views/error/403'),
    hidden: true
  }
]

/**
 * 动态路由，基于用户权限动态去加载
 */
export const dynamicRoutes = [
  {
    path: '/system/role-auth',
    component: Layout,
    hidden: true,
    permissions: ['system:role:authUser'],
    children: [
      {
        path: 'user/:id',
        component: () => import('@/views/system/role/authUser'),
        name: 'AuthUser',
        meta: { title: '分配用户角色', activeMenu: '/system/role' }
      }
    ]
  },
  {
    path: '/system/api/data/',
    component: Layout,
    hidden: true,
    permissions: ['system:api:page'],
    children: [
      {
        path: ':id',
        component: () => import('@/views/system/api'),
        name: 'APIData',
        meta: { title: 'API 接口数据', activeMenu: '/system/api' }
      }
    ]
  },
  {
    path: '/system/dictionary/data',
    component: Layout,
    hidden: true,
    permissions: ['system:dictionary:data:page'],
    children: [
      {
        path: ':id',
        component: () => import('@/views/system/dictionary/data'),
        name: 'DictionaryData',
        meta: { title: '字典数据', activeMenu: '/system/dictionary' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes: constantRoutes
})

export default router
