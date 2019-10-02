<template>
  <section class="h-screen">
    <div class="p-4 overflow-hidden bg-red-200" style="height: 40vh;">
      <mod-map :maps="maps" />
    </div>
    <div class="p-4 overflow-hidden bg-blue-200" style="height: 40vh;">
      <h1>Place info goes here</h1>
    </div>
  </section>
</template>

<script>
import Map from "../../components/Map.vue";

export default {
  components: { "mod-map": Map },
  data() {
    return {
      maps: [
        {
          zoom: 2,
          image: {
            src: "http://uconn.madebymod.com/maps/campus/90828.svg"
          }
        },
        {
          zoom: 1,
          image: {
            src: "http://uconn.madebymod.com/maps/room/91042/91044.svg"
          }
        },
        {
          zoom: 1,
          image: {
            src: "http://uconn.madebymod.com/maps/floor/91042/91040.svg"
          }
        }
      ]
    };
  }
};
</script>
