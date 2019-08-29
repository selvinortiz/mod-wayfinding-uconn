<template>
    <div :class="'w-full justify-center '+classes">
        <div class="w-11/12 mb-4">
        <div :class="'text-3xl text-'+primaryColor+' font-300'">WAYFINDING</div>
        <div :class="'text-1xl text-'+primaryColor">
            {{ 'Breadcrumb nav 1' }}
            >
            {{ 'Breadcrumb nav 2' }}
        </div>
        </div>
    </div>
</template>

<script>
export default {
  props: {
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