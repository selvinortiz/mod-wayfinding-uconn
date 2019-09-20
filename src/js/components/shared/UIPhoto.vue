<template>
  <div v-if="photo.url">
    <img width="100%" :src="photo.url" />
  </div>
</template>

<script>
export default {
  props: {
    photo: {
      type: Object,
      default: () => ({
        url: '',
        width: 0,
        height: 0
      })
    }
  }
}
</script>
