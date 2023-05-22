<template>
  <div class="search">
    <el-tabs type="border-card" v-model="searchType">
      <el-tab-pane label="百度" :name="baidu.value">
        <el-autocomplete
          v-model="content"
          placeholder="百度一下"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(baidu.searchUrl)"
          @keyup.enter="handleSearchUrl(baidu.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(baidu.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane label="Bing" :name="bing.value">
        <el-autocomplete
          v-model="content"
          placeholder="微软 Bing 搜索"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(bing.searchUrl)"
          @keyup.enter="handleSearchUrl(bing.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(bing.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane :name="google.value">
        <template #label>
          <span style="color: #3b83fa">G</span>
          <span style="color: #f3442c">o</span>
          <span style="color: #ffc300">o</span>
          <span style="color: #4696f8">g</span>
          <span style="color: #2cab4e">l</span>
          <span style="color: #f54231">e</span>
        </template>
        <el-autocomplete
          v-model="content"
          placeholder="Google 搜索"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(google.searchUrl)"
          @keyup.enter="handleSearchUrl(google.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(google.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane :name="baiduDev.value">
        <template #label>
          <span style="color: #19b955">开发者</span>
        </template>
        <el-autocomplete
          v-model="content"
          placeholder="百度开发者搜索，无任何广告"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(baiduDev.searchUrl)"
          @keyup.enter="handleSearchUrl(baiduDev.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button
              type="primary"
              @click="handleSearchUrl(baiduDev.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane :name="magi.value">
        <template #label>
          <span style="color: #19b955">Magi</span>
        </template>
        <el-autocomplete
          v-model="content"
          placeholder="Magi 搜索"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(magi.searchUrl)"
          @keyup.enter="handleSearchUrl(magi.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(magi.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane :name="haosou.value">
        <template #label>
          <span style="color: #19b955">360</span>
        </template>
        <el-autocomplete
          v-model="content"
          placeholder="360 好搜"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(haosou.searchUrl)"
          @keyup.enter="handleSearchUrl(haosou.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(haosou.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane :name="sougou.value">
        <template #label>
          <span style="color: #ff5943">搜狗</span>
        </template>
        <el-autocomplete
          v-model="content"
          placeholder="搜狗搜索"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(sougou.searchUrl)"
          @keyup.enter="handleSearchUrl(sougou.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(sougou.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane label="多吉" :name="doge.value">
        <el-autocomplete
          v-model="content"
          placeholder="DogeDoge 检索"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSearchUrl(doge.searchUrl)"
          @keyup.enter="handleSearchUrl(doge.searchUrl)"
          :fetch-suggestions="handleSearchData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl(doge.searchUrl)"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
      <el-tab-pane label="站内" name="site">
        <el-autocomplete
          v-model="content"
          placeholder="站内搜索，支持名称和描述"
          prefix-icon="Search"
          style="width: 100%"
          size="large"
          class="search-input"
          @select="handleSelectSearchSiteUrl"
          @keyup.enter="handleSearchUrl('/search/')"
          :fetch-suggestions="handleSearchSiteData"
        >
          <template #append>
            <el-button type="primary" @click="handleSearchUrl('/search/')"
              >搜索</el-button
            >
          </template>
        </el-autocomplete>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script setup>
import { getCurrentInstance, ref } from 'vue'
import jsonp from 'jsonp'

import { siteList } from '@/api/client/search'
import { updateClickCount } from '@/api/nav/site'
import { openSite } from '@/utils/geshanzsq'

const { proxy } = getCurrentInstance()

const searchType = ref('baidu')
const content = ref()
const options = ref({
  timeout: 10000,
  name: 'searchCallback'
})

const baidu = ref({
  value: 'baidu',
  searchUrl: 'https://www.baidu.com/s?wd=',
  queryUrl: 'https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su?wd='
})
const bing = ref({
  value: 'bing',
  searchUrl: 'https://cn.bing.com/search?q=',
  queryUrl: 'https://api.bing.com/qsonhs.aspx?type=cb&q='
})
const google = ref({
  value: 'google',
  searchUrl: 'https://www.google.com/search?q=',
  queryUrl: 'https://www.google.com/complete/search?client=youtube&q='
})
// 未实现
const baiduDev = ref({
  value: 'baiduDev',
  searchUrl: 'https://kaifa.baidu.com/searchPage?wd='
  // queryUrl: 'https://kaifa.baidu.com/rest/v1/recommend/suggests?wd='
})
// 未实现
const magi = ref({
  value: 'magi',
  searchUrl: 'https://magi.com/search?q='
  // queryUrl: 'https://magi.com/suggest?q='
})
const haosou = ref({
  value: 'haosou',
  searchUrl: 'https://www.so.com/s?q=',
  queryUrl: 'https://sug.so.360.cn/suggest?word='
})
const sougou = ref({
  value: 'sougou',
  searchUrl: 'https://www.sogou.com/web?query='
  // queryUrl: 'https://www.sogou.com/suggnew/ajajjson?type=web&key='
})
// 未实现
const doge = ref({
  value: 'doge',
  searchUrl: 'https://www.dogedoge.com/results?q='
  // queryUrl: 'https://www.dogedoge.com/sugg/'
})

