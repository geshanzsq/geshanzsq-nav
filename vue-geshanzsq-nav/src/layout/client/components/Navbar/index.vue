<template>
  <div class="navbar">
    <hamburger
      id="hamburger-container"
      :is-active="sidebar.opened"
      class="hamburger-container"
      @toggleClick="toggleSideBar"
    />

    <weather v-if="weatherOpen && !isMobile" class="navbar-weather" />

    <div class="right-menu">
      <a href="https://gitee.com/geshanzsq/geshanzsq-nav" target="_blank">
        <svg-icon icon-name="gitee" class="source-code" />
      </a>
      <a href="https://github.com/geshanzsq/geshanzsq-nav" target="_blank">
        <svg-icon icon-name="github" class="source-code" />
      </a>
    </div>
  </div>
</template>

<script setup>
import { useStore } from 'vuex'
import { computed } from 'vue'

import Hamburger from '@/components/Hamburger'
import Weather from '@/components/Weather'

const store = useStore()
const sidebar = computed(() => store.getters['app/sidebar'])
const weatherOpen = computed(() => store.getters['settings/weatherOpen'])

function toggleSideBar() {
  store.dispatch('app/toggleSideBar')
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background 0.3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .navbar-weather {
    float: left;
    margin: 15px;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;
    display: flex;

    .source-code {
      margin-right: 10px;
      display: inline-block;
      font-size: 30px;
      height: 100%;
      vertical-align: text-bottom;
    }
  }
}
</style>
