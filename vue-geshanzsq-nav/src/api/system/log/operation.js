import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/log/operation/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/log/operation/getById/${id}`,
    method: 'get'
  })
}
