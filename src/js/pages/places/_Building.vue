<template>
  <div v-if="place.loaded" class="p-8">
    <page-header>Wayfinding</page-header>

    <div class="flex flex-wrap justify-center">
      <div class="flex flex-wrap justify-center md:w-full md:mb-6 md:order-1 lg:w-1/2 lg:order-2">
        <mod-map :place="place"></mod-map>
      </div>

      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">
        <div>
          <div class="w-full flex flex-wrap justify-center p-4">
            <div class="w-full mb-4 text-2xl font-black">{{place.buildingName}}</div>

            <!-- Half -->
            <div class="w-1/2 font-thin text-xl">
              <img class="w-4/5 mb-4" src="http://placehold.it/500" />

              <div class="">{{ place.buildingPhone }}</div>
              <div class="">{{ place.buildingAddress }}</div>
              <div class="">
                {{ `${place.buildingCity}, ${place.buildingState} ${place.buildingZipcode}` }}
              </div>
              <div>{{ place.buildingDescription }}</div>
            </div>

            <!-- Half -->
            <div class="w-1/2 text-center">
              <multi-select
                track-by="id"
                label="title"
                placeholder="Chose Destination"
                value
                :options="place.descendants"
                :show-labels="false"
                :allow-empty="true"
                @input="handleSelectedPlace"
              >
                <template slot="singleLabel" slot-scope="{ option }">
                  <strong>{{ option.title }}</strong>
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
        descendants: []
      }
    };
  },
  created() {
    axios
      .post("/actions/sys/wayfinding/place", {
        id: this.$route.params.id
      })
      .then(response => {
        this.place = {
          ...response.data.place,
          loaded: true
        };
      })
      .catch(error => console.error(error));
  },
  methods: {
    handleSelectedPlace(place) {
      if (place && place.id) {
        this.$router.push({
          name: "room",
          params: {
            id: place.id
          }
        });
      }
    }
  }
};
</script>
