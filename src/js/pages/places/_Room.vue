<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-2/3 xl:order-1 xl:pt-6 lg:w-full lg:order-1">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="flex flex-wrap w-full pr-6 xl:w-1/3 lg:full lg:pr-0">
        <div class="w-full xl:w-full lg:w-1/2 lg:pr-6">
          <div>
            <page-header class="block">
              {{
              place.title
              }}
            </page-header>
            <ui-photo :photo="photo"></ui-photo>
          </div>
        </div>
        <div class="w-full xl:w-full lg:w-1/2">
          <div class="mt-24 xl:mt-0">
            <p class="pt-4">
              <span
                class="block font-bold"
                :style="styles.defaultColor"
              >{{ building.buildingName }} Building</span>
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
      </div>
    </section>
  </content-loader>
</template>

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
    styles() {
      return {
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";")
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
    }
  },
  methods: {
    fetch() {
      const id         = this.$route.params.id;
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
