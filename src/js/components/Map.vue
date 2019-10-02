<template>
  <section class="flex flex-col">
    <map-nav
      @zoom-in="zoomIn"
      @zoom-out="zoomOut"
    />
    <div ref="container" class="@MAP__CONTAINER overflow-hidden flex items-center justify-center" style="height: 600px;">
      <img
        ref="image"
        alt="Map Image"
        class="@MAP__IMAGE"
        draggable="false"
        :src="map.image.src"
        :style="`transform: scale(${zoom}) translate(${translate.x}px, ${translate.y}px); transition: ${drag.active ? 'none' : 'all'} .25s ease-in-out;`"
        @pointerdown="handleDragStart($event)"
        @pointermove="handleDrag($event)"
        @pointerup="handleDragStop()"
        @pointerleave="handleDragStop()"
      />
    </div>
  </section>
</template>

<script>
import MapNav from './MapNav.vue';

export default {
  props: {
    maps: {
      type: Array,
      required: true,
    }
  },
  components: {
    MapNav
  },
  data: () => ({
    zoom: 1,
    zoomBy: .5,
    translate: {
      x: 0,
      y: 0,
      active: false,
    },
    drag: {
      x: 0,
      y: 0,
      active: false,
    },
    selectedMap: null,
  }),
  computed: {
    map() {
      if (!this.selectedMap) {
        this.selectedMap = this.maps[0]
      }

      return this.selectedMap;
    }
  },
  methods: {
    reset() {
      this.zoom = this.map.zoom;
      this.translate.x = 0;
      this.translate.y = 0;
      this.$refs.container.style.top = "0";
      this.$refs.container.style.left = "0";
    },
    zoomIn() {
      this.zoom < 16 ? (this.zoom += this.zoomBy) : null;
    },
    zoomOut() {
      this.zoom > .5 ? (this.zoom -= this.zoomBy) : null;
    },
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
