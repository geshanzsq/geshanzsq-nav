import axios from 'axios'
import { ElMessage, ElMessageBox, ElNotification } from 'element-plus'
import qs from 'qs'
import store from '@/store'

import {
  contentType,
  requestTimeout,
  statusName,
  messageName,
  tokenConfig
} from '@/config/network.config'
import router from '@/router'

/**
 * axios初始化
 */
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: requestTimeout,
  headers: {
    'Content-Type': contentType
  }
})

/**
 * axios请求拦截器
 */
service.interceptors.request.use(
  (config) => {
    const token = store.getters['user/token']
    if (token) {
      config.headers[tokenConfig.header] = tokenConfig.prefix + token
    }
    if (
      config.data &&
      config.headers['Content-Type'] ===
        'application/x-www-form-urlencoded;charset=UTF-8'
    ) {
      config.data = qs.stringify(config.data)
    }
    return config
  },
  (error) => {
    console.log(error)
    return Promise.reject(error)
  }
)

/**
 * axios响应拦截器
 */
service.interceptors.response.use(
  (response) => {
    // 二进制数据则直接返回
    if (
      response.request.responseType === 'blob' ||
      response.request.responseType === 'arraybuffer'
    ) {
      return response.data
    }
    // 未设置状态码则默认成功状态
    const code = response.data[statusName] || 200
    // 若 data.message 存在，覆盖默认提醒消息
    const message =
      response.data[messageName] || '系统未知错误，请反馈给相关人员'
    // 异常处理
    switch (code) {
      case 200: {
        return Promise.resolve(response.data)
      }
      case 401: {
        ElMessageBox.confirm(
          '登录状态已过期，您可以继续留在该页面，或者重新登录',
          '系统提示',
          {
            confirmButtonText: '重新登录',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
          .then(() => {
            store.dispatch('user/logout').then(() => {
              location.href = router.currentRoute.value.fullPath
            })
          })
          .catch(() => {})
        return Promise.reject(message)
      }
      case 500: {
        ElMessage({
          message: message,
          type: 'error'
        })
        return Promise.reject(new Error(message))
      }
      default: {
        ElNotification.error({
          title: message
        })
        return Promise.reject(new Error(message))
      }
    }
  },
  (error) => {
    console.log(error)
    let { message } = error
    if (message === 'Network Error') {
      message = '后端接口连接异常'
    } else if (message.includes('timeout')) {
      message = '系统接口请求超时'
    } else if (message.includes('Request failed with status code')) {
      message = '系统接口' + message.substr(message.length - 3) + '异常'
    }
    ElMessage({
      message: message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service
