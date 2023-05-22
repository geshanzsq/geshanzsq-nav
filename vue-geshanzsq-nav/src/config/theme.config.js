/**
 * @description 主题配置
 */
module.exports = {
  /**
   * 侧边栏主题 深色主题theme-dark，浅色主题theme-light
   */
  sideTheme: 'theme-dark',
  /**
   * 是否系统布局配置
   */
  showSettings: false,

  /**
   * 是否显示 tagsView
   */
  tagsView: true,

  /**
   * 是否固定头部
   */
  fixedHeader: true,

  /**
   * 是否显示logo
   */
  sidebarLogo: true,

  /**
   * 是否显示动态标题
   */
  dynamicTitle: true,

  /**
   * 显示搜索
   */
  searchOpen: true,

  /**
   * 显示天气
   */
  weatherOpen: true,

  /**
   * 是否显示网站描述
   */
  showSiteDescription: true,

  /**
   * 每行显示数量
   */
  showCount: 4,

  /**
   * 百度统计代码链接
   */
  baiduStatisticsUrl: '',

  /**
   * @type {string | array} 'production' | ['production', 'development']
   * @description Need show err logs component.
   * The default is only used in the production env
   * If you want to also use it in dev, you can pass ['production', 'development']
   */
  errorLog: 'production'
}
