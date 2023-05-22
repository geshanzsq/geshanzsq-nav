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
    <sidebar v-if="!sidebarConfig.hide" class="sidebar-container" />
    <div
      :class="{ hasTagsView: needTagsView, sidebarHide: sidebarConfig.hide }"
      class="main-container"
    >
      <div :class="{ 'fixed-header': fixedHeader }">
        <navbar @setLayout="setLayout" />
        <tags-view v-if="needTagsView" />
      </div>
      <app-main />
      <settings ref="settingRef" />
    </div>
  </div>
</template>
<script setup>
import { computed, ref, watchEffect } from '@vue/runtime-core'
import { useWindowSize } from '@vueuse/core'
import { useStore } from 'vuex'

import Navbar from './components/Navbar'
import Sidebar from './components/Sidebar'
import Settings from './components/Settings'
import AppMain from './components/AppMain.vue'
import TagsView from './components/TagsView'

const store = useStore()

const theme = computed(() => store.getters['settings/theme'])
const sidebarConfig = computed(() => store.getters['app/sidebar'])
const device = computed(() => store.getters['app/device'])
const needTagsView = computed(() => store.getters['settings/tagsView'])
const fixedHeader = computed(() => store.getters['settings/fixedHeader'])
const classObj = computed(() => ({
  hideSidebar: !sidebarConfig.value.opened,
  openSidebar: sidebarConfig.value.opened,
  withoutAnimation: sidebarConfig.value.withoutAnimation,
  mobile: device.value === 'mobile'
}))

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
</style>
