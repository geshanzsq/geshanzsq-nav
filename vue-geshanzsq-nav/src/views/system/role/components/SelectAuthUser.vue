<template>
  <el-dialog
    v-model="visible"
    title="选择分配用户"
    width="70%"
    append-to-body
    :before-close="close"
  >
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
    </el-table>

    <pagination
      v-show="totalCount > 0"
      :total="totalCount"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getPage"
    />

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="close">取 消</el-button>
        <el-button type="primary" @click="handleSave">确 定</el-button>
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import { userUnAuthPage, authUser } from '@/api/system/role'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  username: undefined,
  nickName: undefined,
  status: undefined,
  userType: undefined,
  roleId: undefined
})

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const ids = ref([])

/**
 * 显示弹窗
 */
async function show(roleId) {
  visible.value = true
  queryParams.value.roleId = roleId
  handleQuery()
}

/**
 * 搜索
 */
async function handleQuery() {
  getPage()
}

/**
 * 分页
 */
async function getPage() {
  loading.value = true
  const {
    data: { total, list }
  } = await userUnAuthPage(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
}

/**
 * 保存
 */
const emit = defineEmits(null)
async function handleSave() {
  if (ids.value.length === 0) {
    close()
    return
  }
  // 保存
  const form = {
    roleId: queryParams.value.roleId,
    userIds: ids.value
  }
  await authUser(form)
  proxy.$modal.msgSuccess('授权用户成功')
  emit('fetch-data')
  close()
}

/**
 * 关闭
 */
function close() {
  visible.value = false
}

/**
 * 选择条数
 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.id)
}

defineExpose({
  show
})
</script>
