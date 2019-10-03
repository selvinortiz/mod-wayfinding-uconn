<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-2/3 xl:order-1 xl:pt-6 lg:w-full lg:order-1">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 xl:pt-6">
        <div class="w-full mb-4">
          <page-header class="block xl:hidden lg:block md:block sm:block">{{ place.title }}</page-header>
        </div>
        <div class="w-1/2 pr-10">
          <div>
            <ui-photo :photo="photo"></ui-photo>
            <p class="pt-4 text-xl xl:text-4xl">
              <!-- landscape pageheader -->
              <page-header class="hidden xl:block md:hidden sm:hidden">{{ place.title }}</page-header>
            </p>
            <p class="pt-4">
              <span class="block font-bold">{{ building.buildingName }} Building</span>
            </p>
            <p class="pt-4">
              <span class="block font-bold">Floor #: {{ floor.floorNumber }}</span>
              <span class="block font-bold">Suite #: {{ place.roomNumber }}</span>
            </p>
            <p class="pt-4">
              <span class="block font-bold">555-555-5555</span>
            </p>
            <p class="pt-4">
              <span class="block font-bold">{{ building.placeAddress }}</span>
              <span class="block font-bold">
                {{ building.placeCity }}, {{ building.placeState }}
                {{ building.placeZipcode }}
              </span>
            </p>
            <p class="pt-4">
              <span
                class="block font-medium h-40 xl:h-56 max-w-full overflow-y-auto"
                v-html="place.roomDescription"
              ></span>
            </p>
          </div>
        </div>
        <div class="w-1/2">
          <div class="px-4">
            <multi-select
              track-by="id"
              label="title"
              placeholder="Choose Destination"
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

            <div class="pt-4">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="cursor-pointer"
                :style="styles.defaultColor"
                @click="() => ($store.state.app.searchIsOpen = true)"
              >Switch to SEARCH</a>
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
        ancestors: []
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
      if (
        this.building &&
        this.building.buildingPhoto &&
        this.building.buildingPhoto.length
      ) {
        return this.building.buildingPhoto[0];
      }
      return {
        url: "",
        width: 0,
        height: 0
      };
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
    options() {
      if (!this.building || !this.building.descendants) {
        return []
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
          loaded: [],
          ancestors: []
        };
        this.fetch();
      }
    }
  }
};
</script>
