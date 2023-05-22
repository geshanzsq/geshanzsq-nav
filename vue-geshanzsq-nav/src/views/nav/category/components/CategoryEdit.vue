<template>
  <el-dialog
    v-model="visible"
    :title="title"
    append-to-body
    width="680px"
    :before-close="close"
  >
    <el-form
      :model="editForm"
      ref="editFormRef"
      label-width="100px"
      :rules="rules"
    >
      <el-form-item label="上级分类" prop="parentId">
        <el-tree-select
          style="width: 100%"
          v-model="editForm.parentId"
          :data="categoryTree"
          :props="{ value: 'id', label: 'categoryName', children: 'children' }"
          value-key="id"
          placeholder="选择上级分类"
          check-strictly
          filterable
          :render-after-expand="false"
          @keyup.enter="handleSave"
        />
      </el-form-item>
      <el-form-item label="分类图标" prop="categoryIcon">
        <el-popover
          placement="bottom-start"
          :width="540"
          v-model:visible="showChooseIcon"
          trigger="click"
          @keyup.enter="handleSave"
          @show="showSelectIcon"
        >
          <template #reference>
            <el-input
              v-model="editForm.categoryIcon"
              placeholder="点击选择图标"
              @click="showSelectIcon"
              @keyup.enter="handleSave"
              readonly
            >
              <template #prefix>
                <svg-icon
                  v-if="editForm.categoryIcon"
                  :icon-name="editForm.categoryIcon"
                  class="el-input__icon"
                  style="height: 32px; width: 16px"
                />
                <el-icon v-else style="height: 32px; width: 16px"
                  ><search
                /></el-icon>
              </template>
            </el-input>
          </template>
          <icon-select ref="iconSelectRef" @selected="selected" />
        </el-popover>
      </el-form-item>

      <el-form-item label="分类名称" prop="categoryName">
        <el-input
          v-model="editForm.categoryName"
          placeholder="请输入分类名称"
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

import IconSelect from '@/components/IconSelect'

import {
  tree,
  getById,
  getMaxSortByParentId,
  add,
  update
} from '@/api/nav/category'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const categoryTree = ref([])
const editLoading = ref(false)
const editForm = ref({
  id: undefined,
  categoryName: undefined,
  parentId: '0',
  status: '1',
  sort: 0
})

const rules = ref({
  categoryName: [
    { required: true, message: '分类名称不能为空', trigger: 'blur' }
  ],
  parentId: [{ required: true, message: '上级分类不能为空', trigger: 'blur' }],
  sort: [{ required: true, message: '排序不能为空', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }]
})

const showChooseIcon = ref(false)
const iconSelectRef = ref(null)

/**
 * 显示弹窗
 */
async function show(id, parentId) {
  visible.value = true
  if (id) {
    title.value = '修改分类'
    // 获取菜单信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.status = editForm.value.status + ''
  } else {
    title.value = '新增分类'
    // 获取排序最大值
    const { data } = await getMaxSortByParentId(parentId)
    editForm.value.sort = data ? data + 1 : 1
    editForm.value.id = undefined
    editForm.value.parentId = parentId
  }
  getTree()
}

/**
 * 获取分类树
 */
async function getTree() {
  const { data } = await tree()
  categoryTree.value = [{ id: '0', categoryName: '根分类', children: data }]
}

/**
 * 展示下拉图标
 */
function showSelectIcon() {
  iconSelectRef.value.reset()
  showChooseIcon.value = true
}
/**
 * 选择图标
 */
function selected(name) {
  editForm.value.categoryIcon = name
  showChooseIcon.value = false
}

/**
 * 关闭
 */
function close() {
  visible.value = false
  showChooseIcon.value = false
  reset()
}

/**
 * 重置
 */
function reset() {
  proxy.resetForm('editFormRef')
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
          proxy.$modal.msgSuccess('修改分类成功')
        } finally {
          editLoading.value = false
        }
      } else {
        // 新增
        try {
          await add(editForm.value)
          proxy.$modal.msgSuccess('新增分类成功')
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
