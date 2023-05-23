<template>
  <div>
    <img
      :src="getPictureShowUrl(options.img, options.img === defaultAvatar)"
      class="site-image-cropper"
      @click="handleEditCropper"
    />

    <el-dialog
      v-model="visible"
      :title="title"
      width="800px"
      append-to-body
      @opened="modalOpened"
      :before-close="beforeClose"
    >
      <el-row>
        <el-col :xs="24" :md="12" :style="{ height: '350px' }">
          <vue-cropper
            ref="cropperRef"
            :img="getPictureShowUrl(options.img, options.img === defaultAvatar)"
            :info="true"
            :autoCrop="options.autoCrop"
            :autoCropWidth="options.autoCropWidth"
            :autoCropHeight="options.autoCropHeight"
            :fixedBox="options.fixedBox"
            @realTime="realTime"
            v-if="visibleCropper"
          />
        </el-col>
        <el-col :xs="24" :md="12" :style="{ height: '350px' }">
          <div class="image-upload-preview">
            <img
              :src="getPictureShowUrl(options.previews.url)"
              :style="options.previews.img"
            />
          </div>
        </el-col>
      </el-row>
      <br />
      <el-row>
        <el-col :lg="2" :md="2">
          <el-upload
            action="#"
            accept=".jpg,.png,.jpeg,.ico,.gif,.svg.tiff"
            :http-request="requestUpload"
            :show-file-list="false"
            :before-upload="beforeUpload"
          >
            <el-button>
              <span class="upload-btn">上传</span>
              <el-icon><UploadFilled /></el-icon>
            </el-button>
          </el-upload>
        </el-col>
        <el-col :lg="{ span: 1, offset: 2 }" :md="2">
          <el-button icon="Plus" @click="changeScale(1)"></el-button>
        </el-col>
        <el-col :lg="{ span: 1, offset: 1 }" :md="2">
          <el-button icon="Minus" @click="changeScale(-1)"></el-button>
        </el-col>
        <el-col :lg="{ span: 1, offset: 1 }" :md="2">
          <el-button icon="RefreshLeft" @click="rotateLeft()"></el-button>
        </el-col>
        <el-col :lg="{ span: 1, offset: 1 }" :md="2">
          <el-button icon="RefreshRight" @click="rotateRight()"></el-button>
        </el-col>
        <el-col :lg="{ span: 2, offset: 6 }" :md="2">
          <el-button type="primary" @click="handleSave" :loading="editLoading"
            >提 交</el-button
          >
        </el-col>
      </el-row>
    </el-dialog>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref, watch } from 'vue'
import 'vue-cropper/dist/index.css'
import { VueCropper } from 'vue-cropper'

import defaultAvatar from '@/assets/images/profile.jpg'

import { uploadAvavar } from '@/api/nav/picture'

const props = defineProps({
  // 图片路径
  path: {
    type: String,
    require: true
  },
  // 标题
  title: {
    type: String,
    default: '上传头像'
  }
})

const { proxy } = getCurrentInstance()

const visible = ref(false)
const visibleCropper = ref(false)
const editLoading = ref(false)

const options = ref({
  // 裁剪图片的地址
  img: props.path ? props.path : defaultAvatar,
  // 裁剪生成图片的质量
  outputSize: 1,
  // 裁剪生成图片的格式
  outputType: 'png',
  // 是否默认生成截图框
  autoCrop: true,
  // 默认生成截图框宽度
  autoCropWidth: 200,
  // 默认生成截图框高度
  autoCropHeight: 200,
  // 固定截图框大小 不允许改变
  fixedBox: true,
  // 预览数据
  previews: {}
})

/**
 * 编辑图片显示
 */
function handleEditCropper() {
  visible.value = true
}

/**
 * 打开弹出层结束时的回调
 */
function modalOpened() {
  visibleCropper.value = true
}

/**
 * 手动关闭
 */
function beforeClose() {
  close()
  options.value.img = props.path
}

/**
 * 关闭
 */
function close() {
  visible.value = false
  visibleCropper.value = false
}

/**
 * 实时预览
 */
function realTime(data) {
  options.value.previews = data
}

/**
 * 向左旋转
 */
function rotateLeft() {
  proxy.$refs.cropperRef.rotateLeft()
}

/**
 * 向右旋转
 */
function rotateRight() {
  proxy.$refs.cropperRef.rotateRight()
}

/**
 * 图片缩放
 */
function changeScale(num) {
  num = num || 1
  proxy.$refs.cropperRef.changeScale(num)
}

/**
 * 上传预处理
 */
function beforeUpload(file) {
  if (file.type.indexOf('image/') === -1) {
    proxy.$modal.msgError(
      '文件格式错误，请上传图片类型,如：JPG，PNG后缀的文件。'
    )
  } else {
    const reader = new FileReader()
    reader.readAsDataURL(file)
    reader.onload = () => {
      options.value.img = reader.result
    }
  }
}
/**
 * 上传图片
 */
const emit = defineEmits(null)
function handleSave() {
  proxy.$refs.cropperRef.getCropBlob(async (data) => {
    const formData = new FormData()
    formData.append('file', data)
    editLoading.value = true
    try {
      let path = ''
      const {
        data: { filePath }
      } = await uploadAvavar(formData)
      path = filePath

      options.value.img = path
      proxy.$modal.msgSuccess('上传成功')
      emit('success', path)
      close()
    } finally {
      editLoading.value = false
    }
  })
}

watch(
  () => props.path,
  (newVal, oldVal) => {
    options.value.img = newVal
  }
)
</script>
<style lang="scss" scoped>
.upload-btn {
  margin-right: 10px;
}
</style>
