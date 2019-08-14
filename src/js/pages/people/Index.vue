<template>
  <div>
    <h1 class="text-xl p-4">People</h1>
    <div v-if="people">
      <div class="flex flex-col" v-for="person in people" :key="person.id">
        <span>{{ person.personFirstName }}</span>
        <span>{{ person.personLastName }}</span>
        <span>{{ person.personEmail }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";

export default {
  metaInfo: {
    title: "People"
  },
  data() {
    return {
      people: []
    };
  },
  created() {
    axios
      .post("/actions/sys/wayfinding/people")
      .then(response => {
        if (!response.data.success) {
          return console.log(response.data.message);
        }

        this.people = response.data.people;
      })
      .catch(error => console.error(error));
  }
};
</script>
