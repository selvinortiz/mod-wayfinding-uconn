<template>
  <div class="p-4">
    <!--mod-page-header>Person</mod-page-header-->

    <div class="font-normal" v-html="person.personDescription"></div>
    
    <div class="flex flex-wrap">

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1">

        <div class="flex w-4/5">
          <!--mod-map :place="person"></mod-map-->
          <!--Map Placeholder-->
          <img class="w-4/5" src="http://placehold.it/1000"/>
        </div>

        <div class="flex w-full lg:justify-end md:justify-center sm:justify-center">

          <div class="flex w-1/4 h-6 border border-gray-300 bg-gray-100 justify-center">
            Campus Map
          </div>

          <div class="flex w-1/4 h-6 border border-gray-300 bg-gray-100 justify-center">
            Building Map
          </div>

        </div>

      </div>

      <!--Half page-->
      <div class="flex justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <div class="flex flex-wrap w-4/5">

          <div class="w-full">
            <div>DIRECTORY</div>
            <div>Breadcrumb nav 1 > Breadcrumb nav 2</div>
          </div>

          <!--Half-->
          <div class="w-3/5">

            <div class="font-black">{{ person.personFirstName }} {{ person.personLastName}}</div>
            <br/>

            <div class="font-bold">Title 1</div>
            <div>Department</div>
            <div class="font-bold">Title 2</div>
            <div>Department</div>
            <br/>

            <div class="font-bold">Building Name</div>
            <div>Suite #</div>
            <div>Floor #</div>
            <br/>

            <div>Address Line 1</div>
            <div>Address Line 2</div>
            <br/>

            <div class="font-bold">Phone Number</div>
            <div class="font-bold">{{person.email}}</div>

          </div>

          <!--Half-->
          <div class="w-2/5">

            <img class="w-4/5" src="http://placehold.it/500"/>

          </div>

        </div>
          
      </div>

    </div>

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
      })
      .catch(error => console.error(error));
  }
};
</script>
