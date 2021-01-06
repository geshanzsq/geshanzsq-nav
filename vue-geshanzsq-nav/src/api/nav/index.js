import request from '@/utils/request'

export function getAllCount() {
  return request({
    url: '/nav/index',
    method: 'get'
  })
}