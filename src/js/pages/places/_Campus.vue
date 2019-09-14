<template>
  <div class="p-8">
    <page-header>Wayfinding</page-header>

    <section class="lg:flex">
      <div class="lg:order-1">
        <mod-map :place="place"></mod-map>
      </div>
      <div class="lg:flex">
        <div class="w-1/3">
          <h2 class="text-4xl">{{ place.campusName || 'Loading...' }}</h2>
          <img class="w-full" src="https://picsum.photos/512?grayscale" alt />
          <div class="text-lg">
            <p>555-1234-5678</p>
            <p>
              <span class="block">{{ place.campusAddress || '123 Happy Street' }}</span>
              <span
                class="block"
              >{{ place.campusCity || 'Mod City' }}, {{ place.campusState || 'MN' }} {{ place.campusZipcode || '55555' }}</span>
            </p>
          </div>
        </div>
        <div class="w-2/3">
          <div class="lg:p-8">
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
              <template slot="singleLabel" slot-scope="{ option }">
                <strong>{{ option.buildingName }}</strong>
              </template>
            </multi-select>

            <div class="pt-4">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="text-blue-600 cursor-pointer"
                @click="() => $store.state.app.searchIsOpen = true"
              >Switch to SEARCH</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
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
    ModMap
  },
  data() {
    return {
      place: {
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
        console.log(this.place);
      })
      .catch(error => console.error(error));
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
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
