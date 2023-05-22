<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="接口分类" prop="apiCategoryId">
        <el-select
          style="width: 240px"
          v-model="queryParams.apiCategoryId"
          placeholder="所属分类"
          @change="handleQuery"
        >
          <el-option
            v-for="(category, index) in dataCategoryList"
            :key="index"
            :label="category.categoryName"
            :value="category.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="接口名称" prop="apiName">
        <el-input
          v-model="queryParams.apiName"
          placeholder="请输入接口名称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接口地址" prop="apiUrl">
        <el-input
          v-model="queryParams.apiUrl"
          placeholder="请输入接口地址"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="请求方式" prop="apiMethod">
        <el-select
          v-model="queryParams.apiMethod"
          placeholder="请求方式"
          @change="handleQuery"
          style="width: 240px"
          clearable
        >
          <dictionary-option code="apiRequestMethod" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          style="width: 240px"
          v-model="queryParams.status"
          placeholder="分类状态"
          @change="handleQuery"
          clearable
        >
          <dictionary-option code="commonStatus" /> </el-select
      ></el-form-item>
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
          v-permission="['system:api:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-permission="['system:api:update']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['system:api:delete']"
          >删除</el-button
        >
      </el-col>
    </el-row>

    <el-table
      border
      v-loading="loading"
      :data="dataList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="接口编号" prop="id" width="180" align="center" />
      <el-table-column
        label="接口名称"
        prop="apiName"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="接口地址"
        prop="apiUrl"
        :show-overflow-tooltip="true"
      />
      <el-table-column label="请求方式" prop="apiMethod" width="100">
        <template #default="{ row }">
          <dictionary-tag
            code="apiRequestMethod"
            :value="row.apiMethod"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="显示顺序"
        prop="sort"
        width="100"
        align="center"
      />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="{ row }">
          <dictionary-tag
            code="commonStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column
        label="创建时间"
        align="center"
        prop="gmtCreate"
        width="160"
      >
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtCreate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        width="160"
      >
        <template #default="{ row }">
          <el-button
            type="text"
            icon="Edit"
            @click="handleUpdate(row)"
            v-permission="['system:api:update']"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['system:api:delete']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="totalCount > 0"
      :total="totalCount"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getPage"
    />

    <!-- 新增和编辑 -->
    <edit @fetch-data="handleQuery" ref="editRef"></edit>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import Edit from './components/ApiEdit'

import { page, remove } from '@/api/system/api/api'
import { list as listCategory } from '@/api/system/api/category'

import { useRouter } from 'vue-router'

const { proxy } = getCurrentInstance()

const router = useRouter()

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const dataCategoryList = ref([])
const ids = ref([])
const single = ref(true)
const multiple = ref(true)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  apiCategoryId: router.currentRoute.value.params.id,
  apiName: undefined,
  status: undefined
})

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
 * 获取分类列表
 */
async function getCategoryList() {
  const { data } = await listCategory()
  dataCategoryList.value = data
}

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
 * 选择条数
 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.id)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

/**
 * 新增
 */
function handleAdd() {
  const category = dataCategoryList.value.filter(
    (item) => queryParams.value.apiCategoryId === item.id
  )
  proxy.$refs.editRef.show(undefined, category[0])
}

/**
 * 修改
 */
function handleUpdate(row) {
  const id = row.id || ids.value
  const category = dataCategoryList.value.filter(
    (item) => queryParams.value.apiCategoryId === item.id
  )
  proxy.$refs.editRef.show(id, category[0])
}

/**
 * 删除按钮操作
 */
async function handleDelete(row) {
  const deleteIds = row.id || ids.value
  proxy.$modal
    .confirm('是否确认删除接口编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await remove(deleteIds)
      proxy.$modal.msgSuccess('删除接口成功')
      handleQuery()
    })
}

/**
 * 初始化
 */
getPage()
getCategoryList()
</script>
