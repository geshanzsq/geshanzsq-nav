import request from '@/utils/request'

// 查询评论列表
export function listComment(query) {
  return request({
    url: '/nav/comment/list',
    method: 'get',
    params: query
  })
}

// 查询评论详细
export function getComment(commentId) {
  return request({
    url: '/nav/comment/' + commentId,
    method: 'get'
  })
}

// 新增评论
export function addComment(data) {
  return request({
    url: '/nav/comment/addComment',
    method: 'post',
    data: data
  })
}

// 修改评论
export function updateComment(data) {
  return request({
    url: '/nav/comment',
    method: 'put',
    data: data
  })
}

// 删除评论
export function delComment(commentId) {
  return request({
    url: '/nav/comment/' + commentId,
    method: 'delete'
  })
}

// 导出评论
export function exportComment(query) {
  return request({
    url: '/nav/comment/export',
    method: 'get',
    params: query
  })
}

// 通过评论
export function passComment(data) {
  return request({
    url: '/nav/comment/passComment',
    method: 'put',
    data: data
  })
}

// 不通过评论
export function noPassComment(data) {
  return request({
    url: '/nav/comment/noPassComment',
    method: 'put',
    data: data
  })
}

// 置顶评论
export function stickyComment(commentId) {
  return request({
    url: '/nav/comment/stickyComment?commentId=' + commentId,
    method: 'put'
  })
}

// 取消评论
export function cancelStickyComment(commentId) {
  return request({
    url: '/nav/comment/cancelStickyComment?commentId=' + commentId,
    method: 'put'
  })
}
