import request from '@/utils/request'

export function page(params) {
  return request({
    url: '/nav/comment/page',
    method: 'get',
    params
  })
}

export function pass(ids) {
  return request({
    url: `/nav/comment/pass/${ids}`,
    method: 'put'
  })
}

export function reject(data) {
  return request({
    url: '/nav/comment/reject',
    method: 'put',
    data
  })
}

export function sticky(id) {
  return request({
    url: `/nav/comment/sticky/${id}`,
    method: 'put'
  })
}

export function cancleSticky(id) {
  return request({
    url: `/nav/comment/cancelSticky/${id}`,
    method: 'put'
  })
}

export function remove(ids) {
  return request({
    url: `/nav/comment/delete/${ids}`,
    method: 'delete'
  })
}
