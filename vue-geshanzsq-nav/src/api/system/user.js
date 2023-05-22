import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/user/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/user/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/user',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/user',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/user/delete/${ids}`,
    method: 'delete'
  })
}

export function resetPassword(data) {
  return request({
    url: '/system/user/resetPassword',
    method: 'put',
    data
  })
}

export function userUpdateInfo(data) {
  return request({
    url: '/system/user/userUpdateInfo',
    method: 'put',
    data
  })
}

export function resetUserPassword(data) {
  return request({
    url: '/system/user/resetUserPassword',
    method: 'put',
    data
  })
}
