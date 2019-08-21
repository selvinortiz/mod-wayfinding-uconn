<template>
  <div>
    
    <div id="imageContainer" class="imageContainer" @mousedown="startDrag($event)" @mousemove="dragMap($event)" @mouseup="stopDrag()" @mouseleave="stopDrag()">

      <img
        id="image" class="image"
        :src="images[0]"
        :style="{'transform': `scale(${zoom}) translate(${translateX + 'px'}, ${translateY + 'px'})`}"
        draggable="false"
        alt="Map"
      />

    </div>

    <button @click="zoomMap(1)">Zoom In</button>
    <button @click="zoomMap(-1)">Zoom Out</button>

    <div class="altImage" v-for="(image, index) in images" :key="image+index"
    :src="images[index]" :alt="'Map'+index" draggable="false">
      {{image}}
    </div>

  </div>
</template>

<style>
  @import "./style.scss";
</style>

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
    },
    images: {
      type: Array,
      default: function () {
        return ['']
      }
    }
  },
  data() {
    return {
      zoom: 1,
      zoomFactor: 0.5,
      translateX: 0,
      translateY: 0,

      drag: false,
      dragX: null,
      dragY: null
    }
  },
  methods: {
    zoomMap(direction) {
      this.zoom + this.zoomFactor * direction < 4 && this.zoom + this.zoomFactor * direction >= 1 ? (this.zoom += this.zoomFactor * direction) : null;
      
      if (direction == -1) {
        var imageContainer = document.getElementById('imageContainer').getBoundingClientRect();
        var image = document.getElementById('image').getBoundingClientRect();

        if (image.x > imageContainer.x)
          image.x = imageContainer.x;

        if (image.y > imageContainer.y)
          image.y = imageContainer.y;

        this.translateX = 0;
        this.translateY = 0;
      }
    },

    startDrag(event) {
      this.drag = true;
      this.dragX = event.x;
      this.dragY = event.y;
    },
    dragMap(event) {
      if (this.drag) {
        
        var diffX = event.x - this.dragX;
        var diffY = event.y - this.dragY;

        var imageContainer = document.getElementById('imageContainer').getBoundingClientRect();
        var image = document.getElementById('image').getBoundingClientRect();

        if (diffX > 0)
          image.x + diffX <= imageContainer.x ? (this.translateX += diffX) : null;
        else if (diffX < 0)
          image.x + image.width >= imageContainer.x + imageContainer.width ? (this.translateX += diffX) : null;

        if (diffY > 0)
          image.y + diffY <= imageContainer.y ? (this.translateY += diffY) : null;
        else if (diffY < 0)
          image.y + image.height >= imageContainer.y + imageContainer.height ? (this.translateY += diffY) : null;

        this.dragX = event.x;
        this.dragY = event.y;

      }
    },
    stopDrag() {
      this.drag = false;
    },
  }
};
</script>
