<template>
  <div class="app-container">
    <div>当前角色：{{ role.roleName }}（{{ role.roleCode }}）</div>
    <el-divider />
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
          v-permission="['system:role:addAuthUser']"
          >授权用户</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['system:user:deleteAuthUser']"
          >取消授权</el-button
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
        width="100"
        class-name="small-padding fixed-width"
      >
        <template #default="{ row }">
          <el-button
            type="text"
            icon="CircleClose"
            @click="handleDelete(row)"
            v-permission="['system:user:deleteAuthUser']"
            >取消授权</el-button
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

    <!-- 选择授权用户 -->
    <select-auth-user
      @fetch-data="handleQuery"
      ref="selectAuthUserRef"
    ></select-auth-user>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'
import { useRouter } from 'vue-router'

import SelectAuthUser from './components/SelectAuthUser'

import { getById, userAuthPage, removeAuthUser } from '@/api/system/role'

const router = useRouter()

const { proxy } = getCurrentInstance()

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  username: undefined,
  nickName: undefined,
  status: undefined,
  userType: undefined,
  roleId: router.currentRoute.value.params.id
})

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const ids = ref([])
const multiple = ref(true)
const role = ref({})

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
  } = await userAuthPage(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
}

/**
 * 获取角色信息
 */
async function getRole() {
  const { data } = await getById(queryParams.value.roleId)
  role.value = data
}

/**
 * 选择条数
 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.id)
  multiple.value = !selection.length
}

/**
 * 添加授权用户
 */
function handleAdd() {
  proxy.$refs.selectAuthUserRef.show(queryParams.value.roleId)
}

/**
 * 删除按钮操作
 */
async function handleDelete(row) {
  let deleteIds = []
  if (row.id) {
    deleteIds.push(row.id)
  } else {
    deleteIds = ids.value
  }
  proxy.$modal
    .confirm('是否确认取消授权用户编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await removeAuthUser({
        roleId: queryParams.value.roleId,
        userIds: deleteIds
      })
      proxy.$modal.msgSuccess('取消授权用户成功')
      handleQuery()
    })
}

/**
 * 初始化
 */
getPage()
getRole()
</script>
