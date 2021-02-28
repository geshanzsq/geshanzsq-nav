<template>
  <div :class="{'has-logo':showLogo}">
    <logo v-if="showLogo" :collapse="isCollapse" />

    <el-scrollbar :class="settings.sideTheme" wrap-class="scrollbar-wrapper">
      <el-menu
          :default-active="activeMenu"
          :collapse="isCollapse"
          :background-color="variables.menuBg"
          :text-color="variables.menuText"
          :unique-opened="true"
          :active-text-color="settings.theme"
          :collapse-transition="false"
          mode="vertical"
      >
        <sidebar-item
            v-for="(menu, index) in menuList"
            :menu="menu"
            :key="index"
            :menu-index="index + ''"
        />

        <router-link to="/about">
          <el-menu-item index="about">
            <item icon="heart" title="关于本站"/>
          </el-menu-item>
        </router-link>
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import { mapGetters, mapState } from "vuex";
import variables from "@/assets/styles/variables.scss";

import Logo from "./Logo";
import SidebarItem from "./SidebarItem";
import Item from "./Item";

export default {
  components: { SidebarItem, Logo,Item },
  props: {
    menuList: {
      type: Array,
      default: []
    }
  },
  computed: {
    ...mapState(["settings"]),
    ...mapGetters(["permission_routes", "sidebar"]),
    activeMenu() {
      const route = this.$route;
      const { meta, path } = route;
      // if set path, the sidebar will highlight the path you set
      if (meta.activeMenu) {
        return meta.activeMenu;
      }
      return path;
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo;
    },
    variables() {
      return variables;
    },
    isCollapse() {
      return !this.sidebar.opened;
    }
  }
};
</script>
