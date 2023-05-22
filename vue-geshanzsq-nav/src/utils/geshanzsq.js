/**
 * 通用js方法封装处理
 */

import store from '@/store'
import { isHttp } from './validate'

// @description 格式化时间
export function parseTime(time, cFormat) {
  if (time === undefined || time === '' || time === null) {
    return ''
  }
  if (arguments.length === 0) {
    return null
  }
  const format = cFormat || '{y}-{m}-{d} {h}:{i}:{s}'
  let date
  if (typeof time === 'object') {
    date = time
  } else {
    if (typeof time === 'string' && /^[0-9]+$/.test(time)) {
      time = parseInt(time)
    }
    if (typeof time === 'number' && time.toString().length === 10) {
      time = time * 1000
    }
    date = new Date(time)
  }
  const formatObj = {
    y: date.getFullYear(),
    m: date.getMonth() + 1,
    d: date.getDate(),
    h: date.getHours(),
    i: date.getMinutes(),
    s: date.getSeconds(),
    a: date.getDay()
  }
  return format.replace(/{([ymdhisa])+}/g, (result, key) => {
    let value = formatObj[key]
    if (key === 'a') {
      return ['日', '一', '二', '三', '四', '五', '六'][value]
    }
    if (result.length > 0 && value < 10) {
      value = '0' + value
    }
    return value || 0
  })
}

// 格式化时间
export function formatTime(time, option) {
  if (('' + time).length === 10) {
    time = parseInt(time) * 1000
  } else {
    time = +time
  }
  const d = new Date(time)
  const now = Date.now()

  const diff = (now - d) / 1000

  if (diff < 30) {
    return '刚刚'
  } else if (diff < 3600) {
    // less 1 hour
    return Math.ceil(diff / 60) + '分钟前'
  } else if (diff < 3600 * 24) {
    return Math.ceil(diff / 3600) + '小时前'
  } else if (diff < 3600 * 24 * 2) {
    return '1天前'
  }
  if (option) {
    return parseTime(time, option)
  } else {
    return (
      d.getMonth() +
      1 +
      '月' +
      d.getDate() +
      '日' +
      d.getHours() +
      '时' +
      d.getMinutes() +
      '分'
    )
  }
}

// 表单重置
export function resetForm(refName) {
  if (this.$refs[refName]) {
    this.$refs[refName].resetFields()
  }
}

// 添加日期范围
export function addDateRange(params, dateRange, propName) {
  const search = params
  search.params =
    typeof search.params === 'object' &&
    search.params !== null &&
    !Array.isArray(search.params)
      ? search.params
      : {}
  dateRange = Array.isArray(dateRange) ? dateRange : []
  if (typeof propName === 'undefined') {
    search.params.beginTime = dateRange[0]
    search.params.endTime = dateRange[1]
  } else {
    search.params['begin' + propName] = dateRange[0]
    search.params['end' + propName] = dateRange[1]
  }
  return search
}

/**
 * 获取数据字典标签
 * @param {*} dictionaryCode 字典编码
 * @param {*} value 字典值
 */
export function getDictionaryLabel(dictionaryCode, value) {
  const dictionaryData = getDictionaryData(dictionaryCode, value)
  if (dictionaryData === undefined) {
    return undefined
  }
  return dictionaryData.dictionaryLabel
}

/**
 * 获取数据字典数据
 * @param {*} dictionaryCode 字典编码
 * @param {*} value 字典值
 */
export function getDictionaryData(dictionaryCode, value) {
  if (value === undefined) {
    return undefined
  }
  // 获取数据字典
  const dictionary = getDictionary(dictionaryCode)
  if (dictionary.length === 0) {
    return undefined
  }
  for (const dictionaryData of dictionary) {
    if (dictionaryData.dictionaryValue === value + '') {
      return dictionaryData
    }
  }
  return undefined
}

/**
 * 获取数据字典
 * @param {*} dictionaryCode 字典编码
 */
export function getDictionary(dictionaryCode) {
  if (dictionaryCode === undefined) {
    return []
  }
  const dictionaryInfoList = store.getters['dictionary/allDictionaryInfo']
  for (const dictionary of dictionaryInfoList) {
    if (dictionaryCode === dictionary.dictionaryCode) {
      return dictionary.dictionaryDataList
    }
  }
  return []
}

// 字符串格式化(%s )
export function sprintf(str) {
  const args = arguments
  let flag = true
  let i = 1
  str = str.replace(/%s/g, function () {
    const arg = args[i++]
    if (typeof arg === 'undefined') {
      flag = false
      return ''
    }
    return arg
  })
  return flag ? str : ''
}

