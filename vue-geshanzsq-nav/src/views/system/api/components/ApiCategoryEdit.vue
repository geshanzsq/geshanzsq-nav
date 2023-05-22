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
      <el-form-item label="分类名称" prop="categoryName">
        <el-input
          v-model="editForm.categoryName"
          placeholder="请输入分类名称"
          @keyup.enter="handleSave"
        />
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

import { getById, add, update, getMaxSort } from '@/api/system/api/category'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const rules = ref({
  categoryName: [
    { required: true, message: '分类名称不能为空', trigger: 'blur' }
  ],
  sort: [{ required: true, message: '顺序不能为空', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }]
})
const editForm = ref({
  sort: 1,
  status: '1',
  menuIds: []
})

/**
 * 显示弹窗
 */
async function show(id) {
  visible.value = true
  if (id) {
    title.value = '修改分类'
    // 获取分类信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.status = editForm.value.status + ''
  } else {
    title.value = '新增分类'
    editForm.value.id = undefined
    const { data } = await getMaxSort()
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
        proxy.$modal.msgSuccess('修改分类成功')
      } else {
        // 新增
        await add(editForm.value)
        proxy.$modal.msgSuccess('新增分类成功')
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
