import SvgIcon from '@/components/SvgIcon'
// 导入所有的 svg 图标
const svgRequire = require.context('@/assets/icons/svg', false, /\.svg$/)
svgRequire.keys().forEach((svgIcon) => svgRequire(svgIcon))

// SvgIcon 全局注册
export default (app) => {
  app.component('svg-icon', SvgIcon)
}
