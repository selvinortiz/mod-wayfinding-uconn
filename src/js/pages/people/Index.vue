<template>
  <content-loader
    :loaded="loaded.people && loaded.departments"
    classes="flex flex-wrap"
  >
    <div
      v-if="!this.people.length"
      class="flex-1 flex items-center justify-center"
      style="height: 65vh;"
    >
      <h1 class="font-thin text-4xl text-center">
        We did not find anyone matching your criteria.
      </h1>
    </div>
    <div
      v-else
      class="w-full p-4 overflow-y-scroll overflow-x-hidden"
      style="height: 60vh"
    >
      <page-header>Directory</page-header>

      <div class="flex flex-wrap -mx-2 xl:-mx-4">
        <div
          class="w-1/2 max-h-screen sm:w-1/4 md:w-1/4 xl:w-1/6 lg:w-1/4 flex my-2 px-0 xl:px-0 lg:px-0"
          v-for="person in people"
          :key="person.id"
        >
          <person-card :person="person"></person-card>
        </div>
      </div>
    </div>

    <div
      class="w-full flex justify-center items-center self-end px-4 border-t border-dotted border-gray-500"
      style="height: 10vh;"
    >
      <select
        :value="filters.letter"
        @input="handleSelectedFilter('letter', $event)"
        class="flex w-1/2 h-12 mt-1 mr-2 px-8 border-2"
        :style="styles.border"
      >
        <option class="hidden" value disabled selected
          >Filter by Last Initial</option
        >
        <option v-for="option in alphabet()" :key="option" :value="option">{{
          option
        }}</option>
      </select>

      <select
        :value="filters.department"
        @input="handleSelectedFilter('department', $event)"
        class="flex w-1/2 h-12 mt-1 ml-2 px-8 border-2"
        :style="styles.border"
      >
        <option class="hidden" value disabled selected
          >Filter by Department</option
        >
        <option
          v-for="department in departments"
          :key="department.id"
          :value="department.id"
          >{{ department.title }}</option
        >
      </select>
    </div>
    <div class="m-auto">
              Don&rsquo;t see what you&rsquo;re looking for?
              <a
                class="cursor-pointer"
                :style="styles.defaultColor"
                @click="() => ($store.state.app.searchIsOpen = true)"
              >Switch to SEARCH</a>
    </div>
  </content-loader>
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
      loaded: {
        people: false,
        departments: false
      },
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
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        border: [`border-color: ${this.theme.colors.primary}`].join(";"),
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";")
      };
    }
  },
  methods: {
    fetchPeople(params = {}) {
      this.loaded.people = false;
      axios
        .post("/actions/sys/wayfinding/people", params)
        .then(response => {
          if (response.data.success) {
            this.people = response.data.people;
          } else {
            this.people = [];
          }

          this.loaded.people = true;
        })
        .catch(error => console.error(error));
    },
    fetchDepartments() {
      this.loaded.departments = false;

      axios
        .post("/actions/sys/wayfinding/departments")
        .then(response => {
          if (response.data.success) {
            this.departments = response.data.departments;
            this.loaded.departments = true;
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
