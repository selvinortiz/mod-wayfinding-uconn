<template>
  <div class="p-8">

    <!--mod-page-header>Person</mod-page-header-->

    <people-place-header heading="DIRECTORY" classes="flex lg:hidden" :primaryColor="primaryColor"></people-place-header>

    
    <div class="flex flex-wrap justify-center">

      <div class="flex flex-wrap justify-center 
      lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">

        <mod-map :place="person" :primaryColor="primaryColor"></mod-map>

      </div>

      
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2 m-x-0"
      style="outline: 1px red solid">

        <person-info :person="person" :primaryColor="primaryColor"></person-info>
          
      </div>

    </div>

  </div>
</template>

<script>
import axios from "../../utils/Axios";
import PeoplePlaceHeader from '../../components/shared/PeoplePlaceHeader.vue'
import ModMap from '../../components/shared/ModMap.vue'
import PersonInfo from '../../components/shared/PersonInfo.vue'

export default {
  metaInfo() {
    return {
      title: this.title,
    }
  },
  components: {
    PeoplePlaceHeader,
    ModMap,
    PersonInfo
  },
  data() {
    return {
      person: {},

      primaryColor: 'blue-800'
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
