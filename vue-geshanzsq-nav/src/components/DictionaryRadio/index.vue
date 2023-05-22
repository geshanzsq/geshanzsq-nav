<template>
  <div>
    <el-radio
      :key="dictionary.id"
      :label="dictionary.dictionaryValue"
      v-for="dictionary in dictionaryDataList"
      >{{ dictionary.dictionaryLabel }}</el-radio
    >
  </div>
</template>
<script setup>
import { ref } from 'vue'

import { getDictionary } from '@/utils/geshanzsq'

const props = defineProps({
  // 字典编码
  code: {
    type: String,
    required: true
  }
})

const dictionaryDataList = ref([])

function getDictionaryDataList() {
  dictionaryDataList.value = getDictionary(props.code)
}

getDictionaryDataList()
</script>
