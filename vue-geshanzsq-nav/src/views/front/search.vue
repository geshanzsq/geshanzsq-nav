<template>
  <home :siteName="siteName"/>
</template>

<script>
  import home from "./home";
  export default {
    name: "search",
    components: {home},
    data() {
      return {
        siteName: ''
      }
    },
    created() {
      this.siteName = this.$route.params.siteName;
    }
  }
</script>

<style scoped>

</style>