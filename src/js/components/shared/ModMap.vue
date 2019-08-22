<template>
  <div>
    <div
      id="imageContainer"
      class="imageContainer"
      @mousedown="startDrag($event)"
      @mousemove="dragMap($event)"
      @mouseup="stopDrag()"
      @mouseleave="stopDrag()"
    >
      <img
        v-if="place.loaded"
        id="image"
        class="image"
        :src="selectedImage"
        @load="styleMap()"
        draggable="false"
        alt="Map"
      />

      <div class="test" id="test1"></div>
      <!-- For center visualization -->
      <div class="test" id="test2" style="outline: 1px yellow solid;"></div>
      <!-- For center visualization -->
    </div>

    <button @click="zoomMap(1)">Zoom In</button>
    <button @click="zoomMap(-1)">Zoom Out</button>

    <div v-if="place.loaded">
      <img
        class="altImage"
        v-for="(map, index) in place.maps"
        :key="index"
        :src="map.image"
        draggable="false"
      />
    </div>
  </div>
</template>

<style>
@import "./style.scss";
</style>

<script>
export default {
  props: {
    place: {
      type: Object,
      default: () => ({
        id: 0,
        title: '',
        maps: [
          {
            markers: [
              { width: 0, height: 0, x: 0, xr: 0, y: 0,yr: 0 }
            ]
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
    };
  },
  computed: {
    selectedImage() {
      return this.place.maps[0].image;
    }
  },
  methods: {
    styleMap() {
      // Only run this part once at the start
      if (!this.defaultedToCenter && this.place.loaded) {
        // Gather the smallest and largest cords for
        // finding the area encompassing all the markers
        var smallX = null,
          bigX = null,
          smallY = null,
          bigY = null;

        for (var ii = 0; ii < this.place.maps[0].markers.length; ii++) {
          var marker = this.place.maps[0].markers[ii];

          smallX == null || smallX > marker.xr ? (smallX = marker.xr) : null;
          bigX == null || bigX < marker.xr ? (bigX = marker.xr) : null;
          smallY == null || smallY > marker.yr ? (smallY = marker.yr) : null;
          bigY == null || bigY < marker.yr ? (bigY = marker.yr) : null;
        }

        // Use the relational amounts to convert to the cords for the new sized image
        var image = document.getElementById("image").getBoundingClientRect();

        smallX = (smallX / 100) * image.width;
        bigX = (bigX / 100) * image.width;
        smallY = (smallY / 100) * image.height; //Image height is not right
        bigY = (bigY / 100) * image.height; //Image height is not right
        console.log(image);
        //console.log([smallX, bigY, bigX - smallX, bigY - smallY]);

        // Correct for the default xy of the image on page
        smallX += image.x;
        bigX += image.x;
        smallY += image.y;
        bigY += image.y;

        // Find the difference between the center of the marker encompassing area and the
        // center of the imageContainer to then translate the image to shair the same center
        var imageContainer = document
          .getElementById("imageContainer")
          .getBoundingClientRect();
        //console.log(imageContainer);

        var imageContainerCenterX = imageContainer.x + imageContainer.width / 2;
        var imageContainerCenterY =
          imageContainer.y + imageContainer.height / 2;

        var markerAreaCenterX = smallX + (bigX - smallX) / 2;
        var markerAreaCenterY = smallY + (bigY - smallY) / 2;

        console.log(imageContainerCenterX + "  " + imageContainerCenterY);
        console.log(markerAreaCenterX + "  " + markerAreaCenterY);
        console.log(
          markerAreaCenterX -
            imageContainerCenterX +
            "  " +
            (markerAreaCenterY - imageContainerCenterY)
        );
        //this.translateX = markerAreaCenterX - imageContainerCenterX;
        //this.translateY = markerAreaCenterY - imageContainerCenterY;

        this.defaultedToCenter = true;
        return (
          "transform: scale(" +
          this.zoom +
          ") translate(" +
          this.translateX +
          "px, " +
          this.translateY +
          "px)"
        );
      }

      return (
        "transform: scale(" +
        this.zoom +
        ") translate(" +
        this.translateX +
        "px, " +
        this.translateY +
        "px)"
      );
    },

    zoomMap(direction) {
      this.zoom + this.zoomFactor * direction < 4 &&
      this.zoom + this.zoomFactor * direction >= 1
        ? (this.zoom += this.zoomFactor * direction)
        : null;

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
        //var image = document.getElementById('image').getBoundingClientRect();
        //console.log(image.width);
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
