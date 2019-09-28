<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1 xl:pt-6">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 xl:pt-6">
      <!-- Portrait pageheader above image and text for long titles -->
        <div class="w-full mb-4">
          <page-header class="block xl:hidden lg:block md:block sm:block">
            {{ place.buildingName }} {{ place.type.name }}
          </page-header>
        </div>
        <div class="w-1/2 pr-10">
          <div>
            <ui-photo :photo="photo"></ui-photo>
            <p class="pt-4 text-xl xl:text-4xl">
              <!-- landscape pageheader -->
              <page-header class="hidden xl:block md:hidden sm:hidden">
                {{ place.buildingName }} {{ place.type.name }}
              </page-header>
            </p>
            <p class="pt-4">
              <span class="block font-bold pb-2">555-555-555</span>
            </p>
            <p class="pt-4">
            <span class="block font-bold">{{ place.placeAddress }}</span> 
            <span class="block font-bold">
              {{ place.placeCity }}, {{ place.placeState }}
              {{ place.placeZipcode }}
            </span>
            </p>

            <p class="pt-4">
              <span
                class="block h-40 xl:h-56 max-w-full overflow-y-auto"
                v-html="place.buildingDescription"
              ></span>
            </p>
          </div>
        </div>
        <div class="w-1/2">
          <div class="px-4">
            <multi-select
              track-by="id"
              label="title"
              placeholder="Chose Destination"
              value
              :options="place.descendants"
              :show-labels="false"
              :allow-empty="true"
              @input="handleSelectedPlace"
            ></multi-select>

            <div class="pt-4">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="cursor-pointer"
                :style="styles.defaultColor"
                @click="() => ($store.state.app.searchIsOpen = true)"
                >Switch to SEARCH</a
              >
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
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";")
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
