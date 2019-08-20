<template>
  <div class="p-4">
    <mod-page-header>Place</mod-page-header>
    <mod-map-container :id="place.id" :title="place.title"></mod-map-container>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMapContainer from '../../components/shared/ModMapContainer.vue'

export default {
  metaInfo: {
    title: "Place"
  },
  components: {
    ModMapContainer
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
    })
    .catch(error => console.error(error));
  }
};
</script>
