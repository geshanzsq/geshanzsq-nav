<template>
  <div>
    <template v-if="!hasChild(menu)">
        <el-menu-item :index="menuIndex"
                      :class="{'submenu-title-noDropdown':!isNest}"
                      @click="handlePosition('item-' + menu.menuId.toString(),menu.menuName )">
          <item :icon="menuIndex.indexOf('-') <= 0 ? menu.menuIcon : ''" :title="menu.menuName"/>
        </el-menu-item>
    </template>

    <el-submenu v-else ref="subMenu" :index="menuIndex" popper-append-to-body>
      <template slot="title">
        <item :icon="menu.menuIcon" :title="menu.menuName" />
      </template>
      <sidebar-item
          v-for="(subMenu,index) in menu.children"
          :key="subMenu.menuId"
          :is-nest="true"
          :menu="subMenu"
          :menu-index="menuIndex + '-' + index"
          class="nest-menu"
      />
    </el-submenu>
  </div>
</template>

<script>

import Item from './Item'
import { mapState } from 'vuex'
export default {
  name: 'SidebarItem',
  components: { Item },
  props: {
    menu: {},
    menuIndex: {
      type: String,
      default: ''
    },
    isNest: {
      type: Boolean,
      default: false
    },

  },
  data() {
    return {
    }
  },
  computed: {
    ...mapState({
      device: state => state.app.device,
    }),
    isMobile() {
      return this.device === 'mobile';
    },
    isFixedHeader() {
      return this.$store.state.settings.fixedHeader
    }
  },
  methods: {
    // 是否有子目录
    hasChild(item) {
      return item.children.length > 0;
    },
    // 瞄点定位
    handlePosition(id,menuName) {
      let path = this.$route.path;
      let aboutPath = '/about'
      if (aboutPath === path) {
        this.$router.push('/');
        return;
      }
      try {
        let e = document.querySelector('#' + id);
        //移动端
        if (this.isMobile) {
          if (this.isMobile) {
            this.$store.dispatch('app/closeSideBar', { withoutAnimation: false })
          }
          let top = e.offsetTop - 60;
          this.scrollTop(top, 80);
        } else if (!this.isFixedHeader) {
          //不是移动端，且头部不固定时，使用这个动画比较好
          e.scrollIntoView({behavior:'smooth' })
        } else {
          // 不是移动端并且固定时，
          let top = e.offsetTop - 60;
          this.scrollTop(top, 80);
        }
      } catch (e) {
        console.log(e);
        this.msgError('当前导航：' + menuName + '，未添加有网站信息，无法瞄点定位到此导航！');
      }

    },
    scrollTop(number, time) {
      if (!time) {
        document.body.scrollTop = document.documentElement.scrollTop = number;
        return number;
      }
      // 设置循环的间隔时间，值越小消耗性能越高
      const spacingTime = 20;
      // 计算循环的次数
      let spacingInex = time / spacingTime;
      // 获取当前滚动条位置
      let nowTop = document.body.scrollTop + document.documentElement.scrollTop;
      // 计算每次滑动的距离
      let everTop = (number - nowTop) / spacingInex;
      let scrollTimer = setInterval(() => {
        if (spacingInex > 0) {
          spacingInex--;
          this.scrollTop(nowTop += everTop);
        } else {
          // 清除计时器
          clearInterval(scrollTimer);
        }
      }, time);
    }

  }
}
</script>
