<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="用户名" prop="username">
        <el-input
          v-model="queryParams.username"
          placeholder="请输入用户名"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="昵称" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入用户昵称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="用户状态"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="commonStatus" />
        </el-select>
      </el-form-item>
      <el-form-item label="用户类型" prop="userType">
        <el-select
          v-model="queryParams.userType"
          placeholder="用户类型"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="systemUserType" />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间" style="width: 308px">
        <el-date-picker
          v-model="dateRange"
          value-format="YYYY-MM-DD"
          format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
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
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-permission="['system:user:update']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['system:user:delete']"
          >删除</el-button
        >
      </el-col>
    </el-row>

    <el-table
      v-loading="loading"
      :data="dataList"
      border
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="用户编号" align="center" prop="id" width="180" />
      <el-table-column
        label="用户名"
        prop="username"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="昵称"
        prop="nickName"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="用户角色"
        prop="roleNames"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="邮箱"
        prop="email"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="手机号码"
        align="center"
        prop="mobilePhone"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="性别"
        align="center"
        prop="sex"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="systemUserSex"
            :value="row.sex"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="用户类型"
        align="center"
        prop="userType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="systemUserType"
            :value="row.userType"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="用户状态"
        align="center"
        prop="userType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="commonStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" width="160">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtCreate) }}</span>
        </template>
      </el-table-column>

      <el-table-column
        label="操作"
        align="center"
        width="220"
        class-name="small-padding fixed-width"
      >
        <template #default="{ row }">
          <el-button
            type="text"
            icon="Edit"
            @click="handleUpdate(row)"
            v-permission="['system:user:update']"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['system:user:delete']"
            >删除</el-button
          >
          <el-button
            type="text"
            icon="Key"
            @click="handleResetPassword(row)"
            v-permission="['system:user:resetPassword']"
            >重置密码</el-button
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

    <!-- 重置密码 -->
    <reset-password ref="resetPasswordRef"></reset-password>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import Edit from './components/UserEdit'
import ResetPassword from './components/UserResetPassword'

import { page, remove } from '@/api/system/user'

const { proxy } = getCurrentInstance()

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  username: undefined,
  nickName: undefined,
  status: undefined,
  userType: undefined,
  beginGmtCreate: undefined,
  endGmtCreate: undefined
})

const loading = ref(true)
const dataList = ref([])
const dateRange = ref([])
const totalCount = ref(0)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)

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
  dateRange.value = undefined
  handleQuery()
}

/**
 * 获取数据
 */
async function getPage() {
  loading.value = true
  queryParams.value.beginGmtCreate = undefined
  queryParams.value.endGmtCreate = undefined
  if (Array.isArray(dateRange.value) && dateRange.value.length === 2) {
    queryParams.value.beginGmtCreate = dateRange.value[0] + ' 00:00:00'
    queryParams.value.endGmtCreate = dateRange.value[1] + ' 23:59:59'
  }
  const {
    data: { total, list }
  } = await page(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
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
    .confirm('是否确认删除用户编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await remove(deleteIds)
      proxy.$modal.msgSuccess('删除用户成功')
      handleQuery()
    })
}

/**
 * 重置密码
 */
function handleResetPassword(row) {
  proxy.$refs.resetPasswordRef.show(row)
}

/**
 * 初始化
 */
getPage()
</script>
