<template>
  <div v-if="show">
    <iframe scrolling="no"
            src="https://tianqiapi.com/api.php?style=tm&skin=pitaya"
            frameborder="0" width="270" height="24" allowtransparency="true"></iframe>
  </div>
</template>

<script>
  export default {
    name: "Weather",
    props: {
      show: {
        type: Boolean,
        default: true
      }
    }
  }
</script>

<style scoped>

</style>