<template>
  <div>
    <h1 class="text-xl p-4">Places</h1>
    <div v-if="places">
      <div class="flex flex-col" v-for="place in places" :key="place.id">
        <span>{{ place.id }}</span>
        <span>{{ place.title }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  metaInfo: {
    title: "Places"
  },
  created() {
    axios
      .post("/actions/sys/wayfinding/places")
      .then(response => {
        if (!response.data.success) {
          return console.log(response.data.message);
        }

        this.places = response.data.places;
      })
      .catch(error => console.error(error));
  }
};
</script>
