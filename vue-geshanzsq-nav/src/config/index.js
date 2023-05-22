/**
 * 子配置导出
 */
const setting = require('./setting.config')
const network = require('./network.config')
const themeCli = require('./theme.config')
const vueCli = require('./vue.cli.config')
module.exports = {
  ...setting,
  ...network,
  ...themeCli,
  ...vueCli
}
