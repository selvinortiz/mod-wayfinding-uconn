<template>
  <div class="p-4">
    
    <mod-page-header>Place</mod-page-header>

    <div class="flex flex-wrap">

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1">

        <div class="flex w-4/5">
          <mod-map :place="place"></mod-map>
        </div>

        <div class="flex w-full lg:justify-end md:justify-center sm:justify-center">

          <div class="flex w-1/4 h-6 border border-gray-300 bg-gray-100 justify-center">
            Campus Map
          </div>

          <div class="flex w-1/4 h-6 border border-gray-300 bg-gray-100 justify-center">
            Building Map
          </div>

        </div>

      </div>

      <!--Half page-->
      <div class="flex justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <div class="flex flex-wrap w-4/5">

          <div class="w-full font-black">{{place.title}}</div>

          <!--Half-->
          <div class="w-1/2">

            <img class="w-4/5" src="http://placehold.it/500"/>
            <br/>

            <div class="font-bold">Phone Number</div>
            <br/>

            <div class="font-bold">Address Line 1</div>
            <div class="font-bold">Address Line 2</div>
            <br/>

            <div>
              Place Description
            </div>

          </div>

          <!--Half-->
          <div class="w-1/2">

            <div class="w-full h-12 border border-gray-300 bg-gray-100">
              Choose Destination
            </div>

          </div>

        </div>
        
      </div>

    </div>

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
      this.place = {
        ...response.data.place,
        loaded: true
      };
    })
    .catch(error => console.error(error));
  }
};
</script>
