<template>
  <h1 class="text-xl p-4">Place</h1>
</template>

<script>
import axios from "../../utils/Axios";

export default {
  metaInfo: {
    title: "Place"
  },
  created() {
    axios.post("/actions/sys/wayfinding/place", {
      id: this.$route.params.id
    })
    .then(response => {
      console.log(response.data)
    })
    .catch(error => console.error(error));
  }
};
</script>
