<template>
  <div v-if="people" class="flex flex-wrap">
    <div class="w-full p-4 overflow-y-scroll overflow-x-hidden" style="height: 60vh">
      <page-header>Directory</page-header>

      <div class="mb-5 text-1xl font-300">Select the person you&rsquo;re looking for:</div>

      <div class="flex flex-wrap -mx-2 lg:-mx-4">
        <div
          class="w-1/2 sm:w-1/3 md:w-1/3 lg:w-1/4 xl:w-1/5 flex my-2 px-2 lg:my-4 lg:px-4"
          v-for="person in people"
          :key="person.id"
        >
          <person-card :person="person"></person-card>
        </div>
      </div>
    </div>

    <div
      class="w-full flex justify-center items-center px-4 border-t border-dotted border-gray-500"
      style="height: 10vh"
    >
      <select
        value
        @input="handleSelectedFilter('letter', $event)"
        class="flex w-1/2 h-12 mt-1 mr-2 px-8 border-2 border-blue-800"
      >
        <option class="hidden" value disabled selected>Filter by Last Initial</option>
        <option v-for="option in alphabet()" :key="option" :value="option">{{option}}</option>
      </select>

      <select
        value
        @input="handleSelectedFilter('department', $event)"
        class="flex w-1/2 h-12 mt-1 ml-2 px-8 border-2 border-blue-800"
      >
        <option class="hidden" value disabled selected>Filter by Department</option>
        <option
          v-for="department in departments"
          :key="department.id"
          :value="department.id"
        >{{department.title}}</option>
      </select>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import PersonCard from "../../components/PersonCard.vue";

export default {
  metaInfo: {
    title: "People"
  },
  components: {
    PersonCard
  },
  data() {
    return {
      filters: {
        letter: "",
        department: ""
      },
      people: [],
      departments: []
    };
  },
  created() {
    this.fetchPeople();
    this.fetchDepartments();
  },
  methods: {
    fetchPeople(params = {}) {
      axios
        .post("/actions/sys/wayfinding/people", params)
        .then(response => {
          if (response.data.success) {
            this.people = response.data.people;
          }
        })
        .catch(error => console.error(error));
    },
    fetchDepartments() {
      axios
        .post("/actions/sys/wayfinding/departments")
        .then(response => {
          if (response.data.success) {
            this.departments = response.data.departments;
          }
        })
        .catch(error => console.error(error));
    },
    handleSelectedFilter(name, event) {
      this.filters = {
        ...this.filters,
        [name]: event.target.value
      };

      this.$nextTick(() => this.fetchPeople({ filters: this.filters }));
    },
    alphabet() {
      var alphabet = [];
      for (var i = 0; i < 25; i++) {
        var char = String.fromCharCode(65 + i);
        alphabet.push(char);
      }
      return alphabet;
    }
  }
};
</script>
