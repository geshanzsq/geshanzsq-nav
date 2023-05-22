const path = require('path')
function resolve(dir) {
  return path.join(__dirname, dir)
}

const { defineConfig } = require('@vue/cli-service')
const CompressionPlugin = require('compression-webpack-plugin')

const { devPort, devOpenBrowser } = require('./src/config/vue.cli.config')

const {
  siteTitle,
  siteDescription,
  siteKeywords,
  siteLoading
} = require('./src/config/setting.config')

process.env.VUE_APP_SITE_TITLE = siteTitle
process.env.VUE_APP_SITE_DESCRIPTION = siteDescription
process.env.VUE_APP_SITE_KEYWORDS = siteKeywords
process.env.VUE_APP_SITE_LOADING = siteLoading

module.exports = defineConfig({
  transpileDependencies: true,
  // webpack-dev-server 相关配置
  devServer: {
    port: devPort,
    open: devOpenBrowser,
    proxy: {
      [process.env.VUE_APP_BASE_API]: {
        target: 'http://localhost:8083/geshanzsq-nav-api',
        changeOrigin: true,
        pathRewrite: {
          ['^' + process.env.VUE_APP_BASE_API]: ''
        }
      }
    }
  },
  configureWebpack: {
    plugins: [
      new CompressionPlugin({
        // 使用gzip压缩
        algorithm: 'gzip',
        // 匹配文件名
        test: /\.js$|\.html$|\.css$/,
        // 压缩后的文件名(保持原文件名，后缀加.gz)
        filename: '[path][base].gz',
        // 压缩率小于1才会压缩
        minRatio: 1,
        // 对超过10k的数据压缩
        threshold: 10240,
        // 是否删除未压缩的源文件，谨慎设置，如果希望提供非gzip的资源，可不设置或者设置为false（比如删除打包后的gz后还可以加载到原始资源文件）
        deleteOriginalAssets: false
      })
    ]
  },
  // svg-sprite-loader 设置
  chainWebpack(config) {
    config.module.rule('svg').exclude.add(resolve('src/assets/icons')).end()
    config.module
      .rule('icons')
      .test(/\.svg$/)
      .include.add(resolve('src/assets/icons'))
      .end()
      .use('svg-sprite-loader')
      .loader('svg-sprite-loader')
      .options({
        symbolId: 'icon-[name]'
      })
      .end()
  }
})
