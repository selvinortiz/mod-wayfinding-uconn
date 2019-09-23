<template>
  <content-loader :loaded="place.loaded">
    <section class="lg:flex flex-wrap">
      <div class="lg:w-1/2 lg:order-1">
        <mod-map :place="place" class="p-8 pl-4"></mod-map>
      </div>
      <div class="w-full lg:w-1/2 lg:flex">
        <div class="lg:w-1/2">
          <div class="p-8 pr-4">
            <ui-photo :photo="photo"></ui-photo>

            <h2 class="font-thin text-4xl pt-4">{{ place.campusName }} {{ place.type.name }}</h2>

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
              label="buildingName"
              placeholder="Chose Building"
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
                :style="styles.link"
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
.multiselect__tags{
border: 2px solid  #c0d;
}
</style>

<script>
import axios from "../../utils/Axios";
import ModMap from "../../components/shared/ModMap.vue";
//import PlaceInfo from "../../components/shared/PlaceInfo.vue";

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
    const id = this.$route.params.id;
    const action = id
      ? "/actions/sys/wayfinding/place"
      : "/actions/sys/wayfinding/place-first";

    axios
      .post(action, { id })
      .then(response => {
        this.place = {
          ...response.data.place,
          loaded: true
        };
      })
      .catch(error => console.error(error));
  },
  computed: {
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
        link: [`color: ${this.theme.colors.primary}`].join(";"),
        border: [`border-color: ${this.theme.colors.primary}`].join(";") 
      };
    }
  },
  methods: {
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
