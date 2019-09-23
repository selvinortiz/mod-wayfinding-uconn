<template>
  <content-iframe v-if="src" class="wrapper" :src="src"></content-iframe>
</template>

<style>
.wrapper,
iframe {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
</style>

<script>
export default {
  computed: {
    src() {
      return this.$route.query.url;
    }
  }
};
</script>
