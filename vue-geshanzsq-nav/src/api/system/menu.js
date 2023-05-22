import request from '@/utils/request'

export function list(params) {
  return request({
    url: '/system/menu/list',
    method: 'get',
    params
  })
}

export function tree() {
  return request({
    url: '/system/menu/tree',
    method: 'get'
  })
}

export function getById(id) {
  return request({
    url: `/system/menu/getById/${id}`,
    method: 'get'
  })
}

export function getMaxSortByParentId(parentId) {
  return request({
    url: '/system/menu/getMaxSortByParentId',
    method: 'get',
    params: {
      parentId
    }
  })
}

export function add(data) {
  return request({
    url: '/system/menu',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/menu',
    method: 'put',
    data
  })
}

export function remove(id) {
  return request({
    url: `/system/menu/delete/${id}`,
    method: 'delete'
  })
}

export function authApiList(params) {
  return request({
    url: '/system/menu/auth/api/list',
    method: 'get',
    params
  })
}

export function authApi(data) {
  return request({
    url: '/system/menu/auth/api',
    method: 'post',
    data
  })
}
