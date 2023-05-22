import store from '@/store'
import { siteTitle } from '@/config/setting.config'

/**
 * 动态修改标题
 */
export function useDynamicTitle(metaTitle) {
  if (store.getters['settings/dynamicTitle'] && metaTitle) {
    document.title = metaTitle + ' - ' + siteTitle
  } else {
    document.title = siteTitle
  }
}
