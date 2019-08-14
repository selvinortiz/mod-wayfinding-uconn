<template>
  <div class="p-4">
    <mod-page-header>Person</mod-page-header>
    <div class="font-thin text-2xl leading-none">
      <h2>{{ person.personFirstName }} {{ person.personLastName}}</h2>
      <p>{{ person.personEmail }}</p>
    </div>
    <div class="font-normal" v-html="person.personDescription"></div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";

export default {
  metaInfo() {
    return {
      title: this.title,
    }
  },
  data() {
    return {
      person: {}
    };
  },
  computed: {
    title() {
      return `${this.person.personFirstName} ${this.person.personLastName}`
    }
  },
  created() {
    axios
      .post("/actions/sys/wayfinding/person", {
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
