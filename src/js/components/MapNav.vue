<template>
  <section class="flex justify-between">
    <div>
      <button
        v-if="buttons"
        class="py-2 px-4 uppercase border outline-none focus:outline-none"
        :style="styles.buttons.normal"
        @click="$emit('select-campus-map')"
      >Campus Map</button>
      <button
        v-if="buttons"
        class="ml-4 py-2 px-4 uppercase border outline-none focus:outline-none"
        :style="styles.buttons.active"
        @click="$emit('select-building-map')"
      >Building Map</button>
    </div>
    <div class="self-end">
      <button
        class="ml-4 text-gray-600 outline-none focus:outline-none"
        style="width: 32px;"
        @click="$emit('zoom-in')"
      >
        <svg
          aria-hidden="true"
          focusable="false"
          data-prefix="fas"
          data-icon="search-plus"
          class="svg-inline--fa fa-search-plus fa-w-16"
          role="img"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            fill="currentColor"
            d="M304 192v32c0 6.6-5.4 12-12 12h-56v56c0 6.6-5.4 12-12 12h-32c-6.6 0-12-5.4-12-12v-56h-56c-6.6 0-12-5.4-12-12v-32c0-6.6 5.4-12 12-12h56v-56c0-6.6 5.4-12 12-12h32c6.6 0 12 5.4 12 12v56h56c6.6 0 12 5.4 12 12zm201 284.7L476.7 505c-9.4 9.4-24.6 9.4-33.9 0L343 405.3c-4.5-4.5-7-10.6-7-17V372c-35.3 27.6-79.7 44-128 44C93.1 416 0 322.9 0 208S93.1 0 208 0s208 93.1 208 208c0 48.3-16.4 92.7-44 128h16.3c6.4 0 12.5 2.5 17 7l99.7 99.7c9.3 9.4 9.3 24.6 0 34zM344 208c0-75.2-60.8-136-136-136S72 132.8 72 208s60.8 136 136 136 136-60.8 136-136z"
          />
        </svg>
      </button>
      <button
        class="ml-4 text-gray-600 outline-none focus:outline-none"
        style="width: 32px;"
        @click="$emit('zoom-out')"
      >
        <svg
          aria-hidden="true"
          focusable="false"
          data-prefix="fas"
          data-icon="search-minus"
          class="svg-inline--fa fa-search-minus fa-w-16"
          role="img"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            fill="currentColor"
            d="M304 192v32c0 6.6-5.4 12-12 12H124c-6.6 0-12-5.4-12-12v-32c0-6.6 5.4-12 12-12h168c6.6 0 12 5.4 12 12zm201 284.7L476.7 505c-9.4 9.4-24.6 9.4-33.9 0L343 405.3c-4.5-4.5-7-10.6-7-17V372c-35.3 27.6-79.7 44-128 44C93.1 416 0 322.9 0 208S93.1 0 208 0s208 93.1 208 208c0 48.3-16.4 92.7-44 128h16.3c6.4 0 12.5 2.5 17 7l99.7 99.7c9.3 9.4 9.3 24.6 0 34zM344 208c0-75.2-60.8-136-136-136S72 132.8 72 208s60.8 136 136 136 136-60.8 136-136z"
          />
        </svg>
      </button>
    </div>
  </section>
</template>

<script>
export default {
  props: {
    buttons: {
      type: Boolean,
      default: true
    }
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    colors() {
      return this.theme.colors;
    },
    styles() {
      const onCampus = this.$route.path.includes("campus");

      const buttonStyles = [
        `color: ${this.colors.primary}`,
        `border-color: ${this.colors.primary}`
      ].join(";");

      const buttonStylesActive = [
        `color: white`,
        `border-color: ${this.colors.primary}`,
        `background-color: ${this.colors.primary}`
      ].join(";");

      return {
        buttons: {
          normal: buttonStyles,
          active: buttonStylesActive
        }
      };
    }
  }
};
</script>
