<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="分类名称" prop="categoryName">
        <el-input
          v-model="queryParams.categoryName"
          placeholder="请输入接口分类名称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
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
          v-permission="['system:apiCategory:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-permission="['system:apiCategory:update']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['system:apiCategory:delete']"
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
      <el-table-column label="分类编号" prop="id" width="180" align="center" />
      <el-table-column
        label="分类名称"
        prop="categoryName"
        :show-overflow-tooltip="true"
        align="center"
      >
        <template #default="{ row }">
          <router-link :to="'/system/api/data/' + row.id" class="link-type">
            <span>{{ row.categoryName }}</span>
          </router-link>
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
            v-permission="['system:apiCategory:update']"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['system:apiCategory:delete']"
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

import Edit from './components/ApiCategoryEdit'

import { page, remove } from '@/api/system/api/category'

const { proxy } = getCurrentInstance()

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  categoryName: undefined,
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
  proxy.$refs.editRef.show(undefined)
}

/**
 * 修改
 */
function handleUpdate(row) {
  const id = row.id || ids.value
  proxy.$refs.editRef.show(id)
}

/**
 * 删除按钮操作
 */
async function handleDelete(row) {
  const deleteIds = row.id || ids.value
  proxy.$modal
    .confirm('是否确认删除分类编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await remove(deleteIds)
      proxy.$modal.msgSuccess('删除分类成功')
      handleQuery()
    })
}

/**
 * 初始化
 */
getPage()
</script>
