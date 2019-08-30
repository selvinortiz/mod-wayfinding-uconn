<template>
  <div :class="'w-full flex-wrap pl-4 md:mb-4 '+classes">
    <div :class="'w-full text-3xl text-'+primaryColor+' font-300'">{{heading}}</div>
    <div :class="'w-full text-1xl text-'+primaryColor">
        {{ 'Breadcrumb nav 1' }}
        >
        {{ 'Breadcrumb nav 2' }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    heading: {
      type: String,
      default: null
    },

    classes: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      primaryColor: this.$store.state.app.theme.main.peoplePlaceHeader.text
    }
  }
}
</script>