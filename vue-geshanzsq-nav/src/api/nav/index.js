import request from '@/utils/request'

export function getStatistics() {
  return request({
    url: '/nav/index/getStatistics',
    method: 'get'
  })
}
