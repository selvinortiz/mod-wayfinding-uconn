<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <page-header>Back</page-header>

    <section class="lg:flex flex-wrap">
      <div class="lg:w-1/2 lg:order-1">
        <mod-map :place="place"></mod-map>
      </div>

      <div class="w-full lg:w-1/2 lg:flex">
        <div class="lg:w-1/2">
          <div class="p-8 pr-4">
            <ui-photo :photo="photo"></ui-photo>

            <h2 class="font-thin text-4xl pt-4">{{ place.buildingName }} {{ place.type.name }}</h2>

            <div class="text-xl">
              <p class="pt-4">
                <span class="block">{{ place.placeAddress }}</span>
                <span
                  class="block"
                >{{ place.placeCity }}, {{ place.placeState }} {{ place.placeZipcode }}</span>
              </p>
            </div>
          </div>
        </div>
        <div class="w-full lg:w-1/2">
          <div class="py-8 px-4">
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
                <span :class="{'text-gray-600': option.type.handle !== 'floor'}">{{ option.title }}</span>
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
    </section>
  </content-loader>
</template>

<style>
.multiselect__option--highlight {
  color: #333;
  background-color: #ddd;
}
</style>

<script>
import axios from "../../utils/Axios";
import ModMap from "../../components/ModMap.vue";

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
        id: 0,
        type: { name: "" },
        loaded: false,
        descendants: []
      }
    };
  },
  created() {
    this.fetch();
  },
  computed: {
    photo() {
      if (this.place.loaded && this.place.buildingPhoto) {
        return this.place.buildingPhoto[0];
      }

      return {
        url: "",
        width: 0,
        height: 0
      };
    },
    styles() {
      return {
        link: [`color: ${this.theme.colors.primary}`].join(";")
      };
    }
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
        })
        .catch(error => console.error(error));
    },
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
  },
  watch: {
    $route(to) {
      if (to.name === "building" && to.params.id != this.place.id) {
        this.place = {
          id: 0,
          type: { name: "" },
          loaded: false,
          descendants: []
        };

        this.fetch();
      }
    }
  }
};
</script>
