<template>
  <div v-if="photo && photo.url">
    <img class="h-auto xl:h-64 lg:h-48 md:h-48 sm:h-48 w-full object-cover" :src="photo.url" />
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
