<template>
  <el-card :v-loading="loading">
    <template #header>
      <div>
        <span>个人信息</span>
      </div>
    </template>

    <user-avatar
      :path="user.avatar ? user.avatar : defaultAvatar"
      @success="handleUploadAvatarSuccess"
    />
    <ul class="list-group list-group-striped">
      <li class="list-group-item">
        <svg-icon icon-name="user" />用户名
        <div class="pull-right">{{ user.username }}</div>
      </li>
      <li class="list-group-item">
        <svg-icon icon-name="phone" />手机号码
        <div class="pull-right">{{ user.mobilePhone }}</div>
      </li>
      <li class="list-group-item">
        <svg-icon icon-name="email" />用户邮箱
        <div class="pull-right">{{ user.email }}</div>
      </li>
      <li class="list-group-item">
        <svg-icon icon-name="date" />注册时间
        <div class="pull-right">{{ user.gmtCreate }}</div>
      </li>
    </ul>
  </el-card>
</template>
<script setup>
import { useStore } from 'vuex'

import UserAvatar from './UserAvatar'
import defaultAvatar from '@/assets/images/profile.jpg'

defineProps({
  user: {
    type: Object,
    require: true
  }
})

const store = useStore()

/**
 * 头像上传成功
 */
function handleUploadAvatarSuccess(avatar) {
  store.dispatch('user/setAvatar', avatar)
}
</script>
