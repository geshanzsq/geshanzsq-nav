<template>
  <Client :categories="categories">
    <template #app-main>
      <div v-loading="loading" class="app-container about">
        <el-card class="card" :style="{ width: isMobile ? '100%' : '90%' }">
          <div
            v-highlight
            class="content"
            v-html="aboutConfig.aboutSiteContent"
          ></div>
          <!-- 关于站长 -->
          <h4>关于站长</h4>
          <el-row :gutter="24">
            <el-col :sm="6" :sx="24">
              <el-card class="author-card">
                <el-container>
                  <el-aside class="author-aside">
                    <el-image
                      class="about-author-avatar"
                      :src="
                        aboutConfig.avatar
                          ? getPictureShowUrl(aboutConfig.avatar)
                          : getPictureShowUrl(defaultSiteImage)
                      "
                    >
                      <template #error>
                        <el-image
                          class="about-author-avatar"
                          :src="getPictureShowUrl(defaultSiteImage)"
                        />
                      </template>
                    </el-image>
                  </el-aside>
                  <el-main class="author-main">
                    <a class="nick-name"
                      ><strong>{{ aboutConfig.nickName }}</strong></a
                    >
                    <p class="email">
                      {{ aboutConfig.aboutSiteEmail }}
                    </p>
                  </el-main>
                </el-container>
                <div></div>
              </el-card>
            </el-col>
            <el-col :sm="18" :sx="24">
              <div class="description">
                {{ aboutConfig.aboutSiteDescription }}
              </div>
            </el-col>
          </el-row>

          <!-- 评论 -->
          <Comment v-if="commentOpenStatus" />
        </el-card>
      </div>
    </template>
  </Client>
</template>
<script setup>
import { computed, ref } from 'vue'
import { useStore } from 'vuex'

import { categoryList } from '@/api/client/nav'
import { getAbout } from '@/api/nav/config'
import { getOpenStatus } from '@/api/client/comment'

import Client from '@/layout/client'
import Comment from './components/Comment'

const store = useStore()

const loading = ref(true)
const categories = ref([])
const aboutConfig = ref({
  aboutSiteContent: undefined
})
const commentOpenStatus = ref(false)
// 是否移动端
const isMobile = computed(() => store.getters['app/isMobile'])
// 默认图片
const defaultSiteImage = ref('/profile/site/system/logo.jpg')

/**
 * 获取分类
 */
async function getCategories() {
  const { data } = await categoryList()
  categories.value = data
}

/**
 * 获取最新收录网站
 */
async function getData() {
  loading.value = true
  const { data } = await getAbout()
  if (data) {
    aboutConfig.value = data
  }
  loading.value = false
}

/**
 * 获取评论开启状态
 */
async function getCommentOpenStatus() {
  const { data } = await getOpenStatus()
  commentOpenStatus.value = data
}

getCategories()
getData()
getCommentOpenStatus()
</script>
<style scoped lang="scss">
.about {
  .card {
    margin: auto;

    /*设置图片，以防过大*/
    .content >>> img {
      max-width: 100%;
      height: auto;
    }

    .author-card {
      height: 80px;
      .author-aside {
        background-color: white;
        width: 40px;
        padding: 0;
        text-align: center;

        .about-author-avatar {
          border-radius: 20px;
          width: 40px;
          height: 40px;
        }
      }
      .author-main {
        padding: 0;
        margin-left: 5px;

        .nick-name {
          font-size: 14px;
        }
        .email {
          font-size: 14px;
          color: #979898;
          margin-top: 5px;
        }
      }
    }
    .description {
      border-left: 5px solid #eee;
      padding: 9px 18px;
      color: #979898;
    }
  }
}
</style>
