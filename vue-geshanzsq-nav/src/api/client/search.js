import request from '@/utils/request'

export function siteList(searchContent) {
  return request({
    url: `/client/search/site/list?searchContent=${searchContent}`,
    method: 'get'
  })
}

export function categorySiteList(searchContent) {
  return request({
    url: `/client/search/category/site/list?searchContent=${searchContent}`,
    method: 'get'
  })
}
