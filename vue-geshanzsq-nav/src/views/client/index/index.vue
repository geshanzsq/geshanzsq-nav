<template>
  <Client :categories="categoryList">
    <template #app-main>
      <div class="app-container">
        <el-row :gutter="24" type="flex" justify="center" v-if="searchOpen">
          <el-col :sm="16" :sx="24">
            <search class="search" />
          </el-col>
        </el-row>
        <div v-loading="loading" element-loading-text="数据加载中，请稍等...">
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
                :sm="24 / showCount"
                :sx="24"
                class="mb15"
                v-for="site in categorySite.sites"
                :key="site.id"
              >
                <site-card :site="site" :disabled-tip="false" />
              </el-col>
            </el-row>
          </div>
        </div>
      </div>
    </template>
  </Client>
</template>
<script setup>
import { ref, computed } from 'vue'
import { useStore } from 'vuex'

import Client from '@/layout/client'
import SiteCard from '@/components/SiteCard'
import Search from '@/layout/client/components/Search'

import { categorySiteList } from '@/api/client/nav'

const store = useStore()

const searchOpen = computed(() => store.getters['settings/searchOpen'])
const showCount = computed(() => store.getters['settings/showCount'])

const loading = ref(true)
const categoryList = ref([])
const siteList = ref([])

/**
 * 获取数据
 */
async function getData() {
  loading.value = true
  const {
    data: { categories, sites }
  } = await categorySiteList()
  categoryList.value = categories

  siteList.value = sites
  loading.value = false
}

getData()
</script>
