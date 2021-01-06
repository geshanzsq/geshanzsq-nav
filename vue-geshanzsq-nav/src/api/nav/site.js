import request from '@/utils/request'

// 查询导航网站信息列表
export function listSite(query) {
  return request({
    url: '/nav/site/list',
    method: 'get',
    params: query
  })
}

// 查询导航网站信息详细
export function getSite(siteId) {
  return request({
    url: '/nav/site/' + siteId,
    method: 'get'
  })
}

// 新增导航网站信息
export function addSite(data) {
  return request({
    url: '/nav/site',
    method: 'post',
    data: data
  })
}

// 修改导航网站信息
export function updateSite(data) {
  return request({
    url: '/nav/site',
    method: 'put',
    data: data
  })
}

// 删除导航网站信息
export function delSite(siteId) {
  return request({
    url: '/nav/site/' + siteId,
    method: 'delete'
  })
}

//查询导航网站信息列表
export function getNavSiteForUser(query) {
  return request({
    url: '/nav/site/getNavSiteForUser',
    method: 'get',
    params: query
  })
}

//上传网站图片
export function uploadPicture(data) {
  return request({
    url: '/nav/site/uploadSiteImg',
    method: 'post',
    data: data
  })
}

//获取网站菜单下最大的排序
export function getSiteMaxOrderNum(menuId) {
  return request({
    url: '/nav/site/getSiteMaxOrderNum?menuId=' + menuId,
    method: 'get',
  })
}

// 采集网站图标
export function collectSiteIcon(siteUrl) {
  return request({
    url: '/nav/site/collectSiteIcon?siteUrl=' + siteUrl,
    method: 'get'
  })
}
