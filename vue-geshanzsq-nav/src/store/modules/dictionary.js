import { getAllDictionaryInfo } from '@/api/system/dictionary/dictionary'
const getters = {
  allDictionaryInfo: (state) => state.allDictionaryInfo
}

const state = {
  allDictionaryInfo: []
}

const mutations = {
  setAllDictionaryInfo: (state, allDictionaryInfo) => {
    state.allDictionaryInfo = allDictionaryInfo
  }
}

const actions = {
  // 获取字典数据
  async getAllDictionaryInfo({ commit }) {
    const { data } = await getAllDictionaryInfo()
    commit('setAllDictionaryInfo', data)
  }
}

export default {
  namespaced: true,
  getters,
  state,
  mutations,
  actions
}
