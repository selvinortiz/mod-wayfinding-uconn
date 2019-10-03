<template>
  <section class="flex flex-col">
    <map-nav
      @zoom-in="zoomIn"
      @zoom-out="zoomOut"
      @reset-map="reset"
      @select-campus-map="selectCampusMap"
      @select-building-map="selectBuildingMap"
    />
    <div class="@CONTAINER flex items-center justify-center overflow-hidden" style="height: 40vh;">
      <img
        alt
        class="@IMAGE"
        draggable="false"
        :src="map.image.src"
        :style="styles.image"
        @pointerdown="handleDragStart($event)"
        @pointermove="handleDrag($event)"
        @pointerup="handleDragStop()"
        @pointerleave="handleDragStop()"
      />
    </div>
  </section>
</template>

<script>
import MapNav from "./MapNav.vue";

export default {
  props: {
    maps: {
      type: Array,
      required: true
    }
  },
  components: {
    MapNav
  },
  data: () => ({
    zoomBy: 0.5,
    translate: {
      x: 0,
      y: 0,
      active: false
    },
    drag: {
      x: 0,
      y: 0,
      active: false
    },
    selectedMap: null
  }),
  computed: {
    map() {
      if (!this.selectedMap) {
        this.selectMap(this.maps[0]);
      }

      return this.selectedMap;
    },
    styles() {
      return {
        image: [
          `transform: scale(${this.map.zoom}) translate(${this.map.translate.x}px, ${this.map.translate.y}px)`,
          `transition: ${this.map.drag.active ? "none" : "all"} .25s ease-in-out`,
          `height: 100%`,
          `margin: auto`
        ].join(";")
      };
    }
  },
  methods: {
    reset() {
      this.map.zoom = this.map.defaultZoom;
      this.map.translate.x = 0;
      this.map.translate.y = 0;
    },
    zoomIn() {
      this.map.zoom < 16 ? (this.map.zoom += this.zoomBy) : null;
    },
    zoomOut() {
      this.map.zoom > 0.5 ? (this.map.zoom -= this.zoomBy) : null;
    },
    selectCampusMap() {
      this.selectMap(this.maps[0]);
    },
    selectBuildingMap() {
      this.selectMap(this.maps[1]);
    },
    selectMap(map) {
      this.selectedMap = {
        zoom: 1,
        translate: { x: 0, y: 0 },
        drag: { x: 0, y: 0, active: false },
        ...map
      };

      this.selectedMap.defaultZoom = this.selectedMap.zoom;
    },
    handleDrag() {
      if (this.map.drag.active) {
        var diffX = event.x - this.map.drag.x;
        var diffY = event.y - this.map.drag.y;

        this.map.translate.x += diffX;
        this.map.translate.y += diffY;

        this.map.drag.x = event.x;
        this.map.drag.y = event.y;
      }
    },
    handleDragStart() {
      this.map.drag = {
        x: event.x,
        y: event.y,
        active: true
      };
    },
    handleDragStop() {
      this.map.drag.active = false;
    }
  }
};
</script>