// 转换字符串，undefined,null等转化为""
export function parseStrEmpty(str) {
  if (!str || str === 'undefined' || str === 'null') {
    return ''
  }
  return str
}

// 数据合并
export function mergeRecursive(source, target) {
  for (const p in target) {
    try {
      if (target[p].constructor === Object) {
        source[p] = mergeRecursive(source[p], target[p])
      } else {
        source[p] = target[p]
      }
    } catch (e) {
      source[p] = target[p]
    }
  }
  return source
}

/**
 * 构造树型结构数据
 * @param {*} data 数据源
 * @param {*} id id字段 默认 'id'
 * @param {*} parentId 父节点字段 默认 'parentId'
 * @param {*} children 孩子节点字段 默认 'children'
 */
export function handleTree(data, id, parentId, children) {
  const config = {
    id: id || 'id',
    parentId: parentId || 'parentId',
    childrenList: children || 'children'
  }

  const childrenListMap = {}
  const nodeIds = {}
  const tree = []

  for (const d of data) {
    const parentId = d[config.parentId]
    if (childrenListMap[parentId] == null) {
      childrenListMap[parentId] = []
    }
    nodeIds[d[config.id]] = d
    childrenListMap[parentId].push(d)
  }

  for (const d of data) {
    const parentId = d[config.parentId]
    if (nodeIds[parentId] == null) {
      tree.push(d)
    }
  }

  for (const t of tree) {
    adaptToChildrenList(t)
  }

  function adaptToChildrenList(o) {
    if (childrenListMap[o[config.id]] !== null) {
      o[config.childrenList] = childrenListMap[o[config.id]]
    }
    if (o[config.childrenList]) {
      for (const c of o[config.childrenList]) {
        adaptToChildrenList(c)
      }
    }
  }
  return tree
}

/**
 * 参数处理
 * @param {*} params  参数
 */
export function tansParams(params) {
  let result = ''
  for (const propName of Object.keys(params)) {
    const value = params[propName]
    const part = encodeURIComponent(propName) + '='
    if (value !== null && typeof value !== 'undefined') {
      if (typeof value === 'object') {
        for (const key of Object.keys(value)) {
          if (value[key] !== null && typeof value[key] !== 'undefined') {
            const params = propName + '[' + key + ']'
            const subPart = encodeURIComponent(params) + '='
            result += subPart + encodeURIComponent(value[key]) + '&'
          }
        }
      } else {
        result += part + encodeURIComponent(value) + '&'
      }
    }
  }
  return result
}

// 返回项目路径
export function getNormalPath(p) {
  if (p.length === 0 || !p || p === 'undefined') {
    return p
  }
  const res = p.replace('//', '/')
  if (res[res.length - 1] === '/') {
    return res.slice(0, res.length - 1)
  }
  return res
}

// 验证是否为blob格式
export async function blobValidate(data) {
  try {
    const text = await data.text()
    JSON.parse(text)
    return false
  } catch (error) {
    return true
  }
}

/**
 * 复制文字到剪切板
 * @param text
 */
export function copyText(text) {
  const oInput = document.createElement('input')
  oInput.value = text
  document.body.appendChild(oInput)
  oInput.select() // 选择对象
  document.execCommand('Copy') // 执行浏览器复制命令
  oInput.className = 'oInput'
  oInput.style.display = 'none'
}

/**
 * 获取图片显示链接
 */
export function getPictureShowUrl(picturePath, isProjectImage) {
  if (!picturePath || picturePath.indexOf('data:image') !== -1) {
    return picturePath
  }
  return isHttp(picturePath) || isProjectImage
    ? picturePath
    : process.env.VUE_APP_BASE_FILE + picturePath
}

/**
 * 获取主机域名
 */
export function getHost() {
  return window.location.protocol + '//' + window.location.host
}

/**
 * 打开网站
 */
export function openSite(siteUrl) {
  const host = window.location.host
  // 如果跳转网站为当前网站，不加 ref 后缀
  if (
    siteUrl.indexOf('http://' + host) === -1 ||
    siteUrl.indexOf('https://' + host) === -1
  ) {
    window.open(siteUrl, '_blank')
    return
  }
  if (siteUrl.lastIndexOf('?') > 0) {
    siteUrl = siteUrl + '&ref=' + host
  } else {
    siteUrl = siteUrl + '?ref=' + host
  }
  window.open(siteUrl, '_blank')
}
