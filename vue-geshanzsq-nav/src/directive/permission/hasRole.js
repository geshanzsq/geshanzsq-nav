/**
 * v-hasRole 角色权限处理
 */

import store from '@/store'
import { superAdmin } from '@/config/setting.config'

export default {
  mounted(el, binding, vnode) {
    const { value } = binding
    const roles = store.getters['user/roleCodes']

    if (value && value instanceof Array && value.length > 0) {
      const roleFlag = value
      const hasRole = roles.some((role) => {
        return superAdmin === role || roleFlag.includes(role)
      })

      if (!hasRole) {
        el.parentNode && el.parentNode.removeChild(el)
      }
    } else {
      throw new Error('请设置角色权限标签值"')
    }
  }
}
