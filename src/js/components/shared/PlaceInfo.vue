<template>
  <div :style="containerStyles">
    <people-place-header heading="WAYFINDING" classes="hidden lg:flex"></people-place-header>

    <div class="w-full flex flex-wrap justify-center p-4">
      <div class="w-full mb-4 text-2xl font-black">{{place.title}}</div>

      <!-- Half -->
      <div class="w-1/2">
        <img class="w-4/5 mb-4" src="http://placehold.it/500" />

        <div class="font-bold mb-4">Phone Number</div>
        <div class="font-bold">Address Line 1</div>
        <div class="font-bold mb-4">Address Line 2</div>
        <div>Place Description</div>
      </div>

      <!-- Half -->
      <div class="w-1/2 text-center">
        <select :class="'w-full flex items-center h-12 px-6 border-2 border-'+primaryColor">
          <option class="hidden" value disabled selected>Choose Destination</option>
        </select>

        <div>
          Don't see what you're looking for? <a @click="() => $store.state.app.searchIsOpen = true">Switch to SEARCH</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import PeoplePlaceHeader from "../../components/shared/PeoplePlaceHeader.vue";

export default {
  components: {
    PeoplePlaceHeader
  },
  props: {
    place: {
      type: Object,
      default: () => ({
        id: 0,
        title: "",
        maps: [
          {
            image: ""
          },
          {
            markers: [{ x: 0, y: 0 }]
          }
        ]
      })
    }
  },
  computed: {
    theme() {
      return this.$store.state.app.theme
    }
  },
  methods: {
    containerStyles() {
      return [
        `background-color: white`,
        `color: black`
      ].join(';')
    }
  }
};
</script>
