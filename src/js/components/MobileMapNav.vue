<template>
  <section class="flex justify-between px-2">
    <div>
      <button
        v-if="buttons"
        class="mr-4 py-2 px-4 uppercase border-2 outline-none focus:outline-none"
        :style="selectedMapType === 'campus' ? styles.buttons.active : styles.buttons.normal"
        @click="$emit('select-campus-map')"
      >Campus Map</button>
      <button
        v-if="buttons"
        class="mr-4 py-2 px-4 uppercase border-2 outline-none focus:outline-none"
        :style="selectedMapType === 'building' ? styles.buttons.active : styles.buttons.normal"
        @click="$emit('select-building-map')"
      >Building Map</button>
    </div>
  </section>
</template>

<script>
export default {
  props: {
    buttons: {
      type: Boolean,
      default: true
    },
    selectedMapType: {
      type: String,
      required: true
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
