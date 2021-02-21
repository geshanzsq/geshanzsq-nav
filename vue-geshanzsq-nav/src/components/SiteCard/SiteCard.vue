<template>
  <el-card shadow="hover" class="site-card"
           @click.native="handleCard(site.siteUrl)"
           @mouseenter.native="siteCardEnter($event)"
           @mouseleave.native="siteCardLeave($event)">
    <el-container>
      <slot name="card-header"></slot>
      <el-aside class="card-site-aside" style="background-color: white;width: 40px;padding: 0;text-align: center;">
        <el-image class="aside-image"  :src="baseUrl + site.sitePath" lazy>
          <div slot="error" class="image-slot">
            <el-image class="aside-image" :src="baseUrl + defaultSiteImg"/>
          </div>
        </el-image>
      </el-aside>
      <el-main style="padding: 0;margin-left: 5px" >
        <a class="site-card-site-title" :class="site.siteDescription != '' ? '' : 'site-card-site-no-description'" ><strong>{{site.siteName}}</strong></a>
        <p class="site-card-site-description" v-if="site.siteDescription != ''">{{site.siteDescription}}</p>
      </el-main>
      <slot name="container-footer"></slot>
    </el-container>
    <slot name="card-footer"></slot>
  </el-card>
</template>

<script>

  export default {
    name: "SiteCard",
    props: {
      site: {
        type: Object,
        default: {}
      },
      height: {
        type: Number,
        default: 0
      },
      changeTitleColor: {
        type: Boolean,
        default: true
      },
      openSite: {
        type: Boolean,
        default: true
      }
    },
    data() {
      return {
        // 图片基本地址
        baseUrl: process.env.VUE_APP_BASE_FILE,
        // 默认图片
        defaultSiteImg: '/profile/site/system/logo.jpg',

      }
    },
    methods: {
      // 点击网站时，打开事件
      handleCard(url) {
        window.open(url, "_blank");
      },
      siteCardEnter(event) {
        if (!this.changeTitleColor) {
          return;
        }
        event.target.parentElement.querySelector(".site-card-site-title").style.cssText += "color: #4384f5"
      },
      siteCardLeave(event) {
        if (!this.changeTitleColor) {
          return;
        }
        event.target.parentElement.querySelector(".site-card-site-title").style.cssText += "color: #373e4a"
      }

    }
  }
</script>

<style scoped lang="scss">
  .site-card {
    cursor: pointer;
    .aside-image {
      border-radius: 50%;
      width: 40px;
      height: 40px;
    }
    .site-card-site-title {
      display: -webkit-box;
      -webkit-box-orient: vertical;
      -webkit-line-clamp: 1;
      overflow: hidden;
      font-size: 15px;
      color: #373e4a;
    }
    .site-card-site-no-description {
      padding-top: 10px;
    }
    .site-card-site-description {
      display: -webkit-box;
      -webkit-box-orient: vertical;
      -webkit-line-clamp: 2;
      overflow: hidden;
      margin-top: 5px;
      font-size: 14px;
      color: #979898;
    }
  }

</style>
