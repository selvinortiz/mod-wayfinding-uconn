<template>
  <section class="flex justify-between text-center uppercase text-white bg-gray-900">
    <div class="py-4 px-8">QR Code Stuff</div>
    <div class="py-4 px-8">ADA Stuff</div>
  </section>
</template>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return [
        `color: ${this.theme.footer.nav.item.text}`,
        `background-color: ${this.theme.footer.nav.item.bg}`
      ].join(";");
    }
  }
};
</script>
