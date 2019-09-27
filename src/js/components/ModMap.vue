<template>
  <fullscreen ref="fullscreen" @change="handleFullScreenChange">
    <div
      v-if="place.loaded && place.maps && place.maps.length"
      class="w-full flex flex-col justify-center"
      :style="`max-height: ${isFullScreen ? 100 : 40}vh;`"
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
        <template v-for="(map, i) in place.maps">
          <img
            class="w-full"
            :key="i"
            :ref="`map-${i}`"
            :v-show="selectedMapIndex === i"
            :style="`transform: scale(${zoom}) translate(${translateX}px, ${translateY}px); transition: all .25s ease-in-out;`"
            :src="map.image"
            @load="centerMap(map, i)"
            draggable="false"
          />
        </template>
      </div>

      <div v-if="buttons" class="flex items-center justify-between mt-4" style="flex: 2;">
        <div>
          <button
            class="py-2 px-4 uppercase border"
            :style="styles.buttons.campus"
          >Campus Map</button>
          <button
            class="py-2 px-4 uppercase border"
            :style="styles.buttons.building"
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
          <!--button
            class="ml-2 text-gray-600 outline-none focus:outline-none"
            style="width: 28px;"
            @click="toggleFullScreen()"
          >
            <svg
              aria-hidden="true"
              focusable="false"
              data-prefix="fas"
              data-icon="compress-wide"
              class="svg-inline--fa fa-compress-wide fa-w-16"
              role="img"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
            >
              <path
                fill="currentColor"
                d="M500 224H376c-13.3 0-24-10.7-24-24V76c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v84h84c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12zm-340-24V76c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v84H12c-6.6 0-12 5.4-12 12v40c0 6.6 5.4 12 12 12h124c13.3 0 24-10.7 24-24zm0 236V312c0-13.3-10.7-24-24-24H12c-6.6 0-12 5.4-12 12v40c0 6.6 5.4 12 12 12h84v84c0 6.6 5.4 12 12 12h40c6.6 0 12-5.4 12-12zm256 0v-84h84c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12H376c-13.3 0-24 10.7-24 24v124c0 6.6 5.4 12 12 12h40c6.6 0 12-5.4 12-12z"
              />
            </svg>
          </button-->
        </div>
      </div>
    </div>
  </fullscreen>
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
    },
    buttons: {
      type: Boolean,
      default: true,
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

      selectedMapIndex: 0,
      isFullScreen: false
    };
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    colors() {
      return this.theme.colors;
    },
    styles() {
      const onCampus = this.$route.path.includes('campus');

      const buttonStyles = [
        `color: ${this.colors.primary}`,
        `border-color: ${this.colors.primary}`,
      ].join(";")

      const buttonStylesActive = [
        `color: white`,
        `border-color: ${this.colors.primary}`,
        `background-color: ${this.colors.primary}`
      ].join(";");

      return {
        buttons: {
          campus: onCampus ? buttonStylesActive : buttonStyles,
          building: onCampus ? buttonStyles : buttonStylesActive
        }
      }
    }
  },
  methods: {
    handleFullScreenChange(fullscreen) {
      this.isFullScreen = fullscreen;
      this.centerMap();
    },
    toggleFullScreen() {
      this.$refs.fullscreen.toggle();
    },
    centerMap(map, index) {
      return;
      // Use first marker in provided collection
      let marker = map.markers[0];
      // Get bounding box for map container and map image
      let image = this.$refs[`image-${index}`].getBoundingClientRect();
      let container = this.$refs.container.getBoundingClientRect();

      // Figure out how much taller the image is than the container (%)
      let imageTallerBy = (image.height / this.zoom - container.height) / 100;

      // Figure out the center for the container
      const containerX = container.width / 2;
      const containerY = container.height / 2;

      if (!marker) {
        // If there is not marker, just center image within the container
        this.translateX = containerX - image.width / (2 * this.zoom);
        this.translateY = containerY - image.height / (2 * this.zoom);

        return;
      }

      const width = (marker.x / 100) * (image.width / this.zoom);
      const height = (marker.y / 100) * (image.height / this.zoom);

      this.translateX = containerX - width;
      this.translateY =
        containerY +
        (imageTallerBy / 100) * container.height * this.zoom -
        height;
    },
    getSelectedMap() {
      if (this.place.maps && this.place.maps.length) {
        return this.place.maps[this.selectedMapIndex];
      }

      return null;
    },

    zoomMap(direction) {
      this.zoom + this.zoomFactor * direction < 10 &&
      this.zoom + this.zoomFactor * direction >= 0.5
        ? (this.zoom += this.zoomFactor * direction)
        : null;
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