/**
 * 获取搜索推荐的内容
 */
function handleSearchData(searchContent, cb) {
  if (searchContent === '') {
    const result = []
    cb(result)
    return
  }

  let url = ''
  if (searchType.value === doge.value.value) {
    // 多吉搜索
    url = doge.value.queryUrl + searchContent
    const result = []
    cb(result)
    return
  } else {
    // 其他搜索
    const queryUrl = getSearchDataUrl()
    // 没有搜索提示
    if (!queryUrl) {
      const result = []
      cb(result)
      return
    }
    url = queryUrl + searchContent + '&cb=searchCallback'
  }
  jsonp(url, options.value, (responseData) => {
    if (responseData.message === 'Timeout') {
      const result = []
      cb(result)
      return
    }
    setSearchData(responseData, cb)
  })

  /**
   * 回调
   */
  window.searchCallback = (responseData) => {
    setSearchData(responseData, cb)
  }
}

/**
 * 获取查询数据的地址
 */
function getSearchDataUrl() {
  switch (searchType.value) {
    case baidu.value.value:
      return baidu.value.queryUrl
    case bing.value.value:
      return bing.value.queryUrl
    case google.value.value:
      return google.value.queryUrl
    case baiduDev.value.value:
      return baiduDev.value.queryUrl
    case magi.value.value:
      return magi.value.queryUrl
    case haosou.value.value:
      return haosou.value.queryUrl
    case sougou.value.value:
      return sougou.value.queryUrl
    case doge.value.value:
      return doge.value.queryUrl
  }
  return ''
}

/**
 * 设置搜索推荐的内容
 */
function setSearchData(responseData, cb) {
  console.log(responseData)
  const searchList = []
  switch (searchType.value) {
    // 百度
    case baidu.value.value: {
      responseData.s.forEach((s) => {
        searchList.push({ value: s })
      })
      break
    }
    // 微软 Bing
    case bing.value.value: {
      responseData.AS.Results.forEach((r) => {
        r.Suggests.forEach((s) => {
          searchList.push({ value: s.Txt })
        })
      })
      break
    }
    // google
    case google.value.value: {
      if (responseData.length < 2) {
        break
      }
      responseData[1].forEach((s) => {
        this.searchList.push({ value: s[0] })
      })
      break
    }
    // 360 好搜
    case haosou.value.value: {
      responseData.result.forEach((s) => {
        searchList.push({ value: s.word })
      })
      break
    }
    // 搜狗
    case sougou.value.value: {
      if (responseData.length < 2) {
        break
      }
      responseData[1].forEach((s) => {
        searchList.push({ value: s })
      })
      break
    }
    // 多吉
    case doge.value.value: {
      responseData.forEach((s) => {
        searchList.push({ value: s })
      })
      break
    }
  }
  cb(searchList)
}

/**
 * 搜索按钮或选择事件
 */
function handleSearchUrl(url) {
  if (!content.value) {
    proxy.$modal.msgWarning('请输入需要搜索的内容')
    return
  }
  openSite(url + content.value)
}

/**
 * 点击站内搜索的网站
 */
function handleSelectSearchSiteUrl(site) {
  // 设置输入框内容为之前输入的内容，否则点击后会取 value 值
  content.value = site.searchContent
  openSite(site.siteUrl)
  // 更新点击量
  updateClickCount(site.id)
}

/**
 * 搜索站内网站
 */
async function handleSearchSiteData(searchContent, cb) {
  const searchList = []
  if (!searchContent) {
    cb(searchList)
    return
  }
  const { data } = await siteList(content.value)
  data.forEach((site) => {
    searchList.push({
      id: site.id,
      searchContent: searchContent,
      siteUrl: site.siteUrl,
      value:
        '【' +
        site.categoryName +
        '】' +
        site.siteName +
        '-' +
        site.siteDescription
    })
  })
  cb(searchList)
}
</script>
<style lang="scss" scoped></style>

<style lang="scss">
.search {
  .search-input {
    .el-input-group__append {
      background-color: var(--el-color-primary);
      color: var(--el-color-white);
      border-radius: var(--el-border-radius-base);
      width: 70px;
    }
  }
}
</style>
