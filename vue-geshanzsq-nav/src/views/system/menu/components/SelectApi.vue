<template>
  <el-dialog
    v-model="visible"
    title="分配 API 接口数据"
    append-to-body
    width="70%"
    :before-close="close"
  >
    <div>
      <span>所选接口数据：</span>
      <span>
        <el-tag
          class="api-select-tag"
          v-for="api in apiMap"
          :key="api[0]"
          closable
          @close="handleCloseTag(api[0])"
          >{{ api[1].apiCategoryName }} - {{ api[1].apiName }}</el-tag
        >
      </span>
    </div>
    <el-tabs
      v-model="queryParams.apiCategoryId"
      @tab-change="handleApiCategory"
    >
      <el-tab-pane
        v-for="apiCategory in apiCategoryList"
        :key="apiCategory.id"
        :label="apiCategory.categoryName"
        :name="apiCategory.id"
      >
        <!-- 需使用 v-if，否则因为有缓存导致切换 tab 时无法显示已勾选的数据 -->
        <el-table
          v-if="queryParams.apiCategoryId === apiCategory.id"
          border
          ref="apiTableRef"
          v-loading="loading"
          :data="apiList"
          @select="handleSelection"
          @select-all="handleSelection"
        >
          <el-table-column type="selection" width="55" align="center" />
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
            label="状态"
            align="center"
            prop="status"
            width="100"
          >
            <template #default="{ row }">
              <dictionary-tag
                code="commonStatus"
                :value="row.status"
              ></dictionary-tag>
            </template>
          </el-table-column>
        </el-table>

        <pagination
          class="pagination"
          v-show="totalCount > 0"
          :total="totalCount"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getPage"
        />
      </el-tab-pane>
    </el-tabs>

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

import { list as listCateogry } from '@/api/system/api/category'
import { page } from '@/api/system/api/api'
import { authApiList, authApi } from '@/api/system/menu'

const { proxy } = getCurrentInstance()

const visible = ref(false)

const editForm = ref({
  menuId: undefined,
  apiIds: []
})
const loading = ref(true)
const apiCategoryList = ref([])
const apiMap = ref(new Map())

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  apiCategoryId: undefined
})
const apiCategoryName = ref('')
const totalCount = ref(0)
const apiList = ref([])

/**
 * 显示弹窗
 */
async function show(menuId) {
  visible.value = true
  apiMap.value = new Map()
  editForm.value.menuId = menuId
  const { data } = await listCateogry()
  apiCategoryList.value = data
  await getAuthApiList()
  if (apiCategoryList.value.length > 0) {
    queryParams.value.apiCategoryId = apiCategoryList.value[0].id
    // 获取接口列表数据
    await getApiCategoryData()
    // 设置选中列
    handleSelectRows()
  }
}

/**
 * 获取接口数据
 */
async function getAuthApiList() {
  const { data } = await authApiList({ menuId: editForm.value.menuId })
  if (data == null) {
    return
  }
  for (const api of data) {
    apiMap.value.set(api.apiId, api)
  }
}

/**
 * 点击分类
 */
async function handleApiCategory() {
  // 获取接口列表数据
  await getApiCategoryData()
  // 设置选中列
  handleSelectRows()
}

/**
 * 获取接口分类
 */
async function getApiCategoryData() {
  // 设置分类名称
  for (const acRow in apiCategoryList.value) {
    if (queryParams.value.apiCategoryId === apiCategoryList.value[acRow].id) {
      apiCategoryName.value = apiCategoryList.value[acRow].categoryName
      break
    }
  }
  loading.value = true
  const {
    data: { total, list }
  } = await page(queryParams.value)
  apiList.value = list
  totalCount.value = parseInt(total)
  loading.value = false
}

/**
 * 选择条数
 */
function handleSelection(rows) {
  // 当前接口数据是否在 rows 中，如果不在，说明需要删除
  for (const api in apiList.value) {
    const apiData = apiList.value[api]
    let hasExist = false
    for (const row in rows) {
      if (apiData.id === rows[row].id) {
        hasExist = true
        apiMap.value.set(apiData.id, {
          apiName: apiData.apiName,
          apiCategoryName: apiCategoryName.value
        })
        break
      }
    }
    // 不在，移除
    if (!hasExist) {
      apiMap.value.delete(apiData.id)
    }
  }
}

/**
 * 设置选中列
 */
function handleSelectRows() {
  apiMap.value.forEach((apiRow) => {
    for (const rowData of apiList.value) {
      if (rowData.id === apiRow.apiId) {
        proxy.$refs.apiTableRef[0].toggleRowSelection(rowData, true)
        break
      }
    }
  })
}

/**
 * 取消选择数据
 */
function handleCloseTag(id) {
  apiMap.value.delete(id)
}

/**
 * 提交数据
 */
const emit = defineEmits(null)
async function handleSave() {
  // 获取选择的 API
  editForm.value.apiIds = []
  for (const key of apiMap.value.keys()) {
    editForm.value.apiIds.push(key)
  }
  await authApi(editForm.value)
  proxy.$modal.msgSuccess('分配 API 成功')

  emit('fetch-data')
  close()
}

/**
 * 关闭
 */
function close() {
  visible.value = false
}

defineExpose({
  show
})
</script>
<style scoped>
.api-select-tag {
  margin: 5px;
}
.pagination {
  margin-bottom: 20px;
}
</style>
