<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="IP 地址" prop="ipAddress">
        <el-input
          v-model="queryParams.ipAddress"
          placeholder="请输入 IP 地址"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户名" prop="username">
        <el-input
          v-model="queryParams.username"
          placeholder="请输入用户名"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>

      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="登录状态"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="logLoginStatus" />
        </el-select>
      </el-form-item>
      <el-form-item label="登录时间" style="width: 308px">
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

    <el-table
      v-loading="loading"
      :data="dataList"
      border
      @selection-change="handleSelectionChange"
    >
      <el-table-column label="日志编号" align="center" prop="id" width="180" />
      <el-table-column
        label="用户名"
        prop="username"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="登录 IP 地址"
        prop="ipAddress"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="登录位置"
        prop="loginLocation"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="操作系统"
        prop="operateSystem"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="浏览器"
        prop="browserType"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="登录状态"
        align="center"
        prop="userType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="logLoginStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="提示消息"
        prop="hintMessage"
        :show-overflow-tooltip="true"
      />

      <el-table-column label="登录时间" align="center" width="160">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtLogin) }}</span>
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
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import { page } from '@/api/system/log/login'

const { proxy } = getCurrentInstance()

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  username: undefined,
  ipAddress: undefined,
  status: undefined,
  beginGmtLogin: undefined,
  endGmtLogin: undefined,
  orderColumn: 'gmtLogin,id',
  orderType: 'desc,desc'
})

const loading = ref(true)
const dataList = ref([])
const dateRange = ref([])
const totalCount = ref(0)

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
  queryParams.value.beginGmtLogin = undefined
  queryParams.value.endGmtLogin = undefined
  if (Array.isArray(dateRange.value) && dateRange.value.length === 2) {
    queryParams.value.beginGmtLogin = dateRange.value[0] + ' 00:00:00'
    queryParams.value.endGmtLogin = dateRange.value[1] + ' 23:59:59'
  }
  const {
    data: { total, list }
  } = await page(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
}

/**
 * 初始化
 */
getPage()
</script>
