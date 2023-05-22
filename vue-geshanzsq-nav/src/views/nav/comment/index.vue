<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="评论内容" prop="commentContent">
        <el-input
          v-model="queryParams.commentContent"
          placeholder="请输入评论内容"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          style="width: 240px"
          v-model="queryParams.status"
          placeholder="请选择状态"
          @change="handleQuery"
          clearable
        >
          <dictionary-option code="navCommentStatus" />
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
          icon="Check"
          @click="handlePass"
          v-permission="['nav:comment:pass']"
          >通过</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="Close"
          @click="handleReject"
          v-permission="['nav:comment:reject']"
          >驳回</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['nav:comment:delete']"
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
      <el-table-column label="评论编号" align="center" prop="id" width="180" />

      <el-table-column label="评论内容" prop="commentContent" />
      <el-table-column label="评论人">
        <template #default="{ row }">
          <span v-if="row.createUserId"
            >{{ row.nickName }}({{ row.username }})</span
          >
        </template>
      </el-table-column>
      <el-table-column label="昵称">
        <template #default="{ row }">
          <span v-if="!row.createUserId">{{ row.nickName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="邮箱" prop="email" />
      <el-table-column label="备注" prop="remark" />
      <el-table-column label="创建时间" align="center">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtCreate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" align="center">
        <template #default="{ row }">
          <span>{{ parseTime(row.gmtModify) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="状态"
        prop="status"
        width="100"
        align="center"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="navCommentStatus"
            :value="row.status"
          ></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="是否置顶"
        prop="hasSticky"
        width="100"
        align="center"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag code="yesNo" :value="row.hasSticky"></dictionary-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        class-name="small-padding fixed-width"
        width="200"
      >
        <template #default="{ row }">
          <el-button
            type="text"
            icon="Check"
            @click="handlePass(row)"
            v-permission="['nav:comment:pass']"
            >通过</el-button
          >
          <el-button
            type="text"
            icon="Close"
            @click="handleReject(row)"
            v-permission="['nav:comment:reject']"
            >驳回</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['nav:comment:delete']"
            >删除</el-button
          >
          <el-button
            type="text"
            icon="Top"
            @click="handleSticky(row)"
            v-permission="['nav:comment:sticky']"
            >置顶</el-button
          >
          <el-button
            type="text"
            icon="Bottom"
            @click="handleCancelSticky(row)"
            v-permission="['nav:comment:sticky:cancle']"
            >取消置顶</el-button
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

    <!-- 驳回 -->
    <comment-reject @fetch-data="handleQuery" ref="rejectRef" />
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import CommentReject from './components/CommentReject'

import { page, pass, sticky, cancleSticky, remove } from '@/api/nav/comment'

const { proxy } = getCurrentInstance()

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const ids = ref([])
const multiple = ref(true)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  commentContent: undefined,
  status: '1',
  orderColumn: 'hasSticky,gmtCreate,id',
  orderType: 'asc,desc,desc'
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
  multiple.value = !selection.length
}

/**
 * 通过
 */
async function handlePass(row) {
  const passIds = row.id || ids.value
  if (passIds.length === 0) {
    proxy.$modal.msgError('请选择需要通过的评论')
    return
  }
  await pass(passIds)
  proxy.$modal.msgSuccess('通过评论成功')
  handleQuery()
}

/**
 * 驳回
 */
async function handleReject(row) {
  let rejectIds = []
  if (row.id) {
    rejectIds.push(row.id)
  } else {
    rejectIds = ids.value
  }
  if (rejectIds.length === 0) {
    proxy.$modal.msgError('请选择需要驳回的评论')
    return
  }
  proxy.$refs.rejectRef.show(rejectIds)
}

/**
 * 置顶
 */
async function handleSticky(row) {
  await sticky(row.id)
  proxy.$modal.msgSuccess('置顶评论成功')
  handleQuery()
}

/**
 * 取消置顶
 */
async function handleCancelSticky(row) {
  await cancleSticky(row.id)
  proxy.$modal.msgSuccess('取消置顶评论成功')
  handleQuery()
}

/**
 * 删除按钮操作
 */
async function handleDelete(row) {
  const deleteIds = row.id || ids.value
  proxy.$modal
    .confirm('是否确认删除评论编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await remove(deleteIds)
      proxy.$modal.msgSuccess('删除评论成功')
      handleQuery()
    })
}

/**
 * 初始化
 */
getPage()
</script>
