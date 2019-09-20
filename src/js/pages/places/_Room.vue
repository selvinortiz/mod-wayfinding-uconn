<template>
  <content-loader :loaded="place.loaded" classes="p-8">
    <page-header>Back</page-header>

    <section class="lg:flex flex-wrap">
      <div class="w-full lg:w-2/3 lg:order-1">
        <mod-map :place="place" class="p-8 pl-4"></mod-map>
      </div>
      <div class="w-full lg:w-1/3">
        <div class="p-8 pr-4">
          <h2 class="font-thin text-4xl pt-4">{{ place.title }}</h2>

          <div class="text-xl">
            <p class="pt-4">
              <span class="block">{{ '123 Placeholder Lane' }}, {{ place.roomNumber }}</span>
              <span
                class="block"
              >{{ 'City' }}, {{ 'State' }} {{ 'Zipcode' }}</span>
            </p>
          </div>
        </div>
      </div>
    </section>
  </content-loader>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from "../../components/shared/ModMap.vue";
import PlaceInfo from "../../components/shared/PlaceInfo.vue";

export default {
  metaInfo: {
    title: "Place"
  },
  components: {
    ModMap,
    PlaceInfo
  },
  data() {
    return {
      place: {
        id: 0,
        loaded: false,
        ancestors: [],
      }
    };
  },
  created() {
    this.fetch();
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
          ancestors: [],
        };
        this.fetch();
      }
    }
  }
};
</script>
