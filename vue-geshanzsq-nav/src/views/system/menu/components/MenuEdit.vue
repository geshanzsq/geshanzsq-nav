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
      <el-row>
        <el-col :span="24">
          <el-form-item label="上级菜单" prop="parentId">
            <el-tree-select
              style="width: 100%"
              v-model="editForm.parentId"
              :data="menuTree"
              :props="{ value: 'id', label: 'menuName', children: 'children' }"
              value-key="id"
              placeholder="选择上级菜单"
              check-strictly
              :render-after-expand="false"
            />
          </el-form-item>
        </el-col>
        <el-col :span="24" v-if="editForm.menuType != 'B'">
          <el-form-item label="菜单图标" prop="menuIcon">
            <el-popover
              placement="bottom-start"
              :width="540"
              v-model:visible="showChooseIcon"
              trigger="click"
              @show="showSelectIcon"
            >
              <template #reference>
                <el-input
                  v-model="editForm.menuIcon"
                  placeholder="点击选择图标"
                  @click="showSelectIcon"
                  readonly
                >
                  <template #prefix>
                    <svg-icon
                      v-if="editForm.menuIcon"
                      :icon-name="editForm.menuIcon"
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
        </el-col>
        <el-col :span="24">
          <el-form-item label="菜单类型" prop="menuType">
            <el-radio-group v-model="editForm.menuType">
              <el-radio label="D">目录</el-radio>
              <el-radio label="M">菜单</el-radio>
              <el-radio label="B">按钮</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="菜单名称" prop="menuName">
            <el-input
              v-model="editForm.menuName"
              placeholder="请输入菜单名称"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="显示排序" prop="sort">
            <el-input-number
              v-model="editForm.sort"
              controls-position="right"
              :min="0"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'B'">
          <el-form-item>
            <template #label>
              <span>
                <el-tooltip
                  content="选择是外链则路由地址需要以`http(s)://`开头"
                  placement="top"
                >
                  <el-icon>
                    <QuestionFilled />
                  </el-icon> </el-tooltip
                >是否外链
              </span>
            </template>
            <el-radio-group v-model="editForm.hasFrame">
              <dictionary-radio code="systemMenuIsFrame" />
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'B'">
          <el-form-item prop="routerUrl">
            <template #label>
              <span>
                <el-tooltip
                  content="访问的路由地址，如：`user`，如外网地址需内链访问则以`http(s)://`开头"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                路由地址
              </span>
            </template>
            <el-input
              v-model="editForm.routerUrl"
              placeholder="请输入路由地址"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType == 'M'">
          <el-form-item prop="componentPath">
            <template #label>
              <span>
                <el-tooltip
                  content="访问的组件路径，如：`system/user/index`，默认在`views`目录下"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                组件路径
              </span>
            </template>
            <el-input
              v-model="editForm.componentPath"
              placeholder="请输入组件路径"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'D'">
          <el-form-item prop="permissionCode">
            <el-input
              v-model="editForm.permissionCode"
              placeholder="请输入权限标识"
              maxlength="100"
            />
            <template #label>
              <span>
                <el-tooltip content="控制器中定义的权限字符" placement="top">
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                权限字符
              </span>
            </template>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType == 'M'">
          <el-form-item prop="routerParam">
            <el-input
              v-model="editForm.routerParam"
              placeholder="请输入路由参数"
              maxlength="255"
            />
            <template #label>
              <span>
                <el-tooltip
                  content='访问路由的默认传递参数，如：`{"id": "M1", "name": "geshanzsq"}`'
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                路由参数
              </span>
            </template>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType == 'M'">
          <el-form-item prop="hasCache">
            <template #label>
              <span>
                <el-tooltip
                  content="选择是则会被`keep-alive`缓存，需要匹配组件的`name`和地址保持一致"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                是否缓存
              </span>
            </template>
            <el-radio-group v-model="editForm.hasCache">
              <dictionary-radio code="systemMenuIsCache" />
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'B'">
          <el-form-item prop="showStatus">
            <template #label>
              <span>
                <el-tooltip
                  content="选择隐藏则路由将不会出现在侧边栏，但仍然可以访问"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                显示状态
              </span>
            </template>
            <el-radio-group v-model="editForm.showStatus">
              <dictionary-radio code="systemMenuShowStatus" />
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'B'">
          <el-form-item prop="status">
            <template #label>
              <span>
                <el-tooltip
                  content="选择停用则路由将不会出现在侧边栏，也不能被访问"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                菜单状态
              </span>
            </template>
            <el-radio-group v-model="editForm.status">
              <dictionary-radio code="commonStatus" />
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="editForm.menuType != 'B'">
          <el-form-item prop="hasPermission">
            <template #label>
              <span>
                <el-tooltip
                  content="是否需要权限才能访问，如果为否，则该菜单不用分配就能显示"
                  placement="top"
                >
                  <el-icon><question-filled /></el-icon>
                </el-tooltip>
                需要权限
              </span>
            </template>
            <el-radio-group v-model="editForm.hasPermission">
              <dictionary-radio code="yesNo" />
            </el-radio-group>
          </el-form-item>
        </el-col>
      </el-row>
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

import IconSelect from '@/components/IconSelect'

import {
  list,
  getById,
  getMaxSortByParentId,
  add,
  update
} from '@/api/system/menu'

const { proxy } = getCurrentInstance()

const visible = ref(false)
const title = ref('')
const menuTree = ref([])
const editForm = ref({
  id: undefined,
  parentId: '',
  menuType: 'D',
  hasFrame: '2',
  hasCache: '1',
  showStatus: '1',
  status: '1',
  hasPermission: '1'
})

const rules = ref({
  menuName: [{ required: true, message: '菜单名称不能为空', trigger: 'blur' }],
  sort: [{ required: true, message: '菜单顺序不能为空', trigger: 'blur' }],
  routerUrl: [{ required: true, message: '路由地址不能为空', trigger: 'blur' }]
})

const showChooseIcon = ref(false)
const iconSelectRef = ref(null)

/**
 * 显示弹窗
 */
async function show(id, parentId) {
  visible.value = true
  if (id) {
    title.value = '修改菜单'
    // 获取菜单信息
    const { data } = await getById(id)
    editForm.value = data
    editForm.value.hasFrame = editForm.value.hasFrame + ''
    editForm.value.hasCache = editForm.value.hasCache + ''
    editForm.value.showStatus = editForm.value.showStatus + ''
    editForm.value.status = editForm.value.status + ''
    editForm.value.hasPermission = editForm.value.hasPermission + ''
  } else {
    title.value = '新增菜单'
    // 获取排序最大值
    const { data } = await getMaxSortByParentId(parentId)
    editForm.value.sort = data ? data + 1 : 1
    editForm.value.id = undefined
    editForm.value.parentId = parentId
  }
  getTree()
}

/**
 * 获取菜单树
 */
async function getTree() {
  menuTree.value = []
  const { data } = await list()
  const menu = { id: '', menuName: '根菜单', children: [] }
  menu.children = proxy.handleTree(data)
  menuTree.value.push(menu)
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
  editForm.value.menuIcon = name
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
      // 修改
      if (editForm.value.id) {
        await update(editForm.value)
        proxy.$modal.msgSuccess('修改菜单成功')
      } else {
        // 新增
        await add(editForm.value)
        proxy.$modal.msgSuccess('新增菜单成功')
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
