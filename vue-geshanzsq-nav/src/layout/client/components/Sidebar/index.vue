<template>
  <div
    :class="{ 'has-logo': showLogo }"
    :style="{
      backgroundColor:
        sideTheme === 'theme-dark'
          ? variables.menuBackground
          : variables.menuLightBackground
    }"
  >
    <logo v-if="showLogo" :collapse="isCollapse" />
    <el-scrollbar :class="sideTheme" wrap-class="scrollbar-wrapper">
      <el-menu
        :collapse="isCollapse"
        :background-color="
          sideTheme === 'theme-dark'
            ? variables.menuBackground
            : variables.menuLightBackground
        "
        :text-color="
          sideTheme === 'theme-dark'
            ? variables.menuColor
            : variables.menuLightColor
        "
        :unique-opened="true"
        :active-text-color="theme"
        :collapse-transition="false"
        mode="vertical"
      >
        <sidebar-item
          v-for="category in categories"
          :key="category.id"
          :item="category"
        />

        <router-link to="/about" target="_blank">
          <el-menu-item index="about">
            <svg-icon icon-name="heart" />
            <template #title><span class="menu-title">关于本站</span></template>
          </el-menu-item>
        </router-link>
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script setup>
import Logo from './Logo'
import SidebarItem from './SidebarItem'
import variables from '@/assets/styles/variables.module.scss'
import { useStore } from 'vuex'
import { computed } from '@vue/runtime-core'

const store = useStore()

defineProps({
  categories: {
    type: Array,
    require: true
  }
})

const showLogo = computed(() => store.getters['settings/sidebarLogo'])
const sideTheme = computed(() => store.getters['settings/sideTheme'])
const theme = computed(() => store.getters['settings/theme'])
const sidebar = store.getters['app/sidebar']
const isCollapse = computed(() => !sidebar.opened)
</script>
