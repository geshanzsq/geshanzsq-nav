import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/api/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/api/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/api',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/api',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/api/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSortByCategoryId(apiCategoryId) {
  return request({
    url: '/system/api/getMaxSortByCategoryId',
    method: 'get',
    params: {
      apiCategoryId
    }
  })
}
