import request from '@/utils/request'

//查询导航
export function getFrontNav() {
  return request({
    url: '/frontNav',
    method: 'get'
  });
}

//搜索站内
export function searchSite(siteName) {
  return request({
    url: '/frontNav/search/' + siteName,
    method: 'get',
  })
}
