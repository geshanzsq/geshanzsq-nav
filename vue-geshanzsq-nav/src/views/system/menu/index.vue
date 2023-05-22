<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="菜单名称" prop="menuName">
        <el-input
          v-model="queryParams.menuName"
          placeholder="请输入菜单名称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="菜单状态"
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

    <el-row class="mb8">
      <el-col>
        <el-button
          type="primary"
          icon="Plus"
          @click="handleAdd"
          v-permission="['system:menu:add']"
          >新增</el-button
        >
      </el-col>
    </el-row>

    <el-table
      border
      v-loading="loading"
      :data="dataList"
      row-key="id"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column
        prop="menuName"
        label="菜单名称"
        :show-overflow-tooltip="true"
        width="160"
      ></el-table-column>
      <el-table-column prop="menuIcon" label="图标" align="center" width="100">
        <template #default="{ row }">
          <svg-icon :icon-name="row.menuIcon" />
        </template>
      </el-table-column>
      <el-table-column
        prop="sort"
        label="排序"
        width="60"
        align="center"
      ></el-table-column>
      <el-table-column
        prop="permissionCode"
        label="权限标识"
        :show-overflow-tooltip="true"
      ></el-table-column>
      <el-table-column
        prop="componentPath"
        label="组件路径"
        :show-overflow-tooltip="true"
      ></el-table-column>
      <el-table-column prop="status" label="状态" width="80" align="center">
        <template #default="{ row }">
          <dictionary-tag
            code="commonStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="gmtCreate">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtCreate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        width="300"
        class-name="small-padding fixed-width"
      >
        <template #default="{ row }">
          <el-button
            type="text"
            icon="Edit"
            @click="handleUpdate(row)"
            v-permission="['system:menu:update']"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="Plus"
            @click="handleAdd(row)"
            v-permission="['system:menu:add']"
            >新增</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['system:menu:delete']"
            >删除</el-button
          >
          <el-button
            type="text"
            icon="Document"
            @click="handleSelectApi(row)"
            v-permission="['system:menu:allocateApi']"
            v-if="'D' !== row.menuType && row.hasPermission !== 2"
            >分配 API</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增和编辑 -->
    <edit @fetch-data="handleQuery" ref="editRef"></edit>

    <!-- 分配 API -->
    <SelectApi ref="selectApiRef" />
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import Edit from './components/MenuEdit'
import SelectApi from './components/SelectApi'

import { list, remove } from '@/api/system/menu'

const { proxy } = getCurrentInstance()

const queryParams = ref({
  menuName: undefined,
  status: undefined
})

const loading = ref(true)
const dataList = ref([])

/**
 * 获取菜单树
 */
async function getTree() {
  loading.value = true
  const { data } = await list(queryParams.value)
  dataList.value = proxy.handleTree(data)
  loading.value = false
}

/**
 * 搜索
 */
function handleQuery() {
  getTree()
}

/**
 * 重置
 */
function handleResetQuery() {
  proxy.resetForm('queryFormRef')
  handleQuery()
}

/**
 * 新增
 */
function handleAdd(row) {
  const parentId = row ? row.id : undefined
  proxy.$refs.editRef.show(undefined, parentId)
}

/**
 * 修改
 */
function handleUpdate(row) {
  proxy.$refs.editRef.show(row.id, row.id)
}

/**
 * 删除
 */
async function handleDelete(row) {
  proxy.$modal
    .confirm('是否确认删除名称为【' + row.menuName + '】的数据项?')
    .then(async function () {
      await remove(row.id)
      proxy.$modal.msgSuccess('删除菜单成功')
      handleQuery()
    })
}

/**
 * 分配 Api
 */
function handleSelectApi(row) {
  proxy.$refs.selectApiRef.show(row.id, row.id)
}

/**
 * 初始化
 */
getTree()
</script>
