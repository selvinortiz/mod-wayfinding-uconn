<template>
  <content-loader :loaded="place.loaded" class="p-8">
    <page-header>Wayfinding</page-header>
    <section class="lg:flex flex-wrap">
      <div class="lg:w-1/2 lg:order-1 lg">
        <mod-map :place="place" class="lg:px-4 mt-6"></mod-map>
      </div>
      <div class="w-full flex flex-wrap lg:w-1/2 lg:pt-6">
        <div class="w-1/2">
          <div>
            <building-name
              >{{ place.campusName }} {{ place.type.name }}</building-name
            >
            <ui-photo :photo="photo"></ui-photo>
            <div>
              <p class="pt-4 text-xl lg:text-4xl">
                <span class="hidden lg:block md:hidden sm:hidden " :style="styles.defaultColor"
                  >{{ place.campusName }} {{ place.type.name }}</span
                >
              </p>
              <p class="pt-2 text-2x1">
                <span class="block" :style="styles.defaultColor"
                  >From Horsebarn Hill to Downtown Storrs, our picturesque main
                  campus is home to more than 19,000 undergraduates, as well as
                  graduate students pursuing one of 17 graduate degrees or a
                  doctorate in pharmacy.</span
                >
              </p>
            </div>
          </div>
        </div>
        <div class="w-1/2">
          <div class="pt-16 lg:pt-0 md:pt-16 sm:pt-16 px-4">
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
  border: 2px solid #c0d;
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
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";"),
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
