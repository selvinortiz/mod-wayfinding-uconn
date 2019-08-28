<template>
  <div v-if="people" class="flex flex-wrap">
    <div class="w-full p-4 overflow-scroll" style="height: 60vh">
      <!--mod-page-header>People</mod-page-header-->

      <div class="mb-1 text-3xl text-blue-800 font-300">DIRECTORY</div>
      <div class="mb-5 text-1xl font-300">Select the party you're looking for:</div>

      <div class="flex flex-wrap -mx-2 lg:-mx-4">

        <!-- Changed number of cards to fit more -->
        <div
          class="w-1/2 sm:w-1/3 md:w-1/3 lg:w-1/4 xl:w-1/5 flex my-2 px-2 lg:my-4 lg:px-4"
          v-for="person in people" :key="person.id">

          <router-link
            class="flex-1 border border-gray-300 bg-gray-100 rounded"
            :to="{name: 'person', params: {id: person.id}}">

            <img class="w-full" src="http://placehold.it/500/500"/>

            <div class="w-full p-2">

              <p class="font-bold text-2xl">
                {{ person.personFirstName }}
                {{ person.personLastName }}
              </p>
              <p>
                Role
                <!--{{ person.personFirstName }}-->
              </p>
              <p>
                Suite #
                <!--{{ person.personFirstName }}-->
              </p>
              <p>
                Can't tell what goes here
                <!--{{ person.personFirstName }}-->
              </p>

            </div>

            <!--
            <router-link
              class="block text-lg text-blue-600"
              :to="{name: 'person', params: {id: person.id}}"
            >{{ person.personEmail }}
            </router-link>
            <p v-if="person.personPhone">{{ person.personPhone }}</p>
            -->

          </router-link>
          
        </div>

      </div>

    </div>

    <div class="w-full flex justify-center items-center px-3" style="height: 10vh">

      <select class="flex w-1/2 h-12 mt-1 mr-2 px-6 border-2 border-blue-800">
        <option class="hidden" value="" disabled selected>Filter by Last Initial</option>
        <option v-for="option in getAlphabet()" :key="option" :value="option">{{option}}</option>
      </select>

      <select class="flex w-1/2 h-12 mt-1 ml-2 px-6 border-2 border-blue-800">
        <option class="hidden" value="" disabled selected>Filter by Department</option>
      </select>
      
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
  methods: {
    getAlphabet() {
      var alphabet = [];
      for (var i = 0; i < 25; i++) {
        var char = String.fromCharCode(65 + i);
        alphabet.push(char);
      }
      return alphabet;
    }
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
