import request from '@/utils/request'

// 获取用户信息
export function getUserInfo() {
  return request({
    url: '/user/getUserInfo',
    method: 'get'
  })
}

// 获取路由
export const getRouters = () => {
  return request({
    url: '/user/getRouters',
    method: 'get'
  })
}
