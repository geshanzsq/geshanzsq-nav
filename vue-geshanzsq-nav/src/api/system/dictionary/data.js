import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/system/dictionary/data/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/system/dictionary/data/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/system/dictionary/data',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/system/dictionary/data',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/system/dictionary/data/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSortByDictionaryId(dictionaryId) {
  return request({
    url: '/system/dictionary/data/getMaxSortByDictionaryId',
    method: 'get',
    params: {
      dictionaryId
    }
  })
}
