import request from '@/utils/request'

export function getConfig() {
  return request({
    url: '/nav/config/getConfig',
    method: 'get'
  })
}

export function update(data) {
  return request({
    url: '/nav/config/',
    method: 'put',
    data
  })
}

export function getAbout() {
  return request({
    url: '/nav/config/about',
    method: 'get'
  })
}
