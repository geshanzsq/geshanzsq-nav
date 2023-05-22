<template>
  <div
    v-if="hasExternal"
    :style="styleExternalIcon"
    class="svg-external-icon svg-icon"
  />
  <svg v-else :class="svgClass" aria-hidden="true">
    <use :xlink:href="internalIconName" />
  </svg>
</template>
<script setup>
import { computed } from 'vue'
import { isExternal } from '@/utils/validate'
const props = defineProps({
  // icon 图标
  iconName: {
    type: String,
    required: true
  },
  // 图标类名
  className: {
    type: String,
    default: ''
  }
})

/**
 * 判断是否为外部资源
 */
const hasExternal = computed(() => isExternal(props.iconName))

/**
 * 外部图标样式
 */
const styleExternalIcon = computed(() => ({
  mask: `url(${props.iconName}) no-repeat 50% 50%`,
  '-webkit-mask': `url(${props.iconName}) no-repeat 50% 50%`
}))

/**
 * 内部图标
 */
const internalIconName = computed(() => `#icon-${props.iconName}`)

/**
 * 样式设置
 */
const svgClass = computed(() =>
  props.className ? 'svg-icon ' + props.className : 'svg-icon'
)
</script>

<style scoped>
.svg-icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}

.svg-external-icon {
  background-color: currentColor;
  mask-size: cover !important;
  display: inline-block;
}
</style>
