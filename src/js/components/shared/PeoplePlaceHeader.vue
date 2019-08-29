<template>
    <div :class="'w-full flex-wrap justify-center p-4 mb-4 '+classes"
    style="outline: 1px red solid">
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
    },

    primaryColor: {
      type: String,
      default: null
    }
  }
}
</script>