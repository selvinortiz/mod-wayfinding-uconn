<template>
  <div v-if="people" class="p-4">
    <mod-page-header>People</mod-page-header>

    <div class="flex flex-wrap -mx-2 lg:-mx-4">

      <div
        class="w-full md:w-1/2 lg:w-1/3 xl:w-1/4 flex my-2 px-2 lg:my-4 lg:px-4"
        v-for="person in people"
        :key="person.id"
      >
        <router-link
          class="flex-1 border border-gray-300 bg-gray-100 rounded"
          :to="{name: 'person', params: {id: person.id}}"
        >

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
        console.log(this.people);
      })
      .catch(error => console.error(error));
  }
};
</script>
