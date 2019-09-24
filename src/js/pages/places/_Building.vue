<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <page-header>Wayfinding</page-header>
    <section class="lg:flex flex-wrap">
      <div class="lg:w-1/2 lg:order-1">
        <mod-map :place="place" class="lg:px-4 lg:mt-16"></mod-map>
      </div>
      <div class="w-full flex flex-wrap lg:w-1/2">
        <div class="w-1/2">
          <div>
            <h2 class="pt-8 pb-2 lg:pt-0 font-thin text-4xl">{{ place.buildingName }} {{ place.type.name }}</h2>
            <ui-photo :photo="photo"></ui-photo>

            <div class="text-xl lg:text-2xl">
              <p class="pt-4">
                <span class="block">{{ place.placeAddress }}</span>
                <span
                  class="block"
                >{{ place.placeCity }}, {{ place.placeState }} {{ place.placeZipcode }}</span>
              </p>
            </div>
          </div>
        </div>
        <div class="w-1/2">
          <div class="pt-16 px-4" :style="styles.border">
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
            </multi-select>

            <div class="pt-4">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="cursor-pointer"
                :style="styles.defaultColor"
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

export default {
  metaInfo: {
    title: "Place"
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
    theme() {
      return this.$store.state.app.theme;
    },
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
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";"),
        border: [`border-color: ${this.theme.colors.primary}`].join(";"), 
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
