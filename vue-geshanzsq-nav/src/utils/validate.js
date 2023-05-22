/**
 * 是否为外部资源
 */
export function isExternal(path) {
  return /^(https?:|mailto:|tel:)/.test(path)
}

/**
 * 判断是否是数组
 */
export function isArray(arg) {
  if (typeof Array.isArray === 'undefined') {
    return Object.prototype.toString.call(arg) === '[object Array]'
  }
  return Array.isArray(arg)
}

/**
 * 判断 url 是否是 http 或 https
 */
export function isHttp(url) {
  if (!url) {
    return false
  }
  return url.indexOf('http://') !== -1 || url.indexOf('https://') !== -1
}
