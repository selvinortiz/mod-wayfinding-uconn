<template>
  <div class="p-4">
    
    <mod-page-header>Place</mod-page-header>

    <div class="flex flex-wrap">

      <!--Half page-->
      <div class="flex justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1">

        <div class="flex w-4/5">
          <mod-map :place="place"></mod-map>
        </div>

      </div>

      <!--Half page-->
      <div class="flex justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <div class="flex flex-wrap w-4/5">

          <div class="w-full">Building Name</div>

          <!--Half-->
          <div class="w-1/2">

            <img class="w-4/5" src="http://placehold.it/500"/>

            <div>Phone Number</div>

            <div>Address Line 1</div>
            <div>Address Line 2</div>

            <div>Address Line 2</div>

            <div>Ultricies porttitor phasellus elementum pellentesque mi ultrices sagittis ut. 
              Ullamcorper eget posuere aptent suscipit nam feugiat in.
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
