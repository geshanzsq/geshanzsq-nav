import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/nav/site/page',
    method: 'get',
    params
  })
}

export function getById(id) {
  return request({
    url: `/nav/site/getById/${id}`,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'nav/site/',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: '/nav/site/',
    method: 'put',
    data
  })
}

export function remove(ids) {
  return request({
    url: `/nav/site/delete/${ids}`,
    method: 'delete'
  })
}

export function getMaxSortByCategoryId(categoryId) {
  return request({
    url: '/nav/site/getMaxSortByCategoryId',
    method: 'get',
    params: {
      categoryId
    }
  })
}

/**
 * 更新点击量
 */
export function updateClickCount(id) {
  return request({
    url: `/nav/site/updateClickCount/${id}`,
    method: 'put'
  })
}
