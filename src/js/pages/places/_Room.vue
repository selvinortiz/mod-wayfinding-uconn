<template>
  <div class="p-8">
    <div class="flex flex-wrap justify-center">
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">
        <mod-map :place="place"></mod-map>
      </div>
      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">
        <div :style="containerStyles">
          <div class="w-full flex flex-wrap p-4">
            <div class="w-full mb-4 text-2xl font-black">{{place.title}}</div>

            <div>
              <img class="w-4/5 mb-4" src="http://placehold.it/500" />

              <div class="font-bold mb-4">Phone Number</div>
              <div class="font-bold">Address Line 1</div>
              <div class="font-bold mb-4">Address Line 2</div>
              <div>Place Description</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from "../../components/shared/ModMap.vue";
import PlaceInfo from "../../components/shared/PlaceInfo.vue";

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
      place: {}
    };
  },
  created() {
    this.fetch();
  },
  methods: {
    fetch() {
      axios
        .post("/actions/sys/wayfinding/place", {
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
  },
  watch: {
    $route(to) {
      if (to.name === "room" && to.path !== this.$route.path) {
        this.place = {};
        this.fetch();
      }
    }
  }
};
</script>
