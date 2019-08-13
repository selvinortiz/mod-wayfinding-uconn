<template>
  <div class="w-full relative">
    <img class="mx-auto" :src="imgUrl" alt />
    <img class="mx-auto" :src="pinUrl" alt />
    <div class="absolute bottom-1/4 right-0 w-1/6 bg-gray-200 p-4 rounded" @click="swithMap()">
      <img class :src="thumbnailUrl" alt />
    </div>
  </div>
</template>

<style>
</style>

<script>
export default {
  props: {
    imgUrl: {
      type: String,
      default: "../../img/map_placeholder.png"
    },
    pinUrl: {
      type: String,
      default: "../../img/pin_placeholder.png"
    },
    thumbnailUrl: {
      type: String,
      default: "../../img/map2_placeholder.png"
    }
  },
  methods: {
    swithMap() {
      const imgUrl = this.imgUrl;
      const thumbnailUrl = this.thumbnailUrl;
      this.imgUrl = thumbnailUrl;
      this.thumbnailUrl = imgUrl;
    }
  }
};
</script>