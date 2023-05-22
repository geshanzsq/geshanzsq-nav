/**
 * 网络配置
 */
module.exports = {
  // 配后端数据的接收方式application/json;charset=UTF-8 或 application/x-www-form-urlencoded;charset=UTF-8
  contentType: 'application/json;charset=UTF-8',
  // 最长请求时间
  requestTimeout: 10000,
  // 操作正常code，支持String、Array、int多种类型
  successCode: [200, 0, '200', '0'],
  // 数据状态的字段名称
  statusName: 'code',
  // 状态信息的字段名称
  messageName: 'message',
  // token 令牌配置
  tokenConfig: {
    // 自定义令牌标识
    header: 'Authorization',
    // 令牌前缀
    prefix: 'Bearer ',
    // 过期时间，单位为天数
    expireTime: 30
  },
  // 错误码内容提示
  errorCode: {
    401: '认证失败，无法访问系统资源',
    403: '当前操作没有权限',
    404: '访问资源不存在'
  }
}
