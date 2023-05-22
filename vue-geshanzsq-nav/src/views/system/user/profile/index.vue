<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="8" :xs="24" :v-loading="loading">
        <user-base-info :user="user" />
      </el-col>
      <el-col :span="16" :xs="24" :v-loading="loading">
        <update-user-info :user="user" @fetch-data="getData" />
      </el-col>
    </el-row>
  </div>
</template>
<script setup>
import UserBaseInfo from './UserBaseInfo'
import UpdateUserInfo from './UpdateUserInfo'

import { getUserInfo } from '@/api/auth/user'
import { ref } from 'vue'

const loading = ref(true)
const user = ref({})

async function getData() {
  loading.value = true
  try {
    const { data } = await getUserInfo()
    user.value = data
  } finally {
    loading.value = false
  }
}

getData()
</script>

<style lang="scss" scoped>
.card-nav {
  margin-top: 20px;
}
</style>
