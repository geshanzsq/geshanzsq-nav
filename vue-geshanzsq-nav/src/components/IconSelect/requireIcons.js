const icons = []
const svgRequire = require.context('@/assets/icons/svg', false, /\.svg$/)

svgRequire.keys().forEach((svgIcon) => {
  const path = svgIcon.split('./')[1].split('.svg')[0]
  icons.push(path)
})

export default icons
