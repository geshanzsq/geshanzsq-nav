<template>
  <div
    :class="classObj"
    class="app-wrapper"
    :style="{ '--current-color': theme }"
  >
    <div
      v-if="device === 'mobile' && sidebarConfig.opened"
      class="drawer-bg"
      @click="handleClickOutside"
    />
    <!-- 侧边栏 -->
    <sidebar
      v-if="!sidebarConfig.hide"
      class="sidebar-container"
      :categories="categories"
    />
    <div :class="{ sidebarHide: sidebarConfig.hide }" class="main-container">
      <div :class="{ 'fixed-header': fixedHeader }">
        <!-- 头部 -->
        <navbar @setLayout="setLayout" />
      </div>
      <!-- 中间内容 -->
      <div class="app-main">
        <slot name="app-main"></slot>
        <!-- 底部友情链接 -->
        <footer-bottom />
      </div>
    </div>

    <!-- 右下角回到顶部 -->
    <el-backtop :right="20" :bottom="20" />
    <!-- 右下角搜索图标 -->
    <el-backtop v-if="searchOpen" :right="20" :bottom="65">
      <div class="search-top" @click.stop="handleSearch">
        <el-icon><Search /></el-icon>
      </div>
    </el-backtop>

    <!-- 弹出搜索对话框 -->
    <el-dialog
      v-model="searchVisible"
      :width="isMobile ? '100%' : '60%'"
      center
    >
      <third-search />
    </el-dialog>

    <settings ref="settingRef" />
  </div>
</template>
<script setup>
import { computed, ref, watchEffect } from '@vue/runtime-core'
import { useWindowSize } from '@vueuse/core'
import { useStore } from 'vuex'

import Settings from '@/layout/components/Settings'
import Navbar from './components/Navbar'
import Sidebar from './components/Sidebar'
import ThirdSearch from './components/Search'
import FooterBottom from './components/FooterBottom'

defineProps({
  categories: {
    type: Array,
    require: true
  }
})

const store = useStore()

const theme = computed(() => store.getters['settings/theme'])
const sidebarConfig = computed(() => store.getters['app/sidebar'])
const device = computed(() => store.getters['app/device'])
const fixedHeader = computed(() => store.getters['settings/fixedHeader'])
const classObj = computed(() => ({
  hideSidebar: !sidebarConfig.value.opened,
  openSidebar: sidebarConfig.value.opened,
  withoutAnimation: sidebarConfig.value.withoutAnimation,
  mobile: device.value === 'mobile'
}))
const searchOpen = computed(() => store.getters['settings/searchOpen'])
// 是否移动端
const isMobile = computed(() => store.getters['app/isMobile'])
const searchVisible = ref(false)

const { width } = useWindowSize()
// 参考 Bootstrap 的响应式设计
const defaultWidth = 992

watchEffect(() => {
  if (device.value === 'mobile' && sidebarConfig.value.opened) {
    store.dispatch('app/closeSideBar', { withoutAnimation: false })
  }
  if (width.value - 1 < defaultWidth) {
    store.dispatch('app/toggleDevice', 'mobile')
    store.dispatch('app/closeSideBar', { withoutAnimation: true })
  } else {
    store.dispatch('app/toggleDevice', 'desktop')
  }
})

function handleClickOutside() {
  store.dispatch('app/closeSideBar', { withoutAnimation: false })
}

const settingRef = ref(null)
function setLayout() {
  settingRef.value.openSetting()
}

/**
 * 右下角点击搜索
 */
function handleSearch() {
  searchVisible.value = true
}
</script>

<style lang="scss" scoped>
@import '@/assets/styles/mixin.scss';
@import '@/assets/styles/variables.module.scss';

.app-wrapper {
  @include clearfix;
  position: relative;
  height: 100%;
  width: 100%;

  &.mobile.openSidebar {
    position: fixed;
    top: 0;
  }

  .app-main {
    /* 50= navbar  50  */
    min-height: calc(100vh - 50px);
    width: 100%;
    position: relative;
    overflow: hidden;
  }

  .fixed-header + .app-main {
    padding-top: 50px;
  }
}

.drawer-bg {
  background: #000;
  opacity: 0.3;
  width: 100%;
  top: 0;
  height: 100%;
  position: absolute;
  z-index: 999;
}

.fixed-header {
  position: fixed;
  top: 0;
  right: 0;
  z-index: 9;
  width: calc(100% - #{$base-sidebar-width});
  transition: width 0.28s;
}

.hideSidebar .fixed-header {
  width: calc(100% - 54px);
}

.sidebarHide .fixed-header {
  width: 100%;
}

.mobile .fixed-header {
  width: 100%;
}

.search-top {
  width: 40px;
  height: 40px;
  line-height: 40px;
  text-align: center;
}
</style>
