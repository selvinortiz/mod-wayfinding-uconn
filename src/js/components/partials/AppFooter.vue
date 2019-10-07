<template>
  <section class="@end flex flex-1 items-center justify-between text-center text-white">
    <div class="py-2 px-16 flex items-end">
      <p class="flex flex-no-wrap items-end text-base leading-none">
        <img class="px-2" style="max-height: 64px;" src="/static/icons/qr.png" alt="">
        <span class="text-left">
          <span class="block text-lg uppercase">Info to go!</span>
          <span class="block text-sm">Scan the QR Code to download the UCONN&nbsp;App</span>
        </span>
      </p>
    </div>
    <div class="hidden py-2 px-8">
      <a v-if="showAdaToggle" @click="toggleAdaMode" class="flex items-end text-base leading-none">
        <span class="px-4 text-right">Tap for improved ADA accessability</span>
        <img style="max-height: 32px;" src="/static/icons/ada.svg" />
      </a>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      adaModeEnabled: false
    }
  },
  computed: {
    showAdaToggle() {
      return !this.$store.state.app.isMobile
    }
  },
  methods: {
    toggleAdaMode() {
      this.adaModeEnabled = !this.adaModeEnabled

      if (this.adaModeEnabled) {
        alert('Our random disability generator says: "Hello 👋."');

        this.adaModeEnabled = false;
      }
    }
  }
}
</script>
