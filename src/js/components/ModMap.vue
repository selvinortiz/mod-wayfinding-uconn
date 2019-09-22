<template>
  <div
    v-if="place.loaded && place.maps.length"
    class="w-full flex flex-col justify-center overflow-hidden"
    style="max-height: 60vh;"
  >
    <div
      ref="container"
      class="overflow-hidden bg-gray-200 shadow"
      style="flex: 10; h-full"
      @pointerdown="startDrag($event)"
      @pointermove="dragMap($event)"
      @pointerup="stopDrag()"
      @pointerleave="stopDrag()"
    >
      <img
        ref="image"
        class="w-full"
        :style="{'transform': `scale(${zoom}) translate(${translateX + 'px'}, ${translateY + 'px'})`}"
        :src="getSelectedMap().image"
        @load="centerMap()"
        draggable="false"
      />
      <!--div v-if="place.loaded" class="w-1/6 absolute bottom-0 right-0">
        <img
          @click="() => selectedMap = map"
          v-for="(map, index) in place.maps"
          :key="index"
          class="w-full"
          :src="map.image"
          draggable="false"
        />
      </div-->
    </div>

    <div class="flex items-center justify-between mt-4" style="flex: 2;">
      <div>
        <button
          class="py-2 px-4 uppercase border text-white"
          :style="`border-color: ${colors.primary}; background-color: ${colors.primary}`"
        >Campus Map</button>
        <button
          class="py-2 px-4 uppercase border text-black"
          :style="`border-color: ${colors.primary};`"
        >Building Map</button>
      </div>
      <div>
        <button
          class="ml-2 text-gray-600 outline-none focus:outline-none"
          style="width: 28px;"
          @click="zoomMap(1)"
        >
          <svg
            aria-hidden="true"
            focusable="false"
            data-prefix="fas"
            data-icon="search-plus"
            class="svg-inline--fa fa-search-plus fa-w-16"
            role="img"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 512 512"
          >
            <path
              fill="currentColor"
              d="M304 192v32c0 6.6-5.4 12-12 12h-56v56c0 6.6-5.4 12-12 12h-32c-6.6 0-12-5.4-12-12v-56h-56c-6.6 0-12-5.4-12-12v-32c0-6.6 5.4-12 12-12h56v-56c0-6.6 5.4-12 12-12h32c6.6 0 12 5.4 12 12v56h56c6.6 0 12 5.4 12 12zm201 284.7L476.7 505c-9.4 9.4-24.6 9.4-33.9 0L343 405.3c-4.5-4.5-7-10.6-7-17V372c-35.3 27.6-79.7 44-128 44C93.1 416 0 322.9 0 208S93.1 0 208 0s208 93.1 208 208c0 48.3-16.4 92.7-44 128h16.3c6.4 0 12.5 2.5 17 7l99.7 99.7c9.3 9.4 9.3 24.6 0 34zM344 208c0-75.2-60.8-136-136-136S72 132.8 72 208s60.8 136 136 136 136-60.8 136-136z"
            />
          </svg>
        </button>
        <button
          class="ml-2 text-gray-600 outline-none focus:outline-none"
          style="width: 28px;"
          @click="zoomMap(-1)"
        >
          <svg
            aria-hidden="true"
            focusable="false"
            data-prefix="fas"
            data-icon="search-minus"
            class="svg-inline--fa fa-search-minus fa-w-16"
            role="img"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 512 512"
          >
            <path
              fill="currentColor"
              d="M304 192v32c0 6.6-5.4 12-12 12H124c-6.6 0-12-5.4-12-12v-32c0-6.6 5.4-12 12-12h168c6.6 0 12 5.4 12 12zm201 284.7L476.7 505c-9.4 9.4-24.6 9.4-33.9 0L343 405.3c-4.5-4.5-7-10.6-7-17V372c-35.3 27.6-79.7 44-128 44C93.1 416 0 322.9 0 208S93.1 0 208 0s208 93.1 208 208c0 48.3-16.4 92.7-44 128h16.3c6.4 0 12.5 2.5 17 7l99.7 99.7c9.3 9.4 9.3 24.6 0 34zM344 208c0-75.2-60.8-136-136-136S72 132.8 72 208s60.8 136 136 136 136-60.8 136-136z"
            />
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    place: {
      type: Object,
      default: () => ({
        id: 0,
        title: "",
        maps: [
          {
            image: "",
            markers: [{ x: 0, y: 0 }]
          }
        ],
        loaded: false
      })
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
      dragY: null,

      selectedMap: null
    };
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    colors() {
      return this.theme.colors;
    }
  },
  methods: {
    centerMap() {
      // Only run this part once at the start
      if (this.selectedMap && this.zoom > 1) {
        // Gather the smallest and largest cords for
        // finding the area encompassing all the markers
        var smallX = null,
          bigX = null,
          smallY = null,
          bigY = null;

        for (var ii = 0; ii < this.selectedMap.markers.length; ii++) {
          var marker = this.selectedMap.markers[ii];

          smallX == null || smallX > marker.x ? (smallX = marker.x) : null;
          bigX == null || bigX < marker.x ? (bigX = marker.x) : null;
          smallY == null || smallY > marker.y ? (smallY = marker.y) : null;
          bigY == null || bigY < marker.y ? (bigY = marker.y) : null;
        }

        // Use the relational amounts to convert to the cords for the new sized image
        var image = this.$refs.image.getBoundingClientRect();

        smallX = (smallX / 100) * image.width;
        bigX = (bigX / 100) * image.width;
        smallY = (smallY / 100) * image.height;
        bigY = (bigY / 100) * image.height;

        // Correct for the default xy of the image on page
        smallX += image.x;
        bigX += image.x;
        smallY += image.y;
        bigY += image.y;

        // Find the difference between the center of the marker encompassing area and the
        // center of the container to then translate the image to shair the same center
        var container = this.$refs.container.getBoundingClientRect();

        var containerCenterX = container.x + container.width / 2;
        var containerCenterY = container.y + container.height / 2;

        var markerAreaCenterX = smallX + (bigX - smallX) / 2;
        var markerAreaCenterY = smallY + (bigY - smallY) / 2;

        this.translateX = -(markerAreaCenterX - containerCenterX);
        this.translateY = -(markerAreaCenterY - containerCenterY);
      }
    },

    getSelectedMap() {
      if (this.selectedMap == null) {
        this.selectedMap = this.place.maps[0];
      }

      return this.selectedMap;
    },

    zoomMap(direction) {
      this.zoom + this.zoomFactor * direction < 10 &&
      this.zoom + this.zoomFactor * direction >= 1
        ? (this.zoom += this.zoomFactor * direction)
        : null;

      // Direct the map back into covering the view port when zooming out near a boundary
      // if (direction == -1) {
      //   var container = this.$refs.container.getBoundingClientRect();
      //   var image = this.$refs.image.getBoundingClientRect();

      //   if (image.x > container.x) image.x = container.x;

      //   if (image.y > container.y) image.y = container.y;

      //   this.translateX = 0;
      //   this.translateY = 0;
      // }
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

        this.translateX += diffX;
        this.translateY += diffY;

        this.dragX = event.x;
        this.dragY = event.y;
      }
    },
    stopDrag() {
      this.drag = false;
    }
  }
};
</script>
