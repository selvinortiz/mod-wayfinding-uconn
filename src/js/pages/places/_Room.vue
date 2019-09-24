<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <page-header>Wayfinding</page-header>
    <section class="lg:flex flex-wrap">
      <div class="lg:w-1/2 lg:order-1">
        <mod-map :place="place" class="px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap lg:w-1/2">
        <div class="w-full">
          <div class="pt-8 px-4">
            <h2 class="font-thin text-4xl leading-none">{{ place.title }}</h2>

            <div class="text-xl">
              <p class="pt-4 text-2xl">
                <span class="block">{{ building.buildingName }} Building</span>
              </p>

              <p class="pt-4">
                <span class="block">Floor #: {{ floor.floorNumber }}</span>
                <span class="block">Suite #: {{ place.roomNumber }}</span>
              </p>
              <p class="pt-4">
                <span class="block">
                  {{ building.placeCity }}, {{ building.placeState }} {{ building.placeZipcode }}
                </span>
              </p>
            </div>
          </div>
        </div>
        <!--div class="w-1/2">
          <div class="pt-20 px-4">
            <div class="pt-4">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="cursor-pointer"
                :style="styles.link"
                @click="() => $store.state.app.searchIsOpen = true"
              >Switch to SEARCH</a>
            </div>
          </div>
        </div-->
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
    styles() {
      return {
        link: [`color: ${this.theme.colors.primary}`].join(";")
      };
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
