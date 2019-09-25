<template>
  <div>
    <h2 class="pb-2 font-thin text-4xl" :style="styles.defaultColor">
      <slot></slot>
    </h2>
  </div>
</template>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";")
      };
    }
  }
};
</script>

<style lang="scss" scoped>
</style>