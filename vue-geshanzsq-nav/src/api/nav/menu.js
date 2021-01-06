import request from '@/utils/request'

// 查询导航菜单列表
export function listMenu(query) {
  return request({
    url: '/nav/menu/list',
    method: 'get',
    params: query
  })
}

// 获取导航菜单下拉树列表
export function treeSelect() {
  return request({
    url: '/nav/menu/treeSelect',
    method: 'get'
  })
}

// 查询导航菜单详细
export function getMenu(menuId) {
  return request({
    url: '/nav/menu/' + menuId,
    method: 'get'
  })
}

// 新增导航菜单
export function addMenu(data) {
  return request({
    url: '/nav/menu',
    method: 'post',
    data: data
  })
}

// 修改导航菜单
export function updateMenu(data) {
  return request({
    url: '/nav/menu',
    method: 'put',
    data: data
  })
}

// 删除导航菜单
export function delMenu(menuId) {
  return request({
    url: '/nav/menu/' + menuId,
    method: 'delete'
  })
}

// 获取该子菜单下最大的排序
export function getMaxChildrenMenuOrderNum(menuId) {
  return request({
    url: '/nav/menu/getMaxChildrenMenuOrderNum?menuId=' + menuId,
    method: 'get'
  })
}
