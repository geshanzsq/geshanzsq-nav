<template>
  <div class="app-container">
    <el-row :gutter="24" class="panel-group">
      <el-col :sm="6" :xs="24">
        <router-link to="/nav/category">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-message">
              <svg-icon icon-name="menu" class-name="card-panel-icon" />
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">系统网站分类数</div>
              <div class="card-panel-num">{{ dataCount.categoryCount }}</div>
            </div>
          </div>
        </router-link>
      </el-col>
      <el-col :sm="6" :xs="24">
        <router-link to="/nav/site">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-money">
              <svg-icon icon-name="website" class-name="card-panel-icon" />
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">系统网站数</div>
              <div class="card-panel-num">{{ dataCount.siteCount }}</div>
            </div>
          </div>
        </router-link>
      </el-col>
      <el-col :sm="6" :xs="24">
        <router-link to="/nav/site">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-shopping">
              <svg-icon icon-name="click" class-name="card-panel-icon" />
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">系统网站点击量数</div>
              <div class="card-panel-num">{{ dataCount.siteClickCount }}</div>
            </div>
          </div>
        </router-link>
      </el-col>
    </el-row>
  </div>
</template>
<script setup>
import { ref } from 'vue'

import { getStatistics } from '@/api/nav/index'

const loading = ref(true)
const dataCount = ref({
  categoryCount: 0,
  siteCount: 0,
  siteClickCount: 0
})

/**
 * 获取数据
 */
async function getData() {
  loading.value = true
  const { data } = await getStatistics()
  dataCount.value = data
  loading.value = false
}

getData()
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 32px;
  }

  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    border-color: rgba(0, 0, 0, 0.05);

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #40c9c6;
      }

      .icon-message {
        background: #36a3f7;
      }

      .icon-money {
        background: #f4516c;
      }

      .icon-shopping {
        background: #34bfa3;
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-message {
      color: #36a3f7;
    }

    .icon-money {
      color: #f4516c;
    }

    .icon-shopping {
      color: #34bfa3;
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }

      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}

@media (max-width: 550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
