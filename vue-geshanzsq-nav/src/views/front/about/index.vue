<template>
  <div style="padding: 0px">
    <front-home :menu-list="menuList">
      <div slot="mainContainer" style="padding: 20px 5px 0px 5px">
        <el-card :style="{width: (isMobile ? '100%' : '90%'),margin:'auto'}"
                 v-loading="loading"
                 element-loading-text="拼命加载中，请稍等..."
                 element-loading-spinner="el-icon-loading">
          <div>
            <div class="about-content"  v-highlight v-html="webConfig.aboutWebContent" ></div>
          </div>

          <!-- 关于作者 -->
          <h4>关于作者</h4>
          <el-row :gutter="24">
            <el-col :sm="6" :sx="24">
              <el-card style="height: 80px">
                <el-container>
                  <el-aside  style="background-color: white;width: 40px;padding: 0;text-align: center;">
                    <el-image class="about-author-avatar"  :src="baseUrl + webConfig.avatar" >
                      <div slot="error" class="image-slot">
                        <el-image class="about-author-avatar" :src="require('@/assets/images/profile.jpg')" ></el-image>
                      </div>
                    </el-image>
                  </el-aside>
                  <el-main style="padding: 0;margin-left: 5px" >
                    <a style="font-size: 14px"><strong>{{webConfig.nickName}}</strong></a>
                    <p style="font-size: 14px;color: #979898;margin-top: 5px">{{webConfig.aboutWebEmail}}</p>
                  </el-main>
                </el-container>
                <div>
                </div>
              </el-card>
            </el-col>
            <el-col :sm="18" :sx="24">
              <div style="border-left: 5px solid #eee;padding: 9px 18px;color: #979898;">{{webConfig.aboutWebDescription}}</div>
            </el-col>
          </el-row>

          <!-- 评论 -->
          <comment style="margin-top: 50px"/>
        </el-card>
      </div>
    </front-home>
  </div>
</template>

<script>
  import FooterBottom from '@/components/FooterBottom'
  import FrontHome from '@/views/front/FrontHome';
  import Comment from './components/Comment'

  import { getNavAbout, getFrontMenu } from '@/api/front/frontNav'

  import { mapState } from 'vuex'
  import ResizeMixin from '@/views/front/mixin/ResizeHandler'

  export default {
    name: "about",
    components: {FooterBottom,FrontHome,Comment},
    data() {
      return {
        menuList: [],
        loading: false,
        // 图片基本地址
        baseUrl: process.env.VUE_APP_BASE_FILE,
        webConfig: {},
      }
    },
    mixins: [ResizeMixin],
    computed: {
      ...mapState({
        device: state => state.app.device,
      }),
      isMobile() {
        return this.device === 'mobile';
      },
    },
    created() {
      this.getFrontMenu();
      this.getNavAbout();
    },
    methods: {
      //查询菜单
      getFrontMenu() {
        getFrontMenu().then(response => {
          this.menuList = response.menus;
        })
      },
      /** 获取关于本站内容 */
      getNavAbout() {
        this.loading = true;
        getNavAbout().then(response => {
          this.webConfig = response.data;
          this.loading = false;
        }).catch(error => {
          this.loading = false;
        })
      },
    }

  }
</script>

<style scoped>
  .about-author-avatar {
    border-radius: 20px;
    width: 40px;
    height: 40px
  }
  /*设置图片，以防过大*/
  .about-content >>> img {
    max-width: 100%;
    height: auto;
  }
</style>
