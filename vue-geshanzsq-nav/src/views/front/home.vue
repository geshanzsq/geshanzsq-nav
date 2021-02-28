<template>
    <front-home :menu-list="menuList">
      <div slot="mainContainer" class="app-container"
           v-loading="loading" element-loading-text="拼命加载中，请稍等..." element-loading-spinner="el-icon-loading">
        <el-row :gutter="24" type="flex" justify="center">
          <el-col :sm="16" :sx="24">
            <search class="search"/>
          </el-col>
        </el-row>
        <div v-for="menu in siteList">
          <h4 v-if="menu.siteList" :id="'item-' + menu.menuId" :ref="'item-' +menu.menuId">
            <svg-icon icon-class="tag" style="margin-right: 7px;font-size: 18px"/>
            <span style="color: #555;font-size: 17px;font-weight:normal">{{menu.menuName}}</span>
          </h4>
          <el-row :gutter="24" >
            <el-col :sm="6" :sx="24" style="margin-bottom: 15px" :key="site.siteId" v-for="site in menu.siteList">
              <site-card :site="site" style="height: 90px"></site-card>
            </el-col>
          </el-row>
        </div>
      </div>
    </front-home>
</template>

<script>
  import { Navbar, Sidebar } from './components'
  import Search from "@/components/Search";
  import SiteCard from "@/components/SiteCard/SiteCard";
  import FooterBottom from '@/components/FooterBottom'
  import FrontHome from './FrontHome';

  import { mapState } from 'vuex'
  import ResizeMixin from './mixin/ResizeHandler'
  import {getFrontNav,searchSite} from '@/api/front/frontNav'

  export default {
    name: 'home',
    props: {
      siteName: {
        type: String,
        default: undefined
      }
    },
    components: {
      Navbar,
      Sidebar,
      Search,
      SiteCard,
      FooterBottom,
      FrontHome
    },
    data() {
      return {
        menuList: [],
        siteList: [],
        loading: true,
        // 搜索对话框
        searchOpenDialog: false,
        // 添加网站
        addSite: {},
      }
    },
    created() {
      if (this.siteName != undefined && this.siteName != '') {
        this.getSearchSite(this.siteName);
      } else {
        this.getFrontNav();
      }
      this.tip();
    },
    mixins: [ResizeMixin],
    computed: {
      ...mapState({
        sidebar: state => state.app.sidebar,
        device: state => state.app.device,
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
      drawerBgHeight() {
        return this.$refs.mainContainer.offsetHeight + 'px';
      },
      fixedHeader() {
        return this.$store.state.settings.fixedHeader
      },
    },
    methods: {
      handleClickOutside() {
        this.$store.dispatch('app/closeSideBar', { withoutAnimation: false })
      },
      //查询菜单
      getFrontNav() {
        getFrontNav().then(response => {
          if (response.code == 200) {
            this.menuList = response.menus;
            this.siteList = response.sites;
            this.loading = false;
          }
        })
      },
      //搜索站内
      getSearchSite(siteName){
        searchSite(siteName).then(response => {
          if (response.code == 200) {
            this.menuList = response.menus;
            this.siteList = response.sites;
          }
          this.loading = false;
        }).catch(error => {
          this.loading = false;
        })
      },
      // 小提示
      tip() {
        this.$notify.info({
          title: '小提示',
          message: '如果喜欢本站可以设置为主页，这是对我最大的支持！'
        })

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
      /*position: fixed;*/
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

  .app-container {
    padding: 20px 20px 0px 20px;
  }

  .main-container-fixed-header {
    padding-top: 50px;
  }

</style>
