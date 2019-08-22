<template>
  <div class="p-4">
    <mod-page-header>Place</mod-page-header>
    
    <mod-map :id="place.id" :title="place.title" :maps="place.maps" :load='place.load'></mod-map>
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
      this.place.load = true;
    })
    .catch(error => console.error(error));
  }
};
</script>
