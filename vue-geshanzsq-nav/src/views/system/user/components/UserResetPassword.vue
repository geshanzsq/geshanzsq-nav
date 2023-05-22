<template>
  <el-dialog
    v-model="visible"
    title="提示"
    width="400px"
    append-to-body
    :before-close="close"
  >
    <div class="mb8">请输入 {{ username }} 的新密码</div>
    <el-form :model="editForm" ref="editFormRef" :rules="rules">
      <el-form-item prop="password">
        <el-input
          :type="passwordType"
          v-model="editForm.password"
          placeholder="请输入密码"
        >
        </el-input>
        <span class="show-password" @click="handleShowPassword">
          <svg-icon
            :icon-name="passwordType === 'password' ? 'eye' : 'eye-open'"
          />
        </span>
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

import { resetPassword } from '@/api/system/user'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const username = ref('')
const editForm = ref({
  id: undefined,
  password: undefined
})

const rules = ref({
  password: [{ required: true, message: '密码不能为空', trigger: 'blur' }]
})

/**
 * 显示弹窗
 */
function show(row) {
  visible.value = true
  editForm.value.id = row.id
  username.value = row.username
}

/**
 * 提交数据
 */
async function handleSave() {
  proxy.$refs.editFormRef.validate(async (valid) => {
    if (valid) {
      await resetPassword(editForm.value)
      proxy.$modal.msgSuccess('修改密码成功')
      close()
    }
  })
}

// 密码类型
const passwordType = ref('password')
/**
 * 是否显示密码
 */
function handleShowPassword() {
  passwordType.value = passwordType.value === 'password' ? 'text' : 'password'
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

defineExpose({
  show
})
</script>

<style scoped>
.show-password {
  height: 39px;
  width: 14px;
  top: 0px;
  position: absolute;
  right: 10px;
  font-size: 16px;
  color: #889aa4;
  cursor: pointer;
  user-select: none;
}
</style>
