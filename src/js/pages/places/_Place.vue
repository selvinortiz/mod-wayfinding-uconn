<template>
  <div class="p-4">
    <mod-page-header>Place</mod-page-header>
    
    <mod-map :id="place.id" :title="place.title" :images="place.images" :markers="place.markers"></mod-map>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from '../../components/shared/ModMap.vue'

export default {
  metaInfo: {
    title: "Place"
  },
  components: {
    ModMap
  },
  data() {
    return {
      place: {}
    }
  },
  created() {
    axios.post("/actions/sys/wayfinding/place", {
      id: this.$route.params.id
    })
    .then(response => {
      this.place = response.data.place;

      // Only for testing
      this.place.images = [
        {'url': '/svg/testSVG1.svg', 'width': 1440, 'height': 953},
        {'url': '/svg/testSVG2.svg', 'width': 1390, 'height': 835}
      ];
      this.place.markers = [
            {'x': 526, 'y': 296},
            {'x': 493, 'y': 375}
      ];
    })
    .catch(error => console.error(error));
  }
};
</script>
