<template>
  <el-card>
    <template #header>
      <div>
        <span>基本资料</span>
      </div>
    </template>
    <el-tabs v-model="activeTab">
      <el-tab-pane label="基本资料" name="updateUser">
        <el-form
          :model="editForm"
          ref="editFormRef"
          label-width="80px"
          :rules="rules"
        >
          <el-form-item label="用户名" prop="username">
            <el-input
              v-model="editForm.username"
              placeholder="请输入用户名"
              maxlength="30"
            />
          </el-form-item>
          <el-form-item label="昵称" prop="nickName">
            <el-input
              v-model="editForm.nickName"
              placeholder="请输入用户昵称"
              maxlength="30"
            />
          </el-form-item>
          <el-form-item label="手机号码" prop="mobilePhone">
            <el-input
              v-model="editForm.mobilePhone"
              placeholder="请输入手机号码"
              maxlength="11"
            />
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input
              v-model="editForm.email"
              placeholder="请输入邮箱"
              maxlength="50"
            />
          </el-form-item>
          <el-form-item label="用户性别" prop="sex">
            <el-radio-group v-model="editForm.sex" @keyup.enter="handleSave">
              <dictionary-radio code="systemUserSex" />
            </el-radio-group>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSave" :loading="editLoading"
              >保 存</el-button
            >
            <el-button type="danger" @click="close">关 闭</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="修改密码" name="updatePassword">
        <el-form
          :model="editPasswordForm"
          ref="editPasswordFormRef"
          label-width="80px"
          class="password-form"
          :rules="passwordRules"
        >
          <el-form-item label="旧密码" prop="oldPassword">
            <el-input
              v-model="editPasswordForm.oldPassword"
              :type="passwordType"
              auto-complete="off"
              placeholder="旧密码，使用第三方登录并且未重置密码，可不填"
              @keyup="checkCapslock"
              @blur="capsTooltip = false"
              @keyup.enter="handleSavePassword"
            />
            <span class="show-password" @click="handleShowPassword">
              <svg-icon
                :icon-name="passwordType === 'password' ? 'eye' : 'eye-open'"
              />
            </span>
          </el-form-item>
          <el-form-item label="新密码" prop="newPassword">
            <el-input
              v-model="editPasswordForm.newPassword"
              :type="passwordType"
              auto-complete="off"
              placeholder="请输入新密码"
              @keyup="checkCapslock"
              @blur="capsTooltip = false"
              @keyup.enter="handleSavePassword"
            />
            <span class="show-password" @click="handleShowPassword">
              <svg-icon
                :icon-name="passwordType === 'password' ? 'eye' : 'eye-open'"
              />
            </span>
          </el-form-item>
          <el-form-item label="确认密码" prop="confirmPassword">
            <el-input
              v-model="editPasswordForm.confirmPassword"
              :type="passwordType"
              auto-complete="off"
              placeholder="请再次输入新密码"
              @keyup="checkCapslock"
              @blur="capsTooltip = false"
              @keyup.enter="handleSavePassword"
            />
            <span class="show-password" @click="handleShowPassword">
              <svg-icon
                :icon-name="passwordType === 'password' ? 'eye' : 'eye-open'"
              />
            </span>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              @click="handleSavePassword"
              :loading="editPasswordLoading"
              >保 存</el-button
            >
            <el-button type="danger" @click="close">关 闭</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
    </el-tabs>
  </el-card>
</template>
<script setup>
import { getCurrentInstance, ref, watch } from 'vue'

import { userUpdateInfo, resetUserPassword } from '@/api/system/user'

const props = defineProps({
  user: {
    type: Object,
    require: true
  }
})

const { proxy } = getCurrentInstance()

const activeTab = ref('updateUser')
const editLoading = ref(false)
const editForm = ref({})
const rules = ref({
  username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
  nickName: [{ required: true, message: '昵称不能为空', trigger: 'blur' }]
})

const editPasswordLoading = ref(false)
const editPasswordForm = ref({
  oldPassword: undefined,
  newPassword: undefined,
  confirmPassword: undefined
})

// 校验密码是否相等
const checkNewPasswordIsEqual = (rule, value, callback) => {
  if (editPasswordForm.value.newPassword !== value) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}
const passwordRules = ref({
  newPassword: [
    { required: true, message: '新密码不能为空', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '确认密码不能为空', trigger: 'blur' },
    { required: true, validator: checkNewPasswordIsEqual, trigger: 'blur' }
  ]
})

/**
 * 监听变化，否则数据有变动不会生效
 */
watch(props, (nweProps, oldProps) => {
  const user = nweProps.user
  editForm.value.username = user.username
  editForm.value.nickName = user.nickName
  editForm.value.mobilePhone = user.mobilePhone
  editForm.value.email = user.email
  editForm.value.sex = user.sex + ''
})

/**
 * 保存用户信息
 */
const emit = defineEmits(null)
function handleSave() {
  proxy.$refs.editFormRef.validate(async (valid) => {
    if (valid) {
      editLoading.value = true
      try {
        await userUpdateInfo(editForm.value)
        proxy.$modal.msgSuccess('修改基本资料成功')
        emit('fetch-data')
      } finally {
        editLoading.value = false
      }
    }
  })
}

// 大写提示
const capsTooltip = ref(false)
/**
 * 检测是否为大写
 */
function checkCapslock(e) {
  const { key } = e
  capsTooltip.value = key && key.length === 1 && key >= 'A' && key <= 'Z'
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
 * 修改密码
 */
function handleSavePassword() {
  proxy.$refs.editPasswordFormRef.validate(async (valid) => {
    if (valid) {
      editPasswordLoading.value = true
      try {
        await resetUserPassword(editPasswordForm.value)
        proxy.$modal.msgSuccess('修改密码成功')
      } finally {
        editPasswordLoading.value = false
      }
    }
  })
}

/**
 * 关闭按钮
 */
function close() {
  proxy.$tab.closePage()
}
</script>
<style lang="scss" scoped>
.password-form {
  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
    .input-icon {
      height: 39px;
      width: 14px;
      margin-left: 2px;
    }
  }
  .show-password {
    height: 39px;
    width: 14px;
    position: absolute;
    right: 10px;
    line-height: 39px;
    font-size: 16px;
    color: #889aa4;
    cursor: pointer;
    user-select: none;
  }
}
</style>
