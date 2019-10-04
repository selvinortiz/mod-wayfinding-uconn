<template>
  <content-loader :loaded="place.loaded" class="pt-8 px-16">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1 xl:pt-6">
        <mod-map :place="place" :buttons="false" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 xl:pt-6">
        <!-- Portrait pageheader above image and text for long titles -->
        <div v-if="photo" class="w-full xl:pb-0 lg:pb-6 md:pb-6">
          <page-header class="block xl:hidden lg:block md:block sm:block">
            {{ place.campusName }} {{ place.type.name }}
          </page-header>
        </div>
        <!-- landscape and Protrait header for no photo -->
        <div v-else class="w-full pb-4">
          <page-header class="block">
            {{ place.campusName }} {{ place.type.name }}
          </page-header>
        </div>
        <div class="w-1/2 pr-10">
          <div>
            <ui-photo :photo="photo" class="xl:pb-4 lg:pb-6 md:pb-6"></ui-photo>
            <div class="xl:pb-4">
              <!-- landscape pageheader -->
              <page-header v-if="photo" class="hidden xl:block md:hidden sm:hidden">
                {{ place.campusName }} {{ place.type.name }}
              </page-header>
            </div>
            <p class="pb-4">
              <span class="block h-40 xl:h-56 max-w-full pr-2 overflow-y-auto "
                v-html="place.campusDescription">
              </span>
            </p>
          </div>
        </div>
        <div class="w-1/2">
          <div class="pr-6">
            <multi-select
              track-by="id"
              label="buildingName"
              placeholder="CHOOSE DESTINATION"
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
    kiosk() {
      return this.$store.state.app.kiosk || { id: null };
    },
    theme() {
      return this.$store.state.app.theme;
    },
    photo() {
      if (this.place.loaded && this.place.campusPhoto) {
        return this.place.campusPhoto[0];
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
        border: [`border-color: ${this.theme.colors.primary}`].join(";")
      };
    }
  },
  methods: {
    fetch() {
      const id = this.$route.params.id;
      const action = id
        ? "/actions/sys/wayfinding/place"
        : "/actions/sys/wayfinding/place-first";

      axios
        .post(action, { id, locationId: this.kiosk.id })
        .then(response => {
          this.place = {
            ...response.data.place,
            loaded: true
          };
        })
        .catch(error => console.error(error));
    },
    containerStyles() {
      return [`background-color: white`, `color: black`].join(";");
    },
    handleSelectedPlace(place) {
      if (place && place.id) {
        this.$router.push({
          name: "building",
          params: {
            id: place.id
          }
        });
      }
    }
  }
};
</script>
