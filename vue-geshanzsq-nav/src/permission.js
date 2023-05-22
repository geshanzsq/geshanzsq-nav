import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import router from '@/router'
import store from '@/store'
import { whileList } from '@/config/setting.config'
import { baiduStatisticsUrl } from '@/config/theme.config'

import { isHttp } from '@/utils/validate'
import { useDynamicTitle } from '@/utils/dynamicTitle'

NProgress.configure({ showSpinner: false })

router.beforeEach(async (to, from, next) => {
  NProgress.start()
  useDynamicTitle(to.meta.title)
  const token = store.getters['user/token']
  // 已登录
  if (token) {
    // 如果已登录又访问登录页，直接跳转到首页
    if (to.path === '/login') {
      next(to.query.redirect || '/')
    } else {
      if (store.getters['user/username'].length === 0) {
        try {
          // 判断当前用户是否已拉取完用户信息
          await store.dispatch('user/getUserInfo')
          // 获取字典数据
          await store.dispatch('dictionary/getAllDictionaryInfo')
          // 根据 roles 权限生成可访问的路由表
          await store.dispatch('permission/generateRoutes')
          // 根据roles权限生成可访问的路由表
          const accessRoutes = store.getters['permission/addRoutes']
          accessRoutes.forEach((route) => {
            // 动态添加可访问路由表
            if (!isHttp(route.path)) {
              router.addRoute(route)
            }
          })
          // hack方法 确保addRoutes已完成
          next({ ...to, replace: true })
        } catch (error) {
          console.log(error)
          NProgress.done()
          await store.dispatch('user/logout')
          next(`/login?redirect=${to.fullPath}`)
        }
      } else {
        next()
      }
    }
  } else {
    // 未登录
    if (
      whileList.indexOf(to.path) !== -1 ||
      to.path.indexOf('/search/') !== -1
    ) {
      // 在免登录白名单，直接进入
      next()
    } else {
      // 否则全部重定向到登录页，判断是否为首页，如果是首页，去除 redirect 参数
      if (to.path === '/') {
        next('/login')
      } else {
        next(`/login?redirect=${to.fullPath}`)
      }
    }
  }
  NProgress.done()
})

router.afterEach(() => {
  NProgress.done()
  // 判断百度统计的链接地址是否为空，或者不是生产环境，不需要统计
  if (!baiduStatisticsUrl || process.env.NODE_ENV !== 'production') {
    NProgress.done()
    return
  }

  try {
    setTimeout(() => {
      // 每次执行前，先移除上次插入的代码
      document.getElementById('baidu_tj') &&
        document.getElementById('baidu_tj').remove()
      const hm = document.createElement('script')
      hm.src = baiduStatisticsUrl
      hm.id = 'baidu_tj'
      const s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(hm, s)
    }, 0)
  } catch (e) {
    console.log(e)
  }
  NProgress.done()
})
