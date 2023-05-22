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
      <el-form-item label="参数名称" prop="paramName">
        <el-input v-model="editForm.paramName" placeholder="请输入参数名称" />
      </el-form-item>
      <el-form-item label="参数键" prop="paramKey">
        <el-input v-model="editForm.paramKey" placeholder="请输入参数键" />
      </el-form-item>
      <el-form-item label="参数值" prop="paramValue">
        <el-input v-model="editForm.paramValue" placeholder="请输入参数值" />
      </el-form-item>
      <el-form-item label="参数顺序" prop="sort">
        <el-input-number
          v-model="editForm.sort"
          controls-position="right"
          :min="0"
        />
      </el-form-item>
      <el-form-item label="参数类型" prop="paramType">
        <el-radio-group v-model="editForm.paramType">
          <dictionary-radio code="sysParamType" />
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

import { getById, add, update, getMaxSort } from '@/api/system/param'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const rules = ref({
  paramName: [{ required: true, message: '参数名称不能为空', trigger: 'blur' }],
  paramKey: [{ required: true, message: '参数键不能为空', trigger: 'blur' }],
  paramValue: [{ required: true, message: '参数值不能为空', trigger: 'blur' }],
  sort: [{ required: true, message: '顺序不能为空', trigger: 'blur' }]
})
const editForm = ref({
  sort: 1,
  paramType: '1'
})

/**
 * 显示弹窗
 */
async function show(id) {
  visible.value = true
  if (id) {
    title.value = '修改参数'
    // 获取角色信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.paramType = editForm.value.paramType + ''
  } else {
    title.value = '新增参数'
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
        proxy.$modal.msgSuccess('修改参数成功')
      } else {
        // 新增
        await add(editForm.value)
        proxy.$modal.msgSuccess('新增参数成功')
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
