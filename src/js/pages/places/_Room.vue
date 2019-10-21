<template>
  <content-loader :loaded="place.loaded" classes="pt-8 px-16">
    <!-- Main Content Section -->
    <section class="xl:flex flex-wrap">
      <!-- Map -->
      <!-- Note: Trying Flex-1 here for a second -->
      <div class="flex-1 xl:w-1/2 xl:order-1 xl:pt-6 lg:pb-6 md:pb-6">
        <mod-map
          :maps="maps"
          :primary-map="primaryMapType"
          class="xl:px-4"
        ></mod-map>
      </div>
      <!-- Portrait Header Above Fully Stretching Half the Page -->
      <div class="flex w-full">
        <div class="lg:flex md:flex xl:hidden  pb-4">
          <page-header> {{ place.title }}</page-header>
        </div>
      </div>
      <!-- Landscape Header Without Photo -->
      <div v-if="!photo" class="flex w-full">
        <div class="xl:flex lg:hidden md:hidden">
          <page-header> {{ place.title }}</page-header>
        </div>
      </div>
      <!-- Room info Section -->
      <section class="flex xl:w-1/2 xl:pt-6">
        <div class="flex-col w-1/2">
          <div v-if="photo" class="flex">
            <ui-photo :photo="photo" class="xl:pb-4 lg:pb-6 md:pb-6"></ui-photo>
          </div>
          <!-- LandScape Header Below Photo-->
          <div v-if="photo" class="xl:flex lg:hidden md:hidden pb-4">
            <page-header>{{ place.title }}</page-header>
          </div>
          <div class="flex flex-col">
            <p v-if="building.buildingName" class="pb-4">
              <span class="block font-semibold"
                >{{ building.buildingName }} Building</span
              >
            </p>
            <p v-if="floor.floorNumber || place.roomNumber" class="pb-4">
              <span v-if="floor.floorNumber" class="block font-bold"
                >Floor #: {{ floor.floorNumber }}</span
              >
              <span class="block font-bold">
                Suite #: {{ place.roomNumber }}
              </span>
            </p>
            <p v-if="place.placePhone" class="pb-4">
              <span class="block font-bold">{{ place.placePhone }}</span>
            </p>
            <p
              v-if="
                building.placeAddress ||
                  building.placeCity ||
                  building.placeState
              "
              class="pb-4"
            >
              <span v-if="building.placeAddress" class="block">{{
                building.placeAddress
              }}</span>
              <span
                v-if="building.placeCity || building.placeState"
                class="block"
              >
                {{ building.placeCity }}, {{ building.placeState }}
                {{ building.placeZipcode }}
              </span>
            </p>
            <p class="pb-4">
              <span
                v-if="place.roomDescription"
                class="block h-48 max-w-full pr-2 _scroll"
                v-html="place.roomDescription"
              ></span>
            </p>
          </div>
        </div>

        <div class="flex-col w-1/2">
          <div class="px-6">
            <multi-select
              track-by="id"
              label="title"
              placeholder="CHOOSE NEW DESTINATION"
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
            <div class="flex w-full pt-6">
              <div class="flex pr-4 text-lg w-2/3">
                <div>
                  <router-link
                    :to="{ name: 'campus', params: { id: campus.id } }"
                  >
                    <p>
                      <span
                        class="flex cursor-pointer underline"
                        :style="styles.defaultColor"
                        >CAMPUS
                      </span>
                    </p>
                  </router-link>
                </div>
                <div>
                  <p>&nbsp;/&nbsp;</p>
                </div>
                <div>
                  <router-link
                    :to="{ name: 'building', params: { id: building.id } }"
                  >
                    <p>
                      <span
                        class="cursor-pointer underline"
                        :style="styles.defaultColor"
                      >
                        BUILDING
                      </span>
                    </p>
                  </router-link>
                </div>
              </div>
              <div class="w-1/3 ">
                <span class="flex flex-row-reverse">
                  <a
                    class="cursor-pointer underline text-lg"
                    :style="styles.defaultColor"
                    @click="() => ($store.state.app.searchIsOpen = true)"
                    >SEARCH</a
                  >
                </span>
              </div>
            </div>
          </div>
        </div>
      </section>
    </section>
  </content-loader>
</template>

<style>
::-webkit-scrollbar {
  width: 15px;
}
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
._scroll {
  overflow-y: auto;
}
/* Handle */
._scroll::-webkit-scrollbar-thumb {
  background: #111;
  border-radius: 10px;
}
/* Handle on hover */
._scroll::-webkit-scrollbar-thumb:hover {
  background: #111;
}
</style>

<script>
import axios from "../../utils/Axios";

export default {
  name: "room",
  metaInfo: {
    title: "Place"
  },
  data() {
    return {
      place: {
        id: 0,
        type: { name: "" },
        loaded: false,
        ancestors: []
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
    theme() {
      return this.$store.state.app.theme;
    },
    photo() {
      if (this.place && this.place.roomPhoto && this.place.roomPhoto.length) {
        return this.place.roomPhoto[0];
      }
      return null;
    },
    kiosk() {
      return this.$store.state.app.kiosk || { id: null };
    },
    floor() {
      return this.place.ancestors[0] || {};
    },
    building() {
      return this.place.ancestors[1] || {};
    },
    campus() {
      return this.place.ancestors[2] || {};
    },
    primaryMapType() {
      return this.place.primaryMapType || "building";
    },
    options() {
      if (!this.building || !this.building.descendants) {
        return [];
      }

      return this.building.descendants.map(item => {
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
      const id = this.$route.params.id;
      const locationId = this.kiosk.id;

      axios
        .post("/actions/sys/wayfinding/place", { id, locationId })
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
      if (to.name === "room" && this.$route.params.id != this.place.id) {
        this.place = {
          id: 0,
          loaded: false,
          ancestors: []
        };
        this.fetch();
      }
    }
  }
};
</script>
