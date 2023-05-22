<template>
  <div>
    <el-divider></el-divider>
    <div class="footer-beian">
      Copyright &copy; 2020 <a href="/">{{ title }}</a
      >.保留所有权利
      <a href="http://beian.miit.gov.cn/" target="_blank">
        {{ recordTitle }}
      </a>
    </div>
  </div>
</template>
<script setup>
import { title, recordTitle } from '@/config/setting.config'
</script>

<style scoped lang="scss">
.footer-beian {
  text-align: center;
  font-size: 13px;
  color: #a4a4a4;
  padding-bottom: 20px;
}
</style>
