<template>
  <div class="p-8">
    <page-header>Wayfinding</page-header>

    <div class="flex flex-wrap justify-center">
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">
        <mod-map v-if="place.maps" :place="place"></mod-map>
      </div>

      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">
        <div :style="containerStyles">
          <div class="w-full flex flex-wrap justify-center p-4">
            <div class="w-full mb-4 text-2xl font-black">{{ place.campusName }}</div>

            <!-- Half -->
            <div class="w-1/2">
              <img class="w-4/5 mb-4" src="http://placehold.it/500" />

              <div class="font-bold mb-4">Phone Number</div>
              <div class="font-bold">Address Line 1</div>
              <div class="font-bold mb-4">Address Line 2</div>
              <div>Place Description</div>
            </div>

            <!-- Half -->
            <div class="w-1/2 text-center">
              <multi-select
                track-by="id"
                label="buildingName"
                placeholder="Chose Building"
                value=""
                :options="place.descendants"
                :show-labels="false"
                :allow-empty="true"
                @input="handleSelectedPlace"
              >
                <template slot="singleLabel" slot-scope="{ option }">
                  <strong>{{ option.buildingName }}</strong>
                </template>
              </multi-select>

              <div class="pt-4">
                Don&rsquo;t see what you&rsquo;re looking for?
                <a
                  class="text-blue-600 cursor-pointer"
                  @click="() => $store.state.app.searchIsOpen = true"
                >Switch to SEARCH</a>
              </div>
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
    ModMap
  },
  data() {
    return {
      place: {
        loaded: false,
        descendants: [],
      }
    };
  },
  created() {
    const id = this.$route.params.id;
    const action = id ? "/actions/sys/wayfinding/place" : "/actions/sys/wayfinding/place-first"

    axios
      .post(action, { id })
      .then(response => {
        this.place = {
          ...response.data.place,
          loaded: true
        };
        console.log(this.place);
      })
      .catch(error => console.error(error));
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    }
  },
  methods: {
    containerStyles() {
      return [`background-color: white`, `color: black`].join(";");
    },
    handleSelectedPlace(place) {
      if (place && place.id) {
        this.$router.push({
          name: 'building',
          params: {
            id: place.id
          }
        })
      }
    }
  }
};
</script>
