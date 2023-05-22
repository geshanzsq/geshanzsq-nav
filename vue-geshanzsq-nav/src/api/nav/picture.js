import request from '@/utils/request'

/**
 * 上传网站
 */
export function uploadSite(data) {
  return request({
    url: '/nav/picture/site/upload',
    method: 'post',
    data: data
  })
}

/**
 * 上传头像
 */
export function uploadAvavar(data) {
  return request({
    url: '/nav/picture/upload/avatar',
    method: 'post',
    data: data
  })
}
