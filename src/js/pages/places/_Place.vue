<template>
  <div class="p-4">
    
    <!--mod-page-header>Place</mod-page-header-->

    <div class="w-full flex flex-wrap justify-center lg:hidden">
        <div class="lg:w-11/12 w-full mb-4">
          <div :class="'text-3xl text-'+primaryColor+' font-300'">WAYFINDING</div>
          <div :class="'text-1xl text-'+primaryColor">
            {{ 'Breadcrumb nav 1' }}
            >
            {{ 'Breadcrumb nav 2' }}
          </div>
        </div>
    </div>

    <div class="flex flex-wrap">

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1">

        <div class="w-full">
          <mod-map :place="place"></mod-map>
        </div>

        <div class="flex w-full justify-center lg:justify-end xl:justify-end">

          <button :class="'flex w-1/4 justify-center m-4 bg-transparent '+
                          'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                          'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor">
            Campus Map
          </button>

          <button :class="'flex w-1/4 justify-center m-4 bg-transparent '+
                          'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                          'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor">
            Building Map
          </button>

        </div>

      </div>

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <!--Weird height issues-->
        <div class="w-full justify-center hidden lg:flex">
            <div class="lg:w-11/12 w-full mb-4">
              <div :class="'text-3xl text-'+primaryColor+' font-300'">WAYFINDING</div>
              <div :class="'text-1xl text-'+primaryColor">
                {{ 'Breadcrumb nav 1' }}
                >
                {{ 'Breadcrumb nav 2' }}
              </div>
            </div>
        </div>

        <div class="flex flex-wrap w-11/12">

          <div :class="'w-full text-2xl font-black text-'+primaryColor">
            {{place.title}}
          </div>

          <!--Half-->
          <div class="w-1/2">

            <img class="w-4/5 mb-4" src="http://placehold.it/500"/>

            <div :class="'font-bold mb-4 text-'+primaryColor">Phone Number</div>

            <div :class="'font-bold text-'+primaryColor">Address Line 1</div>
            <div :class="'font-bold mb-4 text-'+primaryColor">Address Line 2</div>

            <div :class="'text-'+primaryColor">
              Place Description
            </div>

          </div>

          <!--Half-->
          <div class="w-1/2 text-center">

            <div :class="'w-full flex items-center h-12 px-6 border-2 border-'+primaryColor">
              Choose Destination
            </div>

            <div :class="'text-'+primaryColor">
              Don't see what you're looking for? <u>Switch to SEARCH</u>
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
      place: {},

      primaryColor: 'blue-800'
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
