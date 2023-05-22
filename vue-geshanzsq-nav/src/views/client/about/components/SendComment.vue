<template>
  <el-form
    :class="editForm.parentId > 0 ? 'parent-send-comment' : ''"
    :model="editForm"
    ref="editFormRef"
  >
    <el-form-item prop="commentContent">
      <el-input
        type="textarea"
        :rows="4"
        :placeholder="placeholder"
        v-model="editForm.commentContent"
      />
    </el-form-item>
    <el-row :gutter="24" v-if="!isLogin">
      <el-col :xs="24" :sm="12">
        <el-form-item prop="nickName">
          <el-input v-model="editForm.nickName" placeholder="昵称">
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>
      </el-col>
      <el-col :xs="24" :sm="12">
        <el-form-item prop="email">
          <el-input v-model="editForm.email" placeholder="邮箱">
            <template #prefix>
              <el-icon><Message /></el-icon>
            </template>
          </el-input>
        </el-form-item>
      </el-col>
    </el-row>
    <div class="operation-parent">
      <div class="operation">
        <el-button
          type="danger"
          v-if="editForm.parentId > 0"
          @click="handleCancelPublish"
          >再想想</el-button
        >
        <el-button type="primary" @click="handlePublish" :loading="loading">
          发表
        </el-button>
      </div>
    </div>
  </el-form>
</template>
<script setup>
import { computed, getCurrentInstance, ref, watch } from 'vue'

import { getToken } from '@/utils/auth'
import { add } from '@/api/client/comment'

const props = defineProps({
  parentId: {
    type: Number || String,
    default: 0
  },
  placeholder: {
    type: String,
    default: '既然来了，那就留些足迹吧！'
  }
})

const { proxy } = getCurrentInstance()
const emit = defineEmits(null)

const editForm = ref({
  parentId: props.parentId,
  commentContent: undefined,
  nickName: undefined,
  email: undefined
})
const loading = ref(false)
const isLogin = computed(() => getToken())

watch(props, (newProps) => {
  editForm.value.parentId = newProps.parentId
})

/**
 * 取消发表
 */
function handleCancelPublish() {
  editForm.value.parentId = 0
  emit('cancel')
}

/**
 * 发表评论
 */
async function handlePublish() {
  if (!editForm.value.commentContent) {
    proxy.$modal.msgError('请输入评论内容')
    return
  }
  try {
    loading.value = true
    await add(editForm.value)
    proxy.$modal.msgSuccess('发表成功')
    loading.value = false
    emit('success')
    reset()
  } catch (err) {
    loading.value = false
  }
}

/**
 * 重置
 */
function reset() {
  proxy.resetForm('editFormRef')
}
</script>
<style lang="scss" scoped>
.parent-send-comment {
  margin-top: 10px;
}

/* 清除高度坍塌 */
.operation-parent:after {
  content: '';
  display: block;
  clear: both;
  width: 0;
  height: 0;
}

.operation {
  margin-top: 10px;
  margin-bottom: 10px;
  float: right;
}
</style>
