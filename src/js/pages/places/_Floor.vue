<template>
  <div class="p-8">
    <div class="w-full flex-wrap pl-4 md:mb-4">
      <div class="w-full text-3xl font-300">{{ place.title }}</div>
      <div class="w-full text-1xl">
          {{ 'Breadcrumb nav 1' }}
          >
          {{ 'Breadcrumb nav 2' }}
      </div>
    </div>

    <div class="flex flex-wrap justify-center">

      <div class="flex flex-wrap justify-center
      lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">

        <mod-map :place="place"></mod-map>

      </div>

      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <place-info :place="place"></place-info>

      </div>

    </div>

  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from '../../components/ModMap.vue'
import PlaceInfo from '../../components/shared/PlaceInfo.vue'

export default {
  metaInfo: {
    title: "Place"
  },
  components: {
    ModMap,
    PlaceInfo
  },
  data() {
    return {
      place: {},

      // Not Used
      //primaryColor: this.$store.state.app.theme.main.wayfinding.text
    }
  },
  created() {
    axios.post("/actions/sys/wayfinding/place", {
      id: this.$route.params.id
    })
    .then(response => {
      this.place = {
        ...response.data.place,
        loaded: true
      };
      console.log(this.place);
    })
    .catch(error => console.error(error));
  }
};
</script>
