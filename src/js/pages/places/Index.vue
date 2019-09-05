<template>
  <div v-if="places" class="p-4">
    <div class="flex flex-wrap -mx-2 lg:-mx-4">
      <div class="w-full md:w-1/2 lg:w-1/3 xl:w-1/4 flex my-2 px-2 lg:my-4 lg:px-4" v-for="place in places" :key="place.id">
        <router-link class="flex-1 p-4 border border-gray-300 bg-gray-100 rounded" :to="{name: 'place', params: {id: place.id}}">
          <p class="font-thin text-2xl">{{ place.title }}</p>
          <router-link
            class="block text-xg text-blue-600"
            :to="{ name: typeString(place.typeId), params: {id: place.id} }"
          >#{{ place.id }}</router-link>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";

const types = {
  "4": "campus",
  "5": "building",
  "6": "floor",
  "7": "room"
}

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
  },
  methods: {
    typeString(typeId) {
      return types[typeId];
    }
  }
};
</script>
