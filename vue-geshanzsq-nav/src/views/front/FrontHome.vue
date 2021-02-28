<template>
  <div :class="classObj" class="app-wrapper">
    <div v-if="isMobile && sidebar.opened" class="drawer-bg" :style="{height: drawerBgHeight}" @click="handleClickOutside" />
    <!-- 侧边栏 -->
    <sidebar class="sidebar-container" :menuList="menuList"/>

    <div class="main-container" :class="{'main-container-fixed-header':isMobile || fixedHeader}" ref="mainContainer">
      <!-- 头部 -->
      <div :class="{'fixed-header': isMobile || fixedHeader}">
        <navbar/>
      </div>
      <!-- 中间内容 -->
      <slot name="mainContainer"></slot>
      <!-- 底部 -->
      <footer-bottom/>
    </div>

    <!-- 右下角回到顶部 -->
    <el-backtop :right="20" :bottom="20">
      <i class="el-icon-caret-top"></i>
    </el-backtop>

    <!-- 右下角搜索图标 -->
    <el-backtop :right="20" :bottom="65">
      <!-- 添加 padding 样式，这样就不会回到顶部 -->
      <i class="el-icon-search" style="padding: 5px" @click.stop="handleSearch"></i>
    </el-backtop>

    <!-- 弹出搜索对话框 -->
    <el-dialog :visible.sync="searchOpenDialog" :width="isMobile ? '100%' : '60%'" center><search/></el-dialog>

    <!-- 布局设置 -->
    <right-panel v-if="showSettings">
      <settings />
    </right-panel>
  </div>
</template>

<script>
  import { Navbar, Sidebar } from './components'
  import Search from "@/components/Search";
  import FooterBottom from '@/components/FooterBottom'
  import RightPanel from '@/components/RightPanel'
  import Settings from '@/layout/components/Settings'
  import { mapState } from 'vuex'
  import ResizeMixin from './mixin/ResizeHandler'
  export default {
    name: 'FrontHome',
    props: {
      siteName: {
        type: String,
        default: undefined
      },
      menuList: {
        type: Array,
        default: []
      }
    },
    components: {
      Navbar,
      Sidebar,
      Search,
      FooterBottom,
      RightPanel,
      Settings
    },
    data() {
      return {
        // 搜索对话框
        searchOpenDialog: false,
      }
    },
    mixins: [ResizeMixin],
    computed: {
      ...mapState({
        sidebar: state => state.app.sidebar,
        device: state => state.app.device,
        showSettings: state => state.settings.showSettings,
      }),
      classObj() {
        return {
          hideSidebar: !this.sidebar.opened,
          openSidebar: this.sidebar.opened,
          withoutAnimation: this.sidebar.withoutAnimation,
          mobile: this.device === 'mobile'
        }
      },
      isMobile() {
        return this.device === 'mobile';
      },
      fixedHeader() {
        return this.$store.state.settings.fixedHeader
      },
      drawerBgHeight() {
        return this.$refs.mainContainer.offsetHeight + 'px';
      },
    },
    methods: {
      handleClickOutside() {
        this.$store.dispatch('app/closeSideBar', { withoutAnimation: false })
      },
      handleSearch() {
        this.searchOpenDialog = true;
      },
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/styles/mixin.scss";
  @import "~@/assets/styles/variables.scss";

  .app-wrapper {
    @include clearfix;
    position: relative;
    height: 100%;
    width: 100%;

    &.mobile.openSidebar {
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
    width: calc(100% - #{$sideBarWidth});
    transition: width 0.28s;
  }

  .hideSidebar .fixed-header {
    width: calc(100% - 54px)
  }

  .mobile .fixed-header {
    width: 100%;
  }

  .main-container {
    background-color: #F9F9F9;
    overflow-x: hidden;
  }

  .main-container-fixed-header {
    padding-top: 50px;
  }

</style>
