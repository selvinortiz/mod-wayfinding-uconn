<template>
  <div class="p-4">
    <h1 class="font-thin text-4xl">People</h1>
    <div v-if="people">
      <div class="flex py-4 border-t border-gray-200" v-for="person in people" :key="person.id">
        <p class="flex-1">{{ person.personFirstName }}</p>
        <p class="flex-1">{{ person.personLastName }}</p>
        <p class="flex-1">{{ person.personEmail }}</p>
        <p class="flex-1">
          <router-link :to="{name: 'people/person', params: {id: person.id}}">
            {{ person.id }}
          </router-link>
        </p>
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
