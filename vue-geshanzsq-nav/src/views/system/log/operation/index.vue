<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="模块名称" prop="moduleName">
        <el-input
          v-model="queryParams.moduleName"
          placeholder="请输入模块名称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="IP 地址" prop="ipAddress">
        <el-input
          v-model="queryParams.ipAddress"
          placeholder="请输入 IP 地址"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="操作用户" prop="operateUser">
        <el-input
          v-model="queryParams.operateUser"
          placeholder="请输入用户名或昵称"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="业务类型" prop="businessType">
        <el-select
          v-model="queryParams.businessType"
          placeholder="业务类型"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="logOperationBusinessType" />
        </el-select>
      </el-form-item>
      <el-form-item label="操作类型" prop="operateType">
        <el-select
          v-model="queryParams.operateType"
          placeholder="操作类型"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="logOperationType" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="操作状态"
          @change="handleQuery"
          clearable
          style="width: 240px"
        >
          <dictionary-option code="logOperationStatus" />
        </el-select>
      </el-form-item>
      <el-form-item label="操作时间" style="width: 308px">
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
        label="模块名称"
        prop="moduleName"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="业务类型"
        prop="businessType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="logOperationBusinessType"
            :value="row.businessType"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="操作类型"
        prop="operateType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="logOperationType"
            :value="row.operateType"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作用户" :show-overflow-tooltip="true">
        <template #default="{ row }">
          <span>{{ row.nickName }}({{ row.username }})</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作 IP 地址"
        prop="ipAddress"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="操作位置"
        prop="operateLocation"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="状态"
        align="center"
        prop="status"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="logOperationStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作时间" align="center" width="160">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtOperate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        width="220"
      >
        <template #default="{ row }">
          <el-button type="text" icon="View" @click="handleDetail(row)"
            >详情</el-button
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

    <!-- 详情 -->
    <detail @fetch-data="handleQuery" ref="detailRef"></detail>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import { page } from '@/api/system/log/operation'

import detail from './components/LogOperationDetail'

const { proxy } = getCurrentInstance()

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  operateUser: undefined,
  ipAddress: undefined,
  status: undefined,
  beginGmtOperate: undefined,
  endGmtOperate: undefined
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
  queryParams.value.beginGmtOperate = undefined
  queryParams.value.endGmtOperate = undefined
  if (Array.isArray(dateRange.value) && dateRange.value.length === 2) {
    queryParams.value.beginGmtOperate = dateRange.value[0] + ' 00:00:00'
    queryParams.value.endGmtOperate = dateRange.value[1] + ' 23:59:59'
  }
  const {
    data: { total, list }
  } = await page(queryParams.value)
  totalCount.value = parseInt(total)
  dataList.value = list
  loading.value = false
}
/**
 * 详情
 */
function handleDetail(row) {
  proxy.$refs.detailRef.show(row.id)
}

/**
 * 初始化
 */
getPage()
</script>
