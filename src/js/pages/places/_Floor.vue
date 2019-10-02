<template>
  <section class="h-full">
    <div class="bg-red-200 overflow-hidden" style="height: 40vh;">
      <mod-map :map="map"></mod-map>
    </div>
    <div class="bg-blue-200 overflow-hidden" style="height: 40vh;">
      <h1>Hello</h1>
    </div>
  </section>
</template>

<script>
import Map from '../../components/Map.vue';

export default {
  components: { 'mod-map': Map },
  data() {
    return {
      maps: [
        {
          images: [
            {
              src: 'http://uconn.madebymod.com/maps/campus/90828.svg',
            },
          ]
        },
        {
          images: [
            {
              src: 'http://uconn.madebymod.com/maps/room/91042/91044.svg'
            },
            {
              src: 'http://uconn.madebymod.com/maps/floor/91042/91040.svg',
            }
          ]
        }
      ]
    }
  },
  computed: {
    map() {
      return this.maps[0];
    }
  }
}
</script>
