<template>
      <el-tabs type="border-card">
        <el-tab-pane label="百度">
          <el-input placeholder="百度一下" v-model="content" clearable @keyup.enter.native="handleSearch('https://www.baidu.com/s?wd=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://www.baidu.com/s?wd=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane label="Bing">
          <el-input placeholder="微软Bing搜索" v-model="content" clearable @keyup.enter.native="handleSearch('https://cn.bing.com/search?q=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://cn.bing.com/search?q=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane>
          <span slot="label">
            <span style="color: #3B83FA">G</span>
            <span style="color: #F3442C">o</span>
            <span style="color: #FFC300">o</span>
            <span style="color: #4696F8">g</span>
            <span style="color: #2CAB4E">l</span>
            <span style="color: #F54231">e</span>
          </span>
          <el-input placeholder="需科学上网" v-model="content" clearable @keyup.enter.native="handleSearch('https://www.google.com/search?q=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://www.google.com/search?q=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane>
          <span slot="label" style="color: #19b955">Magi</span>
          <el-input placeholder="Magi搜索" v-model="content" clearable @keyup.enter.native="handleSearch('https://magi.com/search?q=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://magi.com/search?q=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane>
          <span slot="label" style="color: #19b955">360</span>
          <el-input placeholder="360好搜" v-model="content" clearable @keyup.enter.native="handleSearch('https://www.so.com/s?q=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://www.so.com/s?q=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane>
          <span slot="label" style="color: #ff5943">搜狗</span>
          <el-input placeholder="搜狗搜索" v-model="content" clearable @keyup.enter.native="handleSearch('https://www.sogou.com/web?query=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://www.sogou.com/web?query=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane>
          <span slot="label" style="color: #ff8608">神马</span>
          <el-input placeholder="UC移动端搜索" v-model="content" clearable @keyup.enter.native="handleSearch('https://yz.m.sm.cn/s?q=')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSearch('https://yz.m.sm.cn/s?q=')"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>

        <el-tab-pane label="站内">
          <el-input placeholder="站内搜索" v-model="content" clearable @keyup.enter.native="handleSearch('/search/')">
            <i slot="prefix" class="el-input__icon el-icon-search"></i>
            <el-button slot="append"
                       type="primary"
                       style="color: #fff; background-color: #409eff;border-bottom: 2px solid #409eff"
                       @click="handleSiteSearch()"
            >搜索</el-button>
          </el-input>
        </el-tab-pane>
      </el-tabs>

</template>

<script>
  export default {
    name: "Search",
    data() {
      return {
        content: '',
      }
    },
    methods: {
      handleSearch(url) {
        if (this.content == undefined || this.content == '') {
          this.msgWarning("请输入需要搜索的内容！")
          return;
        }
        window.open(url + this.content,'_blank')
      },
      handleSiteSearch() {
        if (this.content == undefined || this.content == '') {
          this.msgWarning("请输入需要搜索的内容！")
          return;
        }
        let site = this.$router.resolve({
          path: "/search/" + this.content,
        });
        window.open(site.href, "_blank");
      }
    }

  }
</script>

<style scoped>
</style>
