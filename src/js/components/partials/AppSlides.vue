<template>
  <div
    class="absolute w-screen h-screen overflow-hidden bg-cover bg-center animated fadeIn"
    :style="`animation-duration: 3s;transition: background ${animationDuration} linear; background-image: url(${activeSlide.url});`"
  ></div>
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
      return this.images[this.activeSlideIndex];
    }
  },
  mounted() {
    interval = setInterval(this.slide, this.slideDuration);
  },
  beforeDestroy() {
    if (interval) {
      clearInterval(interval);
    }
  },

  methods: {
    slide() {
      if (this.images.length > 1) {
        let nextSlideIndex = this.activeSlideIndex + 1;

        if (nextSlideIndex >= this.images.length) {
          nextSlideIndex = 0;
        }

        this.activeSlideIndex = nextSlideIndex;
      }
    }
  }
};
</script>
