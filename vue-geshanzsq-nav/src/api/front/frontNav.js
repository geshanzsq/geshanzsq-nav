import request from '@/utils/request'

//查询导航
export function getFrontNav() {
  return request({
    url: '/frontNav',
    method: 'get'
  });
}

// 获取导航菜单
export function getFrontMenu() {
  return request({
    url: '/frontNav/getFrontMenu',
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

// 获取关于本站
export function getNavAbout() {
  return request({
    url: '/frontNav/getNavAbout',
    method: 'get'
  })
}

// 获取评论
export function getCommentList() {
  return request({
    url: '/frontNav/comment/getCommentList',
    method: 'get'
  })
}
