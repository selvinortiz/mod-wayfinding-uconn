<template>
  <div>
    <button @click="zoomIn">Zoom In</button>
    <div ref="imageContainer" class="imageContainer">
      <img
        ref="imageRendered"
        src="/img/campus.png"
        style="width: 100%;"
        :style="{'transform': `scale(${zoom}) translate(${translateX + '%'}, ${translateY + '%'})`}"
        alt="Map"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    id: {
      type: Number | String,
      default: 0
    },
    title: {
      type: String,
      default: ""
    }
  },
  data() {
    return {
      zoom: 1,
      zoomFactor: 0.5,
      translateX: 0,
      translateY: 0,
    }
  },
  methods: {
    zoomIn() {
      this.zoom < 9 ? (this.zoom += this.zoomFactor) : null;
    }
  }
};
</script>
