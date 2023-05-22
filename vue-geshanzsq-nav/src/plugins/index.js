import modal from './modal'
import tab from './tab'

export default function installPlugins(app) {
  // 模态框对象
  app.config.globalProperties.$modal = modal
  app.config.globalProperties.$tab = tab
}
