<template>
  <el-dialog
    v-model="visible"
    :title="title"
    width="600px"
    append-to-body
    :before-close="close"
  >
    <el-form
      :model="editForm"
      ref="editFormRef"
      label-width="80px"
      :rules="rules"
    >
      <el-form-item label="所属分类">
        <el-input v-model="apiCategoryName" disabled />
      </el-form-item>
      <el-form-item label="接口名称" prop="apiName">
        <el-input
          v-model="editForm.apiName"
          placeholder="请输入接口名称"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="接口地址" prop="apiUrl">
        <el-input
          v-model="editForm.apiUrl"
          placeholder="请输入接口地址"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="请求方式" prop="apiMethod">
        <el-select v-model="editForm.apiMethod" placeholder="请求方式">
          <dictionary-option code="apiRequestMethod" />
        </el-select>
      </el-form-item>
      <el-form-item label="顺序" prop="sort">
        <el-input-number
          v-model="editForm.sort"
          controls-position="right"
          :min="0"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-radio-group v-model="editForm.status">
          <dictionary-radio code="commonStatus" />
        </el-radio-group>
      </el-form-item>

      <el-form-item label="备注" prop="remark">
        <el-input
          v-model="editForm.remark"
          type="textarea"
          placeholder="请输入内容"
        ></el-input>
      </el-form-item>
    </el-form>

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

import {
  getById,
  add,
  update,
  getMaxSortByCategoryId
} from '@/api/system/api/api'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const rules = ref({
  apiName: [{ required: true, message: '接口名称不能为空', trigger: 'blur' }],
  apiUrl: [{ required: true, message: '接口地址不能为空', trigger: 'blur' }],
  apiMethod: [{ required: true, message: '请选择请求方式', trigger: 'blur' }],
  sort: [{ required: true, message: '顺序不能为空', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }]
})
const editForm = ref({
  sort: 1,
  status: '1',
  apiCategoryId: undefined,
  apiMethod: 'GET'
})
const apiCategoryName = ref('')

/**
 * 显示弹窗
 */
async function show(id, category) {
  visible.value = true
  editForm.value.apiCategoryId = category.id
  apiCategoryName.value = category.categoryName
  if (id) {
    title.value = '修改接口'
    // 获取接口信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.status = editForm.value.status + ''
  } else {
    title.value = '新增接口'
    editForm.value.id = undefined
    const { data } = await getMaxSortByCategoryId(editForm.value.apiCategoryId)
    editForm.value.sort = data ? data + 1 : 1
  }
}

/**
 * 关闭
 */
function close() {
  visible.value = false
  reset()
}

/**
 * 重置
 */
function reset() {
  proxy.resetForm('editFormRef')
}

/**
 * 提交数据
 */
const emit = defineEmits(null)
function handleSave() {
  proxy.$refs.editFormRef.validate(async (valid) => {
    if (valid) {
      // 修改
      if (editForm.value.id) {
        await update(editForm.value)
        proxy.$modal.msgSuccess('修改接口成功')
      } else {
        // 新增
        await add(editForm.value)
        proxy.$modal.msgSuccess('新增接口成功')
      }
      emit('fetch-data')
      close()
    }
  })
}

defineExpose({
  show
})
</script>
