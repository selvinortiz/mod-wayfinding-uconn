<template>
  <section class="h-screen">
    <div class="overflow-hidden">
      <mod-map :maps="maps" />
    </div>
    <div class="verflow-hidden">
      <h1>Place Information</h1>
    </div>
  </section>
</template>

<script>
import ModMap from "../../components/Map.vue";

export default {
  components: { ModMap },
  data() {
    return {
      maps: [
        {
          zoom: 2,
          type: 'campus',
          title: 'Row Building',
          subtitle: '',
          images: [
            {
              src: "http://uconn.madebymod.com/maps/campus/90828.svg"
            }
          ]
        },
        {
          zoom: 1,
          type: 'building',
          title: 'Information Technology Building',
          subtitle: 'Floor 1',
          images: [
            {
              src: "http://uconn.madebymod.com/maps/room/91042/91044.svg"
            },
            {
              src: "http://uconn.madebymod.com/maps/floor/91042/91040.svg",
              title: 'Rowe Building',
              subtitle: 'Floor 3'
            }
          ]
        }
      ]
    };
  }
};
</script>
