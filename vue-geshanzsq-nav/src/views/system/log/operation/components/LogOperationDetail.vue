<template>
  <el-dialog
    v-model="visible"
    title="操作日志详情"
    width="60%"
    append-to-body
    :before-close="close"
  >
    <el-form :model="editForm" label-width="100px">
      <el-row>
        <el-col :span="12">
          <el-form-item label="模块名称："
            >{{ editForm.moduleName }} /
            {{
              getDictionaryLabel(
                'logOperationBusinessType',
                editForm.businessType
              )
            }}</el-form-item
          >
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作用户："
            >{{ editForm.nickName }}({{ editForm.username }})</el-form-item
          >
        </el-col>
        <el-col :span="12">
          <el-form-item label="请求地址：">{{
            editForm.requestUrl
          }}</el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="请求方式：">{{
            editForm.requestMethod
          }}</el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="类方法：">{{
            editForm.classMethod
          }}</el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="请求参数：">{{
            editForm.requestParam
          }}</el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="返回结果：">{{
            editForm.returnResult
          }}</el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="错误信息：">{{
            editForm.errorMessage
          }}</el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作 IP ："
            >{{ editForm.ipAddress }}
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作位置："
            >{{ editForm.operateLocation }}
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="浏览器："
            >{{ editForm.browserType }}
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作系统："
            >{{ editForm.operateSystem }}
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作时间：">{{
            parseTime(editForm.gmtOperate)
          }}</el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="操作状态："
            ><dictionary-tag
              code="logOperationStatus"
              :value="editForm.status"
            ></dictionary-tag
          ></el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="close" type="primary">关闭</el-button>
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { ref } from 'vue'

import { getById } from '@/api/system/log/operation'

const visible = ref(false)
const editForm = ref({})

/**
 * 显示弹窗
 */
async function show(id) {
  visible.value = true
  const { data } = await getById(id)
  editForm.value = data
}

/**
 * 关闭
 */
function close() {
  visible.value = false
}

defineExpose({
  show
})
</script>
