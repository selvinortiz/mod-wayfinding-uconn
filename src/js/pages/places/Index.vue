<template>
  <div class="p-4">
    <h1 class="font-thin text-4xl">Places</h1>
    <div v-if="places">
      <div class="flex py-4 border-t border-gray-200" v-for="place in places" :key="place.id">
        <p class="flex-1">{{ place.title }}</p>
        <p class="flex-1">
          <router-link :to="{name: 'places/place', params: {id: place.id}}">{{ place.id }}</router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";

export default {
  metaInfo: {
    title: "Places"
  },
  data() {
    return {
      places: []
    };
  },
  created() {
    axios
      .post("/actions/sys/wayfinding/places")
      .then(response => {
        if (!response.data.success) {
          return console.error(response.data.message);
        }

        this.places = response.data.places;
      })
      .catch(error => console.error(error));
  }
};
</script>
