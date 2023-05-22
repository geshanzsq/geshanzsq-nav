import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/log/login/page',
    method: 'get',
    params
  })
}
