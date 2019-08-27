<template>
  <div class="p-4">
    <!--mod-page-header>Person</mod-page-header-->

    <div class="w-full flex flex-wrap justify-center lg:hidden">
        <div class="lg:w-11/12 w-full mb-4">
          <div :class="'text-3xl text-'+primaryColor+' font-300'">DIRECTORY</div>
          <div :class="'text-1xl text-'+primaryColor">
            {{ 'Breadcrumb nav 1' }}
            >
            {{ 'Breadcrumb nav 2' }}
          </div>
        </div>
    </div>
    
    <div class="flex flex-wrap">

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1">

        <div class="flex w-full">
          <mod-map :place="person"></mod-map>
        </div>

        <div class="flex w-full lg:justify-end md:justify-center sm:justify-center">

          <button :class="'flex w-1/4 justify-center m-4 bg-transparent '+
                          'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                          'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor">
            Campus Map
          </button>

          <button :class="'flex w-1/4 justify-center m-4 bg-transparent '+
                          'font-semibold hover:text-white py-2 px-4 border hover:border-transparent '+
                          'hover:bg-'+primaryColor+' text-'+primaryColor+' border-'+primaryColor">
            Building Map
          </button>

        </div>

      </div>

      <!--Half page-->
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2">

        <!--Weird height issues-->
        <div class="w-full justify-center hidden lg:flex">
            <div class="lg:w-11/12 w-full mb-4">
              <div :class="'text-3xl text-'+primaryColor+' font-300'">DIRECTORY</div>
              <div :class="'text-1xl text-'+primaryColor">
                {{ 'Breadcrumb nav 1' }}
                >
                {{ 'Breadcrumb nav 2' }}
              </div>
            </div>
        </div>

        <div class="flex flex-wrap w-11/12">

          <!--Half-->
          <div :class="'w-3/5 text-'+primaryColor">

            <div :class="'font-black mb-4 text-2xl text-'+primaryColor">{{ person.personFirstName }} {{ person.personLastName}}</div>

            <div class="font-bold">Title 1</div>
            <div>Department</div>
            <div class="font-bold">Title 2</div>
            <div class="mb-4">Department</div>

            <div class="font-bold">Building Name</div>
            <div>Suite #</div>
            <div class="mb-4">Floor #</div>

            <div>Address Line 1</div>
            <div class="mb-4">Address Line 2</div>

            <div class="font-bold">{{person.personPhone}}</div>
            <div class="font-bold mb-4">{{person.personEmail}}</div>

            <div>{{person.personDescription}}</div>

          </div>

          <!--Half-->
          <div class="w-2/5 text-center">

            <img class="w-3/5 mb-6" style="max-width: 300px" src="http://placehold.it/500"/>

            <div :class="'w-3/5 w-auto text-'+primaryColor+' border border-'+primaryColor">Send to Phone</div>

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
      person: {},

      primaryColor: 'blue-800'
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
