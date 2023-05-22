import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/param/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/param/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/param',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/param',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/param/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSort() {
  return request({
    url: '/system/param/getMaxSort',
    method: 'get'
  })
}
