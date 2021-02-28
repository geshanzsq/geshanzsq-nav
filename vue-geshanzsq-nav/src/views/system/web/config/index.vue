<template>
  <div class="app-container">
    <el-tabs  type="border-card">
      <el-tab-pane label="关于本站">
        <el-form v-model="webConfig" label-width="80px">
          <el-form-item label="邮箱">
            <el-input v-model="webConfig.aboutWebEmail" placeholder="请输入邮箱"/>
          </el-form-item>
          <el-form-item label="网站说明">
            <el-input type="textarea" :autosize="{ minRows: 1, maxRows: 3 }" v-model="webConfig.aboutWebDescription" placeholder="请输入网站说明"/>
          </el-form-item>
          <el-form-item label="内容">
            <tinymce v-model="webConfig.aboutWebContent"/>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" style="float: right" @click="updateWebConfig">保存</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
  import Tinymce from "@/components/Tinymce"

  import { getWebConfig,updateWebConfig } from '@/api/system/webConfig'

  export default {
    name: 'NavAbout',
    components: {Tinymce},
    data() {
      return {
        webConfig: {},
      }
    },
    created() {
      this.getWebConfig();
    },
    methods: {
      getWebConfig() {
        getWebConfig().then(response => {
          this.webConfig = response.data;
        });
      },
      /** 更新关于本站 */
      updateWebConfig(){
        updateWebConfig(this.webConfig).then(response => {
          if (response.code == 200) {
            this.msgSuccess('保存成功！');
          }
        })
      }
    }
  }
</script>

<style scoped>

</style>
