<template>
  <div>
    <el-option
      :key="dictionary.id"
      :label="dictionary.dictionaryLabel"
      :value="dictionary.dictionaryValue"
      v-for="dictionary in dictionaryDataList"
    />
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
