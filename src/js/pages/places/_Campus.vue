<template>
  <content-loader :loaded="place.loaded" class="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1 lg">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 xl:pt-6">
        <div class="w-1/2">
          <div>
            <page-header
              class="block xl:hidden md:block sm:block"
            >{{ place.campusName }} {{ place.type.name }}</page-header>
            <ui-photo :photo="photo"></ui-photo>
            <div>
              <page-header
                class="hidden xl:block md:hidden sm:hidden pt-4 text-xl xl:text-4xl"
              >{{ place.campusName }} {{ place.type.name }}</page-header>
              <p class="pt-8 text-xl leading-tight">
                <span class="block" :style="styles.defaultColor">
                  From Horsebarn Hill to Downtown Storrs, our picturesque main
                  campus is home to more than 19,000 undergraduates, as well as
                  graduate students pursuing one of 17 graduate degrees or a
                  doctorate in pharmacy.
                </span>
              </p>
            </div>
          </div>
        </div>
        <div class="w-1/2">
          <div class="pt-20 xl:pt-0 px-4">
            <multi-select
              track-by="id"
              label="buildingName"
              placeholder="Chose Building"
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
