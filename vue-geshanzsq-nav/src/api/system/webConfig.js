import request from '@/utils/request'


// 查询网站配置详细
export function getWebConfig() {
  return request({
    url: '/system/webConfig/getWebConfig',
    method: 'get'
  })
}

// 修改网站配置
export function updateWebConfig(data) {
  return request({
    url: '/system/webConfig/updateWebConfig',
    method: 'put',
    data: data
  })
}
