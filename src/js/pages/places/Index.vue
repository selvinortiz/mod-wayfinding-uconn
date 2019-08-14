<template>
  <div v-if="places" class="p-4">
    <h1 class="font-thin text-4xl">Places</h1>
    <div class="flex flex-wrap -mx-2 lg:-mx-4">
      <div class="w-full md:w-1/2 lg:w-1/3 xl:w-1/4 flex my-2 px-2 lg:my-4 lg:px-4" v-for="place in places" :key="place.id">
        <router-link class="flex-1 p-4 border border-gray-300 bg-gray-100 rounded" :to="{name: 'place', params: {id: place.id}}">
          <p class="font-thin text-2xl">{{ place.title }}</p>
          <p class="font-thin text-2xl">#{{ place.id }}</p>
        </router-link>
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
