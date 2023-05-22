import request from '@/utils/request'

/**
 * 获取评论开启状态
 */
export function getOpenStatus() {
  return request({
    url: '/client/nav/comment/getOpenStatus',
    method: 'get'
  })
}

/**
 * 获取评论树形结构
 */
export function getTree() {
  return request({
    url: '/client/nav/comment/tree',
    method: 'get'
  })
}

/**
 * 提交评论
 */
export function add(data) {
  return request({
    url: '/client/nav/comment',
    method: 'post',
    data
  })
}
