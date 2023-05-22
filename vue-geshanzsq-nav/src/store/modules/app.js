import Cookies from 'js-cookie'

const getters = {
  sidebar: (state) => state.sidebar,
  device: (state) => state.device,
  isMobile: (state) => state.device !== 'desktop',
  size: (state) => state.size
}

const state = {
  sidebar: {
    opened: Cookies.get('sidebarStatus')
      ? !!+Cookies.get('sidebarStatus')
      : true,
    withoutAnimation: false,
    hide: false
  },
  device: 'desktop',
  size: Cookies.get('size') || 'default'
}

const mutations = {
  toggleSideBar: (state) => {
    if (state.sidebar.hide) {
      return false
    }
    state.sidebar.opened = !state.sidebar.opened
    state.sidebar.withoutAnimation = false
    if (state.sidebar.opened) {
      Cookies.set('sidebarStatus', 1)
    } else {
      Cookies.set('sidebarStatus', 0)
    }
  },
  closeSideBar: (state, withoutAnimation) => {
    Cookies.set('sidebarStatus', 0)
    state.sidebar.opened = false
    state.sidebar.withoutAnimation = withoutAnimation
  },
  toggleDevice: (state, device) => {
    state.device = device
  },
  setSize: (state, size) => {
    state.size = size
    Cookies.set('size', size)
  },
  toggleSideBarHide: (state, status) => {
    state.sidebar.hide = status
  }
}

const actions = {
  toggleSideBar({ commit }) {
    commit('toggleSideBar')
  },
  closeSideBar({ commit }, { withoutAnimation }) {
    commit('closeSideBar', withoutAnimation)
  },
  toggleDevice({ commit }, device) {
    commit('toggleDevice', device)
  },
  setSize({ commit }, size) {
    commit('setSize', size)
  },
  toggleSideBarHide({ commit }, status) {
    commit('toggleSideBarHide', status)
  }
}

export default {
  namespaced: true,
  getters,
  state,
  mutations,
  actions
}
