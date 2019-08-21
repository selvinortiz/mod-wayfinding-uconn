<template>
  <div class="p-4">
    <mod-page-header>Person</mod-page-header>
    <div class="font-thin text-2xl leading-none">
      <h2>{{ person.personFirstName }} {{ person.personLastName}}</h2>
      <p>{{ person.personEmail }}</p>
    </div>
    <div class="font-normal" v-html="person.personDescription"></div>
    
    <mod-map :id="person.id" :title="person.title" :images="person.images"></mod-map>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from '../../components/shared/ModMap.vue'

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
  components: {
    ModMap
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
        this.person = response.data.person;
        this.person.images = ['/svg/testSVG1.svg', '/svg/testSVG2.svg'];  // Only for testing
      })
      .catch(error => console.error(error));
  }
};
</script>
