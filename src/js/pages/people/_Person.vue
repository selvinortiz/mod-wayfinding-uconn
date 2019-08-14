<template>
  <div class="p-4">
    <h1 class="font-thin text-4xl">Person</h1>
    <p>
      {{ person.personFirstName }} {{ person.personLastName}}
      <br>
      {{ person.personEmail }}
    </p>
  </div>
</template>

<script>
import axios from "../../utils/Axios";

export default {
  metaInfo: {
    title: "Person"
  },
  data() {
    return {
      person: {}
    }
  },
  created() {
    axios.post("/actions/sys/wayfinding/person", {
      id: this.$route.params.id
    })
    .then(response => {
      if (!response.data.success) {
        return console.error(response.data.message);
      }

      this.person = response.data.person;
    })
    .catch(error => console.error(error));
  }
};
</script>
