import request from '@/utils/request'

/**
 * 分类网站列表
 */
export function categorySiteList() {
  return request({
    url: '/client/nav/category/site/list',
    method: 'get'
  })
}

/**
 * 分类列表
 */
export function categoryList() {
  return request({
    url: '/client/nav/category/list',
    method: 'get'
  })
}
