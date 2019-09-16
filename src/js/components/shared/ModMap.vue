<template>
  <div v-if="place.maps" class="w-full">
    <div
      id="imageContainer"
      class="overflow-hidden relative mb-4"
      style="height: 50vh; outline: 1px gray solid"
      @mousedown="startDrag($event)"
      @mousemove="dragMap($event)"
      @mouseup="stopDrag()"
      @mouseleave="stopDrag()"
    >
      <img
        v-if="place.loaded"
        id="image"
        class="w-full"
        :style="{'transform': `scale(${zoom}) translate(${translateX + 'px'}, ${translateY + 'px'})`}"
        :src="getSelectedMap().image"
        draggable="false"
      />
      <div v-if="place.loaded" class="w-1/6 absolute bottom-0 right-0">
        <img
          @click="() => selectedMap = map"
          v-for="(map, index) in place.maps"
          :key="index"
          class="w-full"
          :src="map.image"
          draggable="false"
        />
      </div>
    </div>

    <div class="flex w-full justify-start">
      <button
        :class="'flex w-1/4 justify-center mr-4 bg-transparent '+
                        'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                        'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor"
      >Campus Map</button>

      <button
        :class="'flex w-1/4 justify-center bg-transparent '+
                        'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                        'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor"
      >Building Map</button>

      <div class="flex w-1/2 justify-end">
        <button class="w-10 mr-2" @click="zoomMap(1)">
          <img src="http://placehold.it/500" />
        </button>
        <button class="w-10" @click="zoomMap(-1)">
          <img src="http://placehold.it/500" />
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
      defaultedToCenter: false,

      zoom: 1,
      zoomFactor: 0.5,
      translateX: 0,
      translateY: 0,

      drag: false,
      dragX: null,
      dragY: null,

      selectedMap: null,

      primaryColor: 'blue'
    };
  },
  methods: {
    centerMap() {
      // Only run this part once at the start
      if (!this.defaultedToCenter) {
        // Gather the smallest and largest cords for
        // finding the area encompassing all the markers
        var smallX = null,
            bigX   = null,
            smallY = null,
            bigY   = null;

        for (var ii = 0; ii < this.selectedMap.markers.length; ii++) {
          var marker = this.selectedMap.markers[ii];

          smallX == null || smallX > marker.x ? (smallX = marker.x) : null;
          bigX   == null || bigX < marker.x ? (bigX = marker.x) : null;
          smallY == null || smallY > marker.y ? (smallY = marker.y) : null;
          bigY   == null || bigY < marker.y ? (bigY = marker.y) : null;
        }

        // Use the relational amounts to convert to the cords for the new sized image
        var image = document.getElementById("image").getBoundingClientRect();

        smallX = (smallX / 100) * image.width;
        bigX   = (bigX / 100) * image.width;
        smallY = (smallY / 100) * image.height;
        bigY   = (bigY / 100) * image.height;

        // Correct for the default xy of the image on page
        smallX += image.x;
        bigX   += image.x;
        smallY += image.y;
        bigY   += image.y;

        // Find the difference between the center of the marker encompassing area and the
        // center of the imageContainer to then translate the image to shair the same center
        var imageContainer = document
          .getElementById("imageContainer")
          .getBoundingClientRect();

        var imageContainerCenterX = imageContainer.x + imageContainer.width / 2;
        var imageContainerCenterY = imageContainer.y + imageContainer.height / 2;

        var markerAreaCenterX = smallX + (bigX - smallX) / 2;
        var markerAreaCenterY = smallY + (bigY - smallY) / 2;

        // this.translateX = -(markerAreaCenterX - imageContainerCenterX);
        // this.translateY = -(markerAreaCenterY - imageContainerCenterY);
        this.translateX = markerAreaCenterX;
        this.translateY = markerAreaCenterY;
      }
    },

    getSelectedMap() {
      if (this.selectedMap == null) this.selectedMap = this.place.maps[0];
      return this.selectedMap;
    },

    zoomMap(direction) {
      this.zoom + this.zoomFactor * direction < 4 &&
      this.zoom + this.zoomFactor * direction >= 1
        ? (this.zoom += this.zoomFactor * direction)
        : null;

      // Direct the map back into covering the view port when zooming out near a boundary
      /*
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
      */
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

        // Limit the movement of the map to the bounds of the map
        /*
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
        */
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
