<template>
  <div class="p-8">
    
    <!--mod-page-header>Place</mod-page-header-->

    <people-place-header heading="WAYFINDING" classes="flex lg:hidden"></people-place-header>

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
import PeoplePlaceHeader from '../../components/shared/PeoplePlaceHeader.vue'
import ModMap from '../../components/shared/ModMap.vue'
import PlaceInfo from '../../components/shared/PlaceInfo.vue'

export default {
  metaInfo: {
    title: "Place"
  },
  components: {
    PeoplePlaceHeader,
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
      id: 375//this.$route.params.id
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
