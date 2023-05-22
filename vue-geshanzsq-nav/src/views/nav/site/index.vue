<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="名称描述" prop="siteNameDescription">
        <el-input
          v-model="queryParams.siteNameDescription"
          placeholder="请输入网站名称或描述"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所属分类" prop="categoryId">
        <el-tree-select
          v-model="queryParams.categoryId"
          :data="categoryTree"
          :props="{ value: 'id', label: 'categoryName', children: 'children' }"
          value-key="id"
          placeholder="选择所属分类"
          @change="handleQuery"
          filterable
          clearable
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="网站状态"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="commonStatus" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery"
          >搜索</el-button
        >
        <el-button icon="Refresh" @click="handleResetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="Plus"
          @click="handleAdd"
          v-permission="['system:user:add']"
          >新增</el-button
        >
      </el-col>
    </el-row>

    <div v-loading="loading">
      <el-row :gutter="24">
        <el-col
          :sm="24 / showCount"
          :sx="24"
          class="site-card-col"
          v-for="site in dataList"
          :key="site.id"
          @mouseenter="handleSiteCardMouseEnter(site.id)"
          @mouseleave="handleSiteCardMouseLeave"
        >
          <div v-show="isMouseSite(site.id)">
            <el-icon class="site-card-edit" @click="handleUpdate(site)">
              <Edit />
            </el-icon>
            <el-icon class="site-card-close" @click="handleDelete(site)">
              <Close />
            </el-icon>
          </div>
          <div :class="isMouseSite(site.id) ? 'site-card-mouse' : ''">
            <site-card :site="site" class="site-card">
              <template #card-footer>
                <span class="card-footer-icon">
                  <el-icon><View /></el-icon>
                  <span class="title">{{ site.clickCount }}</span>
                </span>
                <span class="card-footer-icon">
                  <el-icon><Sort /></el-icon>
                  <span class="title">{{ site.sort }}</span>
                </span>
                <div class="belong-category">
                  所属分类：{{ site.categoryName }}
                </div>
                <div class="site-card-status-disable" v-if="site.status === 2">
                  停 用
                </div>
              </template>
            </site-card>
          </div>
        </el-col>
      </el-row>
    </div>

    <el-empty v-if="totalCount == 0" description="暂无数据" />

    <pagination
      v-show="totalCount > 0"
      :total="totalCount"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getPage"
      :page-sizes="[8, 12, 16, 20]"
    />

    <!-- 新增和编辑 -->
    <site-edit @fetch-data="handleQuery" ref="editRef"></site-edit>
  </div>
</template>
<script setup>
import { computed, getCurrentInstance, ref } from 'vue'
import { useStore } from 'vuex'

import { page, remove } from '@/api/nav/site'
import { tree } from '@/api/nav/category'

import SiteEdit from './components/SiteEdit'
import SiteCard from '@/components/SiteCard'

const { proxy } = getCurrentInstance()
const store = useStore()

const queryParams = ref({
  pageNum: 1,
  pageSize: 8,
  categoryId: undefined,
  siteNameDescription: undefined,
  status: undefined,
  orderColumn: 'categoryId,sort,id',
  orderType: 'asc,asc,asc'
})
const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const categoryTree = ref([])
const id = ref()
const showCount = computed(() => store.getters['settings/showCount'])

/**
 * 搜索
 */
function handleQuery() {
  getPage()
}

/**
 * 重置
 */
function handleResetQuery() {
  proxy.resetForm('queryFormRef')
  handleQuery()
}

/**
 * 获取数据
 */
async function getPage() {
  loading.value = true
  const {
    data: { total, list }
  } = await page(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
}

/**
 * 获取分类树
 */
async function getCategoryTree() {
  const { data } = await tree()
  categoryTree.value = data
}

/**
 * 鼠标放入网站中
 */
function handleSiteCardMouseEnter(siteId) {
  id.value = siteId
}

/**
 * 鼠标离开网站中
 */
function handleSiteCardMouseLeave() {
  id.value = undefined
}

/**
 * 鼠标是否在当前网站
 */
function isMouseSite(siteId) {
  return id.value === siteId
}

/**
 * 新增
 */
function handleAdd(row) {
  proxy.$refs.editRef.show(undefined, queryParams.value.categoryId)
}

/**
 * 修改
 */
function handleUpdate(row) {
  proxy.$refs.editRef.show(row.id, queryParams.value.categoryId)
}

/**
 * 删除
 */
async function handleDelete(row) {
  proxy.$modal
    .confirm('是否确认删除网站名称为【' + row.siteName + '】的数据项？')
    .then(async function () {
      await remove(row.id)
      proxy.$modal.msgSuccess('删除网站成功')
      handleQuery()
    })
}

getPage()
getCategoryTree()
</script>
