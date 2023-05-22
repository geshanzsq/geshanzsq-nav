<template>
  <el-dialog
    v-model="visible"
    :title="title"
    width="600px"
    append-to-body
    :before-close="close"
  >
    <el-form
      :model="editForm"
      ref="editFormRef"
      label-width="80px"
      :rules="rules"
    >
      <el-form-item label="角色名称" prop="roleName">
        <el-input v-model="editForm.roleName" placeholder="请输入角色名称" />
      </el-form-item>
      <el-form-item label="角色编码" prop="roleCode">
        <el-input v-model="editForm.roleCode" placeholder="请输入角色标识" />
      </el-form-item>
      <el-form-item label="角色顺序" prop="sort">
        <el-input-number
          v-model="editForm.sort"
          controls-position="right"
          :min="0"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-radio-group v-model="editForm.status">
          <dictionary-radio code="commonStatus" />
        </el-radio-group>
      </el-form-item>
      <el-form-item label="菜单权限">
        <el-row>
          <el-col :span="24"
            ><el-checkbox
              v-model="menuExpand"
              @change="handleCheckedTreeExpand($event)"
              >展开/折叠</el-checkbox
            >
            <el-checkbox
              v-model="menuNodeAll"
              @change="handleCheckedTreeNodeAll($event)"
              >全选/全不选</el-checkbox
            >
            <el-checkbox
              v-model="menuCheckStrictly"
              @change="handleCheckedTreeConnect($event)"
              >父子联动</el-checkbox
            ></el-col
          >
          <el-col :span="24">
            <el-tree
              class="tree-border"
              :default-expand-all="menuExpand"
              :data="menuTree"
              show-checkbox
              ref="menuRef"
              node-key="id"
              :check-strictly="!menuCheckStrictly"
              :default-checked-keys="editForm.menuIds"
              @check="handleMenuNodeClick"
              empty-text="加载中，请稍候"
              :props="{ label: 'menuName', children: 'children' }"
            ></el-tree
          ></el-col>
        </el-row>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input
          v-model="editForm.remark"
          type="textarea"
          placeholder="请输入内容"
        ></el-input>
      </el-form-item>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="close">取 消</el-button>
        <el-button type="primary" @click="handleSave">确 定</el-button>
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'

import { getById, add, update, getMaxSort } from '@/api/system/role'

import { list } from '@/api/system/menu'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const rules = ref({
  roleName: [{ required: true, message: '角色名称不能为空', trigger: 'blur' }],
  roleCode: [{ required: true, message: '角色编码不能为空', trigger: 'blur' }],
  sort: [{ required: true, message: '顺序不能为空', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }]
})
const editForm = ref({
  sort: 1,
  status: '1',
  menuIds: []
})
const menuTree = ref([])
// 菜单数量
const menuCount = ref(0)
const menuRef = ref(null)
// 父子联动
const menuCheckStrictly = ref(true)
// 展开/折叠
const menuExpand = ref(false)
// 全选/全不选
const menuNodeAll = ref(false)

/**
 * 显示弹窗
 */
async function show(id) {
  visible.value = true
  if (id) {
    title.value = '修改角色'
    // 获取角色信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.status = editForm.value.status + ''
  } else {
    title.value = '新增角色'
    editForm.value.id = undefined
    const { data } = await getMaxSort()
    editForm.value.sort = data ? data + 1 : 1
  }
  getMenuTree()
  // 设置父子联动，新增时默认父子联动，修改时判断是否全选
  menuCheckStrictly.value =
    !id && editForm.value.menuIds.length === menuCount.value
}

/**
 * 关闭
 */
function close() {
  visible.value = false
  menuCheckStrictly.value = true
  menuExpand.value = false
  menuNodeAll.value = false
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
      editForm.value.menuIds = getMenuAllCheckedKeys()
      // 修改
      if (editForm.value.id) {
        await update(editForm.value)
        proxy.$modal.msgSuccess('修改角色成功')
      } else {
        // 新增
        await add(editForm.value)
        proxy.$modal.msgSuccess('新增角色成功')
      }
      emit('fetch-data')
      close()
    }
  })
}

/**
 * 获取菜单数据
 */
async function getMenuTree() {
  const { data } = await list()
  menuCount.value = data.length
  menuTree.value = proxy.handleTree(data)
}

/**
 * 树权限（展开/折叠）
 */
function handleCheckedTreeExpand(value) {
  const treeList = menuTree.value
  for (let i = 0; i < treeList.length; i++) {
    menuRef.value.store.nodesMap[treeList[i].id].expanded = value
  }
}

/**
 * 树权限（全选/全不选）
 */
function handleCheckedTreeNodeAll(value) {
  menuRef.value.setCheckedNodes(value ? menuTree.value : [])
}

/**
 * 所有菜单节点数据
 */
function getMenuAllCheckedKeys() {
  // 目前被选中的菜单节点
  const checkedKeys = menuRef.value.getCheckedKeys()
  // 半选中的菜单节点
  const halfCheckedKeys = menuRef.value.getHalfCheckedKeys()
  checkedKeys.unshift.apply(checkedKeys, halfCheckedKeys)
  return checkedKeys
}

/**
 * 菜单点击事件
 */
function handleMenuNodeClick(data, node) {
  const checkedKeyLength = node.checkedKeys.length
  // 去除全选
  if (
    (checkedKeyLength === 0 || checkedKeyLength < menuCount.value) &&
    menuNodeAll.value
  ) {
    menuNodeAll.value = false
    return
  }
  // 勾选全选
  if (checkedKeyLength === menuCount.value && !menuNodeAll.value) {
    menuNodeAll.value = true
  }
}

/** 树权限（父子联动） */
function handleCheckedTreeConnect(value) {
  menuCheckStrictly.value = !!value
}

defineExpose({
  show
})
</script>
