<template>
  <div
    class="@SLIDES absolute w-screen h-screen overflow-hidden bg-cover bg-center animated fadeIn"
    :style="styles"
  />
</template>

<script>
let interval;

export default {
  props: {
    slideDuration: {
      type: Number,
      default: 7500
    },
    animationDuration: {
      type: String,
      default: "1.25s"
    }
  },
  data() {
    return {
      activeSlideIndex: 0
    };
  },
  computed: {
    images() {
      return this.$store.state.app.settings.images;
    },
    activeSlide() {
      return this.images[this.activeSlideIndex]
    },
    styles() {
      return [
        `animation-duration: 3s`,
        `transition: background ${this.animationDuration} linear`,
        `background-image: url(${this.activeSlide.url})`
      ].join(";");
    }
  },
  mounted() {
    if (!this.$store.state.app.isMobile) {
      interval = setInterval(this.slide, this.slideDuration);
    }
  },
  beforeDestroy() {
    if (interval) {
      clearInterval(interval);
    }
  },
  methods: {
    slide() {
      if (this.images && this.images.length > 1) {
        let nextSlideIndex = this.activeSlideIndex + 1;

        if (nextSlideIndex >= this.images.length) {
          nextSlideIndex = 0;
        }

        this.activeSlideIndex = nextSlideIndex;
      }
    }
  }
}
</script>
