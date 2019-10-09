<template>
  <content-loader :loaded="place.loaded" classes="pt-8 px-16">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1 xl:pt-6 lg:pb-6 md:pb-6">
        <mod-map :maps="maps" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 xl:pt-6">
        <!-- Portrait pageheader above image and text for long titles -->
        <div v-if="photo" class="w-full xl:pb-0 lg:pb-4 md:pb-4">
          <page-header class="block xl:hidden lg:block md:block sm:block"
            >{{ place.buildingName }} {{ place.type.name }}</page-header
          >
        </div>
        <!-- landscape and Protrait header for no photo -->
        <div v-else class="w-full mb-6">
          <page-header
            >{{ place.buildingName }} {{ place.type.name }}</page-header
          >
        </div>
        <div class="w-1/2 pr-10">
          <div>
            <ui-photo :photo="photo" class="xl:pb-4 lg:pb-6 md:pb-6"></ui-photo>
            <p v-if="photo" class="xl:pb-4">
              <!-- landscape pageheader -->
              <page-header class="hidden xl:block md:hidden sm:hidden"
                >{{ place.buildingName }} {{ place.type.name }}</page-header
              >
            </p>
            <p class="pb-4">
              <span class="block font-bold">555-555-5555</span>
            </p>
            <p class="pb-4">
              <span class="block">{{ place.placeAddress }}</span>
              <span class="block">
                {{ place.placeCity }}, {{ place.placeState }}
                {{ place.placeZipcode }}
              </span>
            </p>

            <p class="pb-4">
              <span
                class="block h-40 xl:h-56 max-w-full pr-2 overflow-y-auto"
                v-html="place.buildingDescription"
              ></span>
            </p>
          </div>
        </div>
        <div class="w-1/2">
          <div class="pr-6">
            <multi-select
              track-by="id"
              label="title"
              placeholder="CHOOSE YOUR DESTINATION"
              value
              :options="options"
              :show-labels="false"
              :allow-empty="true"
              @input="handleSelectedPlace"
            >
              <template slot="option" slot-scope="{ option }">
                <p class="cursor-pointer">{{ option.title }}</p>
              </template>
            </multi-select>
            <div class="flex pt-6">
              <div class="pr-4 text-lg">
                <router-link
                  :to="{ name: 'campus', params: { id: campus.id } }"
                >
                  <p>
                    <span
                      class="cursor-pointer underline"
                      :style="styles.defaultColor"
                      >CAMPUS
                    </span>
                  </p>
                </router-link>
                </div>
                <div class="">
                  <a
                    class="cursor-pointer underline text-lg"
                    :style="styles.defaultColor"
                    @click="() => ($store.state.app.searchIsOpen = true)"
                    >SEARCH</a
                  >
                </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </content-loader>
</template>

<style>
.multiselect__select:before {
  top: 80%;
  color: #000e2f;
  border-color: #000e2f transparent transparent transparent;
  border-width: 12px 12px 0;
}
.multiselect__option--highlight {
  color: #fff;
  background-color: #000e2f;
}
.multiselect__tags {
  border: 2px solid #000e2f;
  border-radius: 0;
}
.multiselect__placeholder {
  color: #000e2f;
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
    maps() {
      return this.place.maps || [];
    },
    kiosk() {
      return this.$store.state.app.kiosk || { id: null };
    },
    campus() {
      return this.$store.state.app.campus;
    },
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
    options() {
      return this.place.descendants.map(item => {
        if (item.type.handle === "floor") {
          item["$isDisabled"] = true;
        }

        return item;
      });
    },
    styles() {
      return {
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";")
      };
    }
  },
  methods: {
    fetch() {
      axios
        .post("/actions/sys/wayfinding/place", {
          id: this.$route.params.id,
          locationId: this.kiosk.id
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
  route() {
    return { name: "campus", params: { id: this.campus.id } };
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
