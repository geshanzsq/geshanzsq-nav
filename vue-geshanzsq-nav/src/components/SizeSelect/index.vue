<template>
  <div>
    <el-dropdown trigger="click" @command="handleSetSize">
      <div class="size-icon--style">
        <svg-icon class-name="size-icon" icon-name="size" />
      </div>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item
            v-for="item of sizeOptions"
            :key="item.value"
            :disabled="size === item.value"
            :command="item.value"
          >
            {{ item.label }}
          </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
  </div>
</template>

<script setup>
import { computed, getCurrentInstance, ref } from 'vue'
import { useStore } from 'vuex'

const store = useStore()
const size = computed(() => store.getters['app/size'])
const { proxy } = getCurrentInstance()
const sizeOptions = ref([
  { label: '较大', value: 'large' },
  { label: '默认', value: 'default' },
  { label: '稍小', value: 'small' }
])

function handleSetSize(size) {
  proxy.$modal.loading('正在设置布局大小，请稍候...')
  store.dispatch('app/setSize', size)
  setTimeout(() => {
    window.location.reload()
  }, 1000)
}
</script>

<style lang="scss" scoped>
.size-icon--style {
  font-size: 18px;
  line-height: 50px;
  padding-right: 7px;
}
</style>
