import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/role/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/role/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/role',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/role',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/role/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSort() {
  return request({
    url: '/system/role/getMaxSort',
    method: 'get'
  })
}

export function userAuthPage(params) {
  return request({
    url: '/system/role/auth/user/page',
    method: 'get',
    params
  })
}

export function userUnAuthPage(params) {
  return request({
    url: '/system/role/auth/user/not/page',
    method: 'get',
    params
  })
}

export function authUser(data) {
  return request({
    url: '/system/role/auth/user',
    method: 'post',
    data
  })
}

export function removeAuthUser(data) {
  return request({
    url: '/system/role/auth/user/delete',
    method: 'delete',
    data
  })
}
