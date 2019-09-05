<template>
  <div class="p-8">
    <div class="w-full flex-wrap pl-4 md:mb-4">
      <div class="w-full text-3xl font-300">{{ person.title }}</div>
      <div class="w-full text-1xl">
          {{ 'Breadcrumb nav 1' }}
          >
          {{ 'Breadcrumb nav 2' }}
      </div>
    </div>

    <div class="flex flex-wrap justify-center">
      <div class="flex flex-wrap justify-center
      lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">
        <mod-map :place="person"></mod-map>
      </div>
      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">
        <person-info :person="person"></person-info>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModMap from '../../components/shared/ModMap.vue'
import PersonInfo from '../../components/shared/PersonInfo.vue'

export default {
  metaInfo() {
    return {
      title: this.title,
    }
  },
  components: {
    ModMap,
    PersonInfo
  },
  data() {
    return {
      person: {},

      // Not Used
      //primaryColor: this.$store.state.app.theme.main.directory.text
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
        this.person = response.data.person;
        //console.log(this.person);
      })
      .catch(error => console.error(error));
  }
};
</script>
