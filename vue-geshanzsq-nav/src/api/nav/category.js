import request from '@/utils/request'

export function list(params) {
  return request({
    url: '/nav/category/list',
    method: 'get',
    params
  })
}

export function tree(params) {
  return request({
    url: '/nav/category/tree',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/nav/category/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'nav/category/',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/nav/category/',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/nav/category/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSortByParentId(parentId) {
  return request({
    url: '/nav/category/getMaxSortByParentId',
    method: 'get',
    params: {
      parentId
    }
  })
}
