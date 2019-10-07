<template>
  <div class="@logo">
    <router-link :to="{ name: 'index' }">
      <img :src="logo.url" alt />
    </router-link>
  </div>
</template>

<style scoped>
img {
  width: auto;
  max-height: 64px;
}

@media screen and (min-width: 720px) {
  img {
    max-height: 90px;
  }
}
</style>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme
    },
    logo() {
      return this.theme.header.logo
    }
  }
}
</script>
