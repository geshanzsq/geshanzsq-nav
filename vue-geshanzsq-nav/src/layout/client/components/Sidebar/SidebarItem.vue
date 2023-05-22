<template>
  <div>
    <template v-if="!hasChild(item)">
      <el-menu-item
        :class="{ 'submenu-title-noDropdown': !isNest }"
        :index="item.id"
        @click="handlePosition('category-' + item.id)"
      >
        <svg-icon :icon-name="item.categoryIcon" />
        <template #title
          ><span class="menu-title">{{ item.categoryName }}</span></template
        >
      </el-menu-item>
    </template>

    <el-sub-menu v-else ref="subMenu" popper-append-to-body :index="item.id">
      <template #title>
        <svg-icon :icon-name="item.categoryIcon" />
        <span class="menu-title">{{ item.categoryName }}</span>
      </template>

      <sidebar-item
        v-for="child in item.children"
        :key="child.id"
        :is-nest="true"
        :item="child"
        class="nest-menu"
      />
    </el-sub-menu>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

import { scrollTo } from '@/utils/scroll-to'

defineProps({
  // route object
  item: {
    type: Object,
    required: true
  }
})

const store = useStore()
const router = useRouter()

// 是否移动端
const isMobile = computed(() => store.getters['app/isMobile'])
// 是否固定头部
const fixedHeader = computed(() => store.getters['settings/fixedHeader'])

/**
 * 是否有子分类
 */
function hasChild(category) {
  if (
    category.children === null ||
    category.children === undefined ||
    category.children.length === 0
  ) {
    return false
  }
  return true
}

/**
 * 瞄点定位
 */
function handlePosition(id) {
  try {
    const e = document.querySelector('#' + id)
    const top = e.offsetTop - 60
    const topTime = 400
    // 移动端
    if (isMobile.value) {
      store.dispatch('app/closeSideBar', { withoutAnimation: false })
      scrollTo(top, topTime)
    } else if (!fixedHeader.value) {
      // 不是移动端，且头部不固定时，使用这个动画比较好
      e.scrollIntoView({ behavior: 'smooth' })
    } else {
      // 不是移动端并且固定时，
      const top = e.offsetTop - 60
      scrollTo(top, topTime)
    }
  } catch (e) {
    console.error(e)
    router.push('/')
  }
}
</script>
