<template>
  <el-dialog
    v-model="visible"
    :title="title"
    append-to-body
    width="500px"
    :before-close="close"
  >
    <el-form
      :model="editForm"
      ref="editFormRef"
      label-width="80px"
      :rules="rules"
    >
      <el-form-item label="所属分类" prop="categoryId">
        <el-tree-select
          style="width: 100%"
          v-model="editForm.categoryId"
          :data="categoryTree"
          :props="{ value: 'id', label: 'categoryName', children: 'children' }"
          value-key="id"
          placeholder="请选择所属分类"
          filterable
          :render-after-expand="false"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="网站名称" prop="siteName">
        <el-input
          v-model="editForm.siteName"
          placeholder="请输入网站名称"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="网站描述" prop="siteDescription">
        <el-input
          v-model="editForm.siteDescription"
          placeholder="请输入网站描述"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="网站地址" prop="siteUrl">
        <el-input
          v-model="editForm.siteUrl"
          placeholder="请输入网站地址"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input-number
          v-model="editForm.sort"
          controls-position="right"
          :min="0"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="网站图片" prop="sitePath">
        <el-row>
          <el-col :span="24">
            <site-picture
              :path="editForm.sitePath"
              @success="handleUploadSitePicture"
            />
          </el-col>
          <el-col :span="24">
            <div class="site-form-path-tip">
              提示：点击图片可进行裁剪和上传，点击采集自动获取该网站的图标
            </div>
            <div class="site-form-path-tip">
              输入网站地址，点击自动匹配即可匹配网站相关内容
            </div>
          </el-col>
        </el-row>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-radio-group v-model="editForm.status" @keyup.enter="handleSave">
          <dictionary-radio code="commonStatus" />
        </el-radio-group>
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="close">取 消</el-button>
        <el-button type="primary" @click="handleSave" :loading="editLoading"
          >确 定</el-button
        >
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import SitePicture from '@/views/nav/components/SitePicture'

import { tree } from '@/api/nav/category'
import { add, getById, update, getMaxSortByCategoryId } from '@/api/nav/site'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const categoryTree = ref([])
const editLoading = ref(false)
// 默认图片
const defaultSiteImage = ref('/profile/site/system/logo.jpg')
const editForm = ref({
  id: undefined,
  categoryId: undefined,
  siteName: undefined,
  status: '1',
  sort: 0,
  sitePath: undefined
})

const rules = ref({
  categoryId: [
    { required: true, message: '所属分类不能为空', trigger: 'blur' }
  ],
  siteName: [{ required: true, message: '网站名称不能为空', trigger: 'blur' }],
  siteUrl: [{ required: true, message: '网站链接不能为空', trigger: 'blur' }],
  sort: [{ required: true, message: '排序不能为空', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }]
})

/**
 * 显示弹窗
 */
async function show(id, categoryId) {
  visible.value = true
  editForm.value.categoryId = categoryId
  if (id) {
    title.value = '修改网站'
    // 获取菜单信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.status = editForm.value.status + ''
  } else {
    title.value = '新增网站'
    editForm.value.sitePath = defaultSiteImage.value
    // 获取排序最大值
    const { data } = await getMaxSortByCategoryId(editForm.value.categoryId)
    editForm.value.sort = data ? data + 1 : 1
    editForm.value.id = undefined
  }
  getTree()
}

/**
 * 获取分类树
 */
async function getTree() {
  const { data } = await tree()
  categoryTree.value = data
}

/**
 * 关闭
 */
function close() {
  visible.value = false
  reset()
}

/**
 * 重置
 */
function reset() {
  proxy.resetForm('editFormRef')
}

/**
 * 图片裁剪上传成功回调
 */
function handleUploadSitePicture(filePath) {
  editForm.value.sitePath = filePath
}

/**
 * 提交数据
 */
const emit = defineEmits(null)
function handleSave() {
  proxy.$refs.editFormRef.validate(async (valid) => {
    if (valid) {
      editLoading.value = true
      // 修改
      if (editForm.value.id) {
        try {
          await update(editForm.value)
          proxy.$modal.msgSuccess('修改网站成功')
        } finally {
          editLoading.value = false
        }
      } else {
        // 新增
        try {
          await add(editForm.value)
          proxy.$modal.msgSuccess('新增网站成功')
        } finally {
          editLoading.value = false
        }
      }
      emit('fetch-data')
      close()
    }
  })
}

defineExpose({
  show
})
</script>
