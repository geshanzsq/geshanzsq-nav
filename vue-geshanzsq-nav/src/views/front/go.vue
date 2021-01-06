<template>
  <Jump/>
</template>

<script>
  import Jump from "@/components/Jump/Jump";
  export default {
    name: "go",
    components: {Jump},
    data() {
      return {
        url: '',
      }
    },
    created() {
      this.url = this.$route.query.url;
      window.location.href = this.url;
    },
  }
</script>

<style lang="scss" scoped>
  
</style>