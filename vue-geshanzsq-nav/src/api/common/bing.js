import request from '@/utils/request'

// 获取微软Bing图片
export function getBingImage() {
  return request({
    url: '/bing/getBingImage',
    method: 'get'
  })
}
