<template>
  <div class="wang-editor-container">
    <Toolbar
      class="wang-toolbar"
      :editor="editorRef"
      :defaultConfig="toolbarConfig"
      :mode="mode"
    />
    <Editor
      class="wang-content"
      v-model="content"
      :defaultConfig="editorConfig"
      :mode="mode"
      @onCreated="handleCreated"
    />
  </div>
</template>
<script setup>
import '@wangeditor/editor/dist/css/style.css' // 引入 css

import { computed, onBeforeUnmount, ref, shallowRef } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { getToken } from '@/utils/auth'
import { tokenConfig } from '@/config/network.config'
import { getPictureShowUrl } from '@/utils/geshanzsq'
const props = defineProps({
  // 内容
  modelValue: {
    type: String,
    default: ''
  }
})

// 编辑器实例，必须用 shallowRef
const editorRef = shallowRef()

// 内容
const emit = defineEmits(null)
const content = computed({
  get() {
    return props.modelValue
  },
  set(value) {
    // 子组件传值给父组件
    emit('update:modelValue', value)
  }
})

const toolbarConfig = ref({})
const editorConfig = ref({
  placeholder: '请输入内容...',
  MENU_CONF: {
    uploadImage: {
      server: process.env.VUE_APP_BASE_API + '/nav/picture/upload',
      fieldName: 'file',
      headers: {
        Authorization: tokenConfig.prefix + getToken()
      },
      // 由于上传成功后格式不符合编辑器要求，所以自定义实现
      customInsert(res, insertFn) {
        const {
          code,
          data: { fileName, filePath }
        } = res
        if (code === 200) {
          const url = getPictureShowUrl(filePath)
          insertFn(url, fileName, url)
        }
      }
    }
  }
})

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
  const editor = editorRef.value
  if (editor == null) return
  editor.destroy()
})

const handleCreated = (editor) => {
  // 记录 editor 实例，重要！
  editorRef.value = editor
}

/**
 * 插入图片
 */
function insertPicture(url) {
  const src = getPictureShowUrl(url)
  editorRef.value.dangerouslyInsertHtml(`<img src="${src}">`)
}

defineExpose({
  insertPicture
})
</script>
<style scoped lang="scss">
.wang-editor-container {
  width: 100%;
  border: 1px solid #ccc;

  &.w-e-full-screen-container {
    z-index: 9999 !important;
  }

  .wang-toolbar {
    border-bottom: 1px solid #ccc;
  }
  .wang-content {
    height: 400px !important;
    overflow-y: hidden;
  }
}
</style>
