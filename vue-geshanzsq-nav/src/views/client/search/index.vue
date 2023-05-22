<template>
  <Client :categories="categoryList" class="app-container">
    <template #app-main>
      <el-row :gutter="24" type="flex" justify="center">
        <el-col :sm="16" :sx="24">
          <search class="search" />
        </el-col>
      </el-row>
      <div v-loading="loading">
        <div v-for="categorySite in siteList" :key="categorySite.id">
          <h4
            :id="'category-' + categorySite.id"
            :ref="'category-' + categorySite.id"
          >
            <svg-icon icon-name="tag" class="client-category-icon" />
            <span class="client-category-name">{{
              categorySite.categoryName
            }}</span>
          </h4>
          <el-row :gutter="24">
            <el-col
              :sm="6"
              :sx="24"
              class="mb15"
              v-for="site in categorySite.sites"
              :key="site.id"
            >
              <site-card :site="site" />
            </el-col>
          </el-row>
        </div>
      </div>
    </template>
  </Client>
</template>
<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

import Client from '@/layout/client'
import SiteCard from '@/components/SiteCard'
import Search from '@/layout/client/components/Search'

import { categorySiteList } from '@/api/client/search'

const router = useRouter()

const loading = ref(true)
const categoryList = ref([])
const siteList = ref([])
const searchContent = ref(router.currentRoute.value.params.searchContent)

/**
 * 获取数据
 */
async function getData() {
  loading.value = true
  const {
    data: { categories, sites }
  } = await categorySiteList(searchContent.value)
  categoryList.value = categories
  siteList.value = sites
  loading.value = false
}

getData()
</script>
