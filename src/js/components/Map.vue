<template>
  <section class="flex flex-col">
    <div
      v-if="map"
      class="@CONTAINER relative flex items-center justify-center overflow-hidden bg-white shadow-lg"
      style="height: 40vh;"
      draggable="false"
    >
      <img
        alt
        class="@IMAGE"
        draggable="false"
        :src="map.activeImage.src"
        :style="styles.image"
        @pointerdown="handleDragStart($event)"
        @pointermove="handleDrag($event)"
        @pointerup="handleDragStop()"
        @pointerleave="handleDragStop()"
      />

      <div class="absolute top-0 right-0 m-4 p-4 text-right bg-white shadow opacity-95">
        <h1 class="font-bold">{{ map.activeImage.title || map.title }}</h1>
        <h2>{{ map.activeImage.subtitle || map.subtitle }}</h2>
      </div>

      <div v-if="map.thumbnailImage" class="absolute bottom-0 right-0 m-4 p-2 bg-gray-100 shadow-md opacity-95">
        <img
          alt
          class="@THUMB w-full"
          style="max-width: 125px;"
          draggable="false"
          :src="map.thumbnailImage.src"
          @click="toggleMapImage()"
        />
      </div>
    </div>
    <map-nav
      class="pt-4"
      :buttons="buttons"
      :selected-map-type="map.type"
      @zoom-in="zoomIn"
      @zoom-out="zoomOut"
      @reset-map="reset"
      @select-campus-map="selectCampusMap"
      @select-building-map="selectBuildingMap"
    />
  </section>
</template>

<script>
import MapNav from "./MapNav.vue";

export default {
  props: {
    maps: {
      type: Array,
      required: true
    },
    buttons: {
      type: Boolean,
      default: true,
    },
    primaryMap: {
      type: String,
      default: 'campus'
    }
  },
  components: {
    MapNav
  },
  data: () => ({
    zoomBy: 0.5,
    selectedMap: null,
    selectedMapImage: null
  }),
  computed: {
    map() {
      if (!this.selectedMap) {
        let index = this.maps.findIndex((map) => map.type === this.primaryMap);

        if (index === -1) {
          index = 0;
        }

        this.setSelectedMap(this.maps[index] || {});
      }

      return this.selectedMap;
    },
    styles() {
      return {
        image: [
          `transform: scale(${this.map.zoom}) translate(${this.map.translate.x}px, ${this.map.translate.y}px)`,
          `transition: ${
            this.map.drag.active ? "none" : "all"
          } .25s ease-in-out`,
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
      this.setSelectedMap(this.maps[0]);
    },
    selectBuildingMap() {
      this.setSelectedMap(this.maps[1]);
    },
    setSelectedMap(map) {
      this.selectedMap = map;

      if (!this.selectedMap.hasOwnProperty("zoom")) {
        this.$set(this.selectedMap, "zoom", 1);
      }

      if (!this.selectedMap.hasOwnProperty("defaultZoom")) {
        this.$set(this.selectedMap, "defaultZoom", this.selectedMap.zoom);
      }

      if (!this.selectedMap.hasOwnProperty("translate")) {
        this.$set(this.selectedMap, "translate", { x: 0, y: 0 });
      }

      if (!this.selectedMap.hasOwnProperty("drag")) {
        this.$set(this.selectedMap, "drag", { x: 0, y: 0, active: false });
      }

      if (!this.selectedMap.hasOwnProperty("activeImage")) {
        this.$set(this.selectedMap, "activeImage", this.selectedMap.images[0]);
      }
      if (
        !this.selectedMap.hasOwnProperty("thumbnailImage") &&
        this.selectedMap.images.length > 1
      ) {
        this.$set(
          this.selectedMap,
          "thumbnailImage",
          this.selectedMap.images[1]
        );
      }
    },
    toggleMapImage() {
      const activeImage = {
        ...this.map.thumbnailImage
      };

      const thumbnailImage = {
        ...this.map.activeImage
      };

      this.$set(this.map, "activeImage", activeImage);
      this.$set(this.map, "thumbnailImage", thumbnailImage);
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
