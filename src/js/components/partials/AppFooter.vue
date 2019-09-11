<template>
  <section class="flex flex-1 items-center justify-between text-center text-white">
    <div class="py-4 px-8 flex items-end">
      <p class="flex flex-no-wrap items-end text-base leading-none">
        <img class="px-2" style="max-height: 48px;" src="/static/icons/qr.png" alt="">
        <img class="px-2" style="max-height: 48px;" src="/static/icons/tap.svg" alt="">
        <span class="text-left">
          <span class="block uppercase">Info to go!</span>
          <span class="block text-xs">Scan the QR Code to download the UCONN&nbsp;app</span>
        </span>
      </p>
    </div>
    <div class="py-4 px-8">
      <a @click="toggleAdaMode" class="flex items-end text-base leading-none">
        <span class="px-4 text-right">Tap for improved ADA accessability</span>
        <img style="max-height: 48px;" src="/static/icons/ada.svg" />
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
