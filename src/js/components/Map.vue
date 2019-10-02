<template>
  <section>
    <div ref="container" class="@MAP__CONTAINER">
      <img
        ref="image"
        alt="Map Image"
        class="@MAP__IMAGE"
        :src="image.src"
        :style="`transform: scale(${zoomLevel}) translate(${translate.x}px, ${translate.y}px)`"
        draggable="false"
        @pointerdown="handleDragStart($event)"
        @pointermove="handleDrag($event)"
        @pointerup="handleDragStop()"
      />
    </div>
  </section>
</template>

<script>
export default {
  props: {
    map: {
      type: Object,
      required: true,
    }
  },
  data: () => ({
    zoomLevel: 1,
    zoomFactor: 0.5,
    translate: {
      x: 0,
      y: 0,
      active: false,
    },
    drag: {
      x: 0,
      y: 0,
      active: false,
    }
  }),
  computed: {
    image() {
      return this.map.images[0]
    }
  },
  methods: {
    handleDrag() {
      if (this.drag.active) {
        var diffX = event.x - this.drag.x;
        var diffY = event.y - this.drag.y;

        this.translate.x += diffX;
        this.translate.y += diffY;

        this.drag.x = event.x;
        this.drag.y = event.y;
      }
    },
    handleDragStart() {
      this.drag = {
        x: event.x,
        y: event.y,
        active: true
      }
    },
    handleDragStop() {
      this.drag.active = false;
    }
  }
};
</script>
