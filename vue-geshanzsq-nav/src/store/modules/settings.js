import {
  sideTheme,
  showSettings,
  topNav,
  tagsView,
  fixedHeader,
  sidebarLogo,
  dynamicTitle,
  searchOpen,
  weatherOpen,
  showSiteDescription,
  showCount
} from '@/config/theme.config'
import { title } from '@/config/setting.config'

const storageSetting = JSON.parse(localStorage.getItem('layout-setting')) || ''

const getters = {
  title: (state) => state.title,
  themeColor: (state) => state.themeColor,
  sideTheme: (state) => state.sideTheme,
  showSettings: (state) => state.showSettings,
  topNav: (state) => state.topNav,
  tagsView: (state) => state.tagsView,
  fixedHeader: (state) => state.fixedHeader,
  sidebarLogo: (state) => state.sidebarLogo,
  dynamicTitle: (state) => state.dynamicTitle,
  searchOpen: (state) => state.searchOpen,
  weatherOpen: (state) => state.weatherOpen,
  showSiteDescription: (state) => state.showSiteDescription,
  showCount: (state) => state.showCount
}

const state = {
  title: title,
  themeColor: storageSetting.themeColor || '#409EFF',
  sideTheme: storageSetting.sideTheme || sideTheme,
  showSettings: showSettings,
  topNav: storageSetting.topNav === undefined ? topNav : storageSetting.topNav,
  tagsView:
    storageSetting.tagsView === undefined ? tagsView : storageSetting.tagsView,
  fixedHeader:
    storageSetting.fixedHeader === undefined
      ? fixedHeader
      : storageSetting.fixedHeader,
  sidebarLogo:
    storageSetting.sidebarLogo === undefined
      ? sidebarLogo
      : storageSetting.sidebarLogo,
  dynamicTitle:
    storageSetting.dynamicTitle === undefined
      ? dynamicTitle
      : storageSetting.dynamicTitle,
  searchOpen: searchOpen,
  weatherOpen: weatherOpen,
  showSiteDescription: showSiteDescription,
  showCount: showCount
}
const mutations = {
  changeSetting: (state, { key, value }) => {
    if (Object.prototype.hasOwnProperty.call(state, key)) {
      state[key] = value
    }
  },
  setSearchOpen: (state, searchOpen) => {
    state.searchOpen = searchOpen
  },
  setWeatherOpen: (state, weatherOpen) => {
    state.weatherOpen = weatherOpen
  },
  setShowSiteDescription: (state, showSiteDescription) => {
    state.showSiteDescription = showSiteDescription
  },
  setShowCount: (state, showCount) => {
    state.showCount = showCount
  }
}

const actions = {
  // 修改布局设置
  changeSetting({ commit }, data) {
    commit('changeSetting', data)
  },
  // 修改搜索开启
  setSearchOpen({ commit }, data) {
    commit('setSearchOpen', data)
  },
  // 修改描述开启
  setShowSiteDescription({ commit }, data) {
    commit('setShowSiteDescription', data)
  },
  // 修改显示数量
  setShowCount({ commit }, data) {
    commit('setShowCount', data)
  }
}

export default {
  namespaced: true,
  getters,
  state,
  mutations,
  actions
}
