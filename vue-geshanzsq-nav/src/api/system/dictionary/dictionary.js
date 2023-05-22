import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/dictionary/page',
    method: 'get',
    params
  })
}

export function list() {
  return request({
    url: '/system/dictionary/list',
    method: 'get'
  })
}

export function getById(id) {
  return request({
    url: `/system/dictionary/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/dictionary',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/dictionary',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/dictionary/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSort() {
  return request({
    url: '/system/dictionary/getMaxSort',
    method: 'get'
  })
}

export function getAllDictionaryInfo() {
  return request({
    url: '/system/dictionary/getAllDictionaryInfo',
    method: 'get'
  })
}
