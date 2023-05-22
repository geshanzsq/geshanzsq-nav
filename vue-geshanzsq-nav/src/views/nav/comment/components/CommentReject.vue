<template>
  <el-dialog
    v-model="visible"
    title="驳回评论"
    width="600px"
    append-to-body
    :before-close="close"
  >
    <el-form :model="editForm" ref="editFormRef">
      <el-form-item prop="remark">
        <el-input
          v-model="editForm.remark"
          type="textarea"
          rows="3"
          placeholder="请输入驳回原因"
        ></el-input>
      </el-form-item>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="close">取 消</el-button>
        <el-button type="primary" @click="handleSave" :loading="editLoading"
          >确 定</el-button
        >
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import { reject } from '@/api/nav/comment'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const editLoading = ref(false)
const editForm = ref({
  ids: undefined,
  remark: undefined
})

/**
 * 显示弹窗
 */
async function show(ids) {
  visible.value = true
  editForm.value.ids = ids
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
      try {
        editLoading.value = true
        await reject(editForm.value)
        proxy.$modal.msgSuccess('驳回评论成功')
        emit('fetch-data')
        close()
      } finally {
        editLoading.value = false
      }
    }
  })
}

defineExpose({
  show
})
</script>
