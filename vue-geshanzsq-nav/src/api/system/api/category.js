import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/api/category/page',
    method: 'get',
    params
  })
}

export function list() {
  return request({
    url: '/system/api/category/list',
    method: 'get'
  })
}

export function getById(id) {
  return request({
    url: `/system/api/category/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/api/category',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/api/category',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/api/category/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSort() {
  return request({
    url: '/system/api/category/getMaxSort',
    method: 'get'
  })
}
