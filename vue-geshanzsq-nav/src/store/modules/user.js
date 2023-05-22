import defaultAvatar from '@/assets/images/profile.jpg'
import { login, logout } from '@/api/auth/login'
import { getUserInfo } from '@/api/auth/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { getPictureShowUrl } from '@/utils/geshanzsq'

const state = {
  token: getToken(),
  username: '',
  avatar: '',
  roleCodes: [],
  permissionCodes: []
}

const getters = {
  token: (state) => state.token,
  username: (state) => state.username,
  avatar: (state) => state.avatar,
  roleCodes: (state) => state.roleCodes,
  permissionCodes: (state) => state.permissionCodes
}

const mutations = {
  setToken: (state, token) => {
    state.token = token
  },
  setUsername: (state, username) => {
    state.username = username
  },
  setAvatar: (state, avatar) => {
    state.avatar =
      avatar === null || avatar === ''
        ? defaultAvatar
        : getPictureShowUrl(avatar)
  },
  setRoleCodes: (state, roleCodes) => {
    state.roleCodes = roleCodes
  },
  setPermissionCodes: (state, permissionCodes) => {
    if (permissionCodes) {
      state.permissionCodes = permissionCodes
    } else {
      state.permissionCodes = []
    }
  }
}

const actions = {
  // 登录
  login({ commit }, userInfo) {
    const { username, password, uuid, code } = userInfo
    return new Promise((resolve, reject) => {
      login({
        username,
        password,
        uuid,
        code
      })
        .then((response) => {
          const {
            data: { token }
          } = response
          setToken(token)
          commit('setToken', token)
          resolve()
        })
        .catch((error) => {
          reject(error)
        })
    })
  },

  // 获取用户信息
  async getUserInfo({ commit }) {
    const {
      data: { username, avatar, roleCodes, permissionCodes }
    } = await getUserInfo()
    commit('setUsername', username)
    commit('setRoleCodes', roleCodes)
    commit('setPermissionCodes', permissionCodes)
    commit('setAvatar', avatar)
  },

  // 退出登录
  async logout({ commit }) {
    try {
      await logout()
    } catch (error) {
      console.log(error)
    }

    commit('setToken', '')
    commit('setRoleCodes', [])
    removeToken()
  },

  // 设置头像
  setAvatar({ commit }, data) {
    commit('setAvatar', data)
  },
  // 设置 token
  setToken({ commit }, data) {
    commit('setToken', data)
  }
}

export default { namespaced: true, state, getters, mutations, actions }
