<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="所属字典" prop="dictionaryId">
        <el-select
          style="width: 240px"
          v-model="queryParams.dictionaryId"
          placeholder="所属字典"
          @change="handleQuery"
        >
          <el-option
            v-for="(dictionary, index) in dataDictionaryList"
            :key="index"
            :label="dictionary.dictionaryName"
            :value="dictionary.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="字典标签" prop="dictionaryLabel">
        <el-input
          v-model="queryParams.dictionaryLabel"
          placeholder="请输入字典标签"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          style="width: 240px"
          v-model="queryParams.status"
          placeholder="字典数据状态"
          @change="handleQuery"
          clearable
        >
          <dictionary-option code="commonStatus" /></el-select
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
          v-permission="['system:dictionary:data:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-permission="['system:dictionary:data:update']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-permission="['system:dictionary:data:delete']"
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
      <el-table-column
        label="字典数据编号"
        prop="id"
        width="180"
        align="center"
      />
      <el-table-column
        label="字典标签"
        prop="dictionaryLabel"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="字典值"
        prop="dictionaryValue"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="样式类型"
        prop="classType"
        :show-overflow-tooltip="true"
      >
        <template #default="{ row }">
          <dictionary-tag
            code="dictionaryClassType"
            :value="row.classType"
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
            v-permission="['system:dictionary:data:update']"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="Delete"
            @click="handleDelete(row)"
            v-permission="['system:dictionary:data:delete']"
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

import Edit from './components/DictionaryDataEdit'

import { page, remove } from '@/api/system/dictionary/data'
import { list as listDictionary } from '@/api/system/dictionary/dictionary'

import { useRouter } from 'vue-router'

const { proxy } = getCurrentInstance()

const router = useRouter()

const loading = ref(true)
const dataList = ref([])
const totalCount = ref(0)
const dataDictionaryList = ref([])
const ids = ref([])
const single = ref(true)
const multiple = ref(true)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  dictionaryId: router.currentRoute.value.params.id,
  dictionaryName: undefined,
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
async function getDictionaryList() {
  const { data } = await listDictionary()
  dataDictionaryList.value = data
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
  const dictionary = dataDictionaryList.value.filter(
    (item) => queryParams.value.dictionaryId === item.id
  )
  proxy.$refs.editRef.show(undefined, dictionary[0])
}

/**
 * 修改
 */
function handleUpdate(row) {
  const id = row.id || ids.value
  const dictionary = dataDictionaryList.value.filter(
    (item) => queryParams.value.dictionaryId === item.id
  )
  proxy.$refs.editRef.show(id, dictionary[0])
}

/**
 * 删除按钮操作
 */
async function handleDelete(row) {
  const deleteIds = row.id || ids.value
  proxy.$modal
    .confirm('是否确认删除字典数据编号为【' + deleteIds + '】的数据项?')
    .then(async function () {
      await remove(deleteIds)
      proxy.$modal.msgSuccess('删除字典数据成功')
      handleQuery()
    })
}

/**
 * 初始化
 */
getPage()
getDictionaryList()
</script>
