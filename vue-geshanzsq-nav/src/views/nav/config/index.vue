<template>
  <div class="app-container">
    <el-tabs type="border-card">
      <el-tab-pane label="关于本站">
        <el-form
          v-loading="loading"
          :model="editForm"
          ref="editFormRef"
          label-width="80px"
          :rules="rules"
        >
          <el-form-item label="邮箱" prop="aboutSiteEmail">
            <el-input
              v-model="editForm.aboutSiteEmail"
              placeholder="请输入邮箱"
            >
            </el-input>
          </el-form-item>
          <el-form-item label="网站说明" prop="aboutSiteDescription">
            <el-input
              v-model="editForm.aboutSiteDescription"
              placeholder="请输入网站说明"
            >
            </el-input>
          </el-form-item>
          <el-form-item label="内容" prop="aboutSiteContent">
            <wang-editor v-model="editForm.aboutSiteContent" />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              v-permission="['nav:config:update']"
              class="button-save"
              @click="handleSave"
              :loading="editLoading"
              >保存</el-button
            >
          </el-form-item>
        </el-form>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'
import WangEditor from '@/components/WangEditor'

import { getConfig, update } from '@/api/nav/config'

const { proxy } = getCurrentInstance()

const loading = ref(true)
const editLoading = ref(false)
const editForm = ref({
  id: undefined,
  aboutSiteEmail: undefined,
  aboutSiteDescription: undefined,
  aboutSiteContent: undefined
})

/**
 * 获取数据
 */
async function getData() {
  loading.value = true
  const { data } = await getConfig()
  if (data) {
    const { id, aboutSiteEmail, aboutSiteDescription, aboutSiteContent } = data
    editForm.value.id = id
    editForm.value.aboutSiteEmail = aboutSiteEmail
    editForm.value.aboutSiteDescription = aboutSiteDescription
    editForm.value.aboutSiteContent = aboutSiteContent
  }
  loading.value = false
}

/**
 * 提交数据
 */
function handleSave() {
  proxy.$refs.editFormRef.validate(async (valid) => {
    if (valid) {
      editLoading.value = true
      try {
        // 修改
        const { data } = await update(editForm.value)
        proxy.$modal.msgSuccess('保存成功')
        editForm.value.id = data
      } finally {
        editLoading.value = false
      }
    }
  })
}

getData()
</script>

<style lang="scss" scoped>
.app-container {
  position: relative;
  .button-save {
    position: absolute;
    right: 10px;
    margin-top: 15px;
  }
}
</style>
