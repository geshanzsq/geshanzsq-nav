<template>
  <span v-if="type === '' || type === 'default'">{{ label }}</span>
  <el-tag v-else :effect="effect" :type="type" :round="round" :size="size">{{
    label
  }}</el-tag>
</template>
<script setup>
import { ref, watch } from 'vue'
import { getDictionaryData } from '@/utils/geshanzsq'

const props = defineProps({
  // 字典编码
  code: {
    type: String,
    required: true
  },
  // 字典值
  value: {
    type: [Number, String, Array]
  },
  // 主题
  effect: {
    type: String,
    default: 'light'
  },
  // 是否圆角
  round: {
    type: Boolean,
    default: false
  },
  // 大小
  size: {
    type: String,
    default: 'default'
  }
})

// 显示内容
const label = ref('')
// 类型
const type = ref('')

/**
 * 监听变化，否则数据有变动不会生效
 */
watch(props, (nweProps, oldProps) => {
  getLabel()
})

/**
 * 获取标签
 */
function getLabel() {
  const dictionaryData = getDictionaryData(props.code, props.value)
  if (dictionaryData !== undefined) {
    label.value = dictionaryData.dictionaryLabel
    type.value = dictionaryData.classType
  }
}

getLabel()
</script>
