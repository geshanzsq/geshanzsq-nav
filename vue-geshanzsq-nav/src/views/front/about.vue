<template>
  <el-container>
    <el-header>
      <h2 class="header-title">关于本站</h2>
    </el-header>
    <el-main style="background-color: #f9f9f9">
      <el-card :style="{width: (isMobile() ? '100%' : '80%'),margin:'auto'}">
        <div style="border-left: 5px solid #eee;padding: 9px 18px">
          <p>这是一个导航网站,收入了大部分常用的网站，希望能够解决到你频繁收藏网站的烦恼！</p>
          <p>显然，这是一个开源项目，主要放一些自己经常用到的网站。</p>
          开源项目来源：<el-link href="https://gitee.com/geshanzsq/geshanzsq-nav" target="_blank">https://gitee.com/geshanzsq/geshanzsq-nav</el-link>
        </div>

        <!-- 关于作者 -->
        <h4>关于作者</h4>
        <el-row :gutter="24">
          <el-col :sm="6" :sx="24">
            <a href="http://wpa.qq.com/msgrd?v=3&uin=497301391&site=qq&menu=yes" target="_blank">
            <el-card style="height: 80px">
              <el-container>
                <el-aside  style="background-color: white;width: 40px;padding: 0;text-align: center;">
                  <el-image style="border-radius: 20px;width: 40px;height: 40px" :src="require('@/assets/images/profile.jpg')" ></el-image>
                </el-aside>
                <el-main style="padding: 0;margin-left: 5px" >
                  <a style="font-size: 14px"><strong>小格子</strong></a>
                  <p style="font-size: 14px;color: #979898;margin-top: 5px">497301391@qq.com</p>
                </el-main>
              </el-container>
              <div>
              </div>
            </el-card>
            </a>
          </el-col>
          <el-col :sm="18" :sx="24">
            <div style="border-left: 5px solid #eee;padding: 9px 18px;color: #979898;">
              这个导航网站来源于格姗知识圈导航的开源项目。如果你有更好的想法，可以通过左边的 QQ 号与我联系。
              如果喜欢本站，可以分享给其他人，或者设置为主页，这是对我最大的支持！
            </div>
          </el-col>
        </el-row>
      </el-card>


    </el-main>
    <el-footer>
      <footer-bottom/>
    </el-footer>
  </el-container>
</template>

<script>
  import FooterBottom from '@/components/FooterBottom'
  import {isMobile} from "@/utils/geshanzsq";


  export default {
    name: "about",
    components: {FooterBottom},
    data() {
      return {
        // 图片基本地址
        baseUrl: process.env.VUE_APP_BASE_FILE,
      }
    },
    computed: {
      isMobile() {
        return isMobile;
      }
    }

  }
</script>

<style scoped>
  .header-title {
    color: #00a7eb;
  }
</style>
