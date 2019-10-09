<template>
  <content-loader
    :loaded="loaded.people && loaded.departments"
    classes="flex flex-wrap p-16"
  >
    <div class="pb-4">
      <page-header class="uppercase">Directory</page-header>
    </div>
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
      class="w-full overflow-y-scroll overflow-x-hidden"
      style="height: 60vh"
    >
      <div class="flex flex-wrap">
        <div
          class="w-1/2 max-h-screen sm:w-1/3 md:w-1/4 xl:w-1/6 lg:w-1/4 flex my-2 px-0"
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
      <!-- <select
        :value="filters.letter"
        @input="handleSelectedFilter('letter', $event)"
        class="flex w-1/2 h-12 mt-1 mr-2 px-8 border-2"
        :style="styles.border"
      >
        <option value="">{{ defaultLetterFilterLabel }}</option>
        <option v-for="option in alphabet()" :key="option" :value="option">
          {{ option }}
        </option>
      </select> -->
      <div class="flex w-1/2 h-12 mt-1 mr-2 px-8">
        <multi-select
          v-model="filters.letter"
          placeholder="Filter by Last Initial"
          value
          :options="alphabet()"
          :show-labels="false"
          :allow-empty="true"
          @input="handleSelectedFilter('Letter', $event)"
        ></multi-select>
      </div>
      <div class="flex w-1/2 h-12 mt-1 mr-2 px-8">
        <multi-select
          v-model="filters.department"
          track-by="id"
          label="title"
          placeholder="Filter by Department"
          value
          :options="departments"
          :show-labels="false"
          :allow-empty="true"
          @input="handleSelectedFilter('Department', $event)"
        ></multi-select>
      </div>
      <!-- <select
        :value="filters.department"
        @input="handleSelectedFilter('department', $event)"
        class="flex w-1/2 h-12 mt-1 ml-2 px-8 border-2"
        :style="styles.border"
      >
        <option value="">{{ defaultDepartmentFilterLabel }}</option>
        <option
          v-for="department in departments"
          :key="department.id"
          :value="department.id"
          >{{ department.title }}</option
        >
      </select> -->
    </div>
    <div class="m-auto">
      Don&rsquo;t see what you&rsquo;re looking for?
      <a
        class="cursor-pointer"
        :style="styles.defaultColor"
        @click="() => ($store.state.app.searchIsOpen = true)"
        >Switch to SEARCH</a
      >
    </div>
  </content-loader>
</template>

<style>
.multiselect__select:before {
  top: 80%;
  color: #000e2f;
  border-color: #000e2f transparent transparent transparent;
  border-width: 12px 12px 0;
}
.multiselect__option--highlight {
  color: #fff;
  background-color: #000e2f;
}
.multiselect__tags {
  border: 2px solid #000e2f;
  border-radius: 0;
}
.multiselect__placeholder {
  color: #000e2f;
}
</style>

<script>
import axios from "../../utils/Axios";
import PersonCard from "../../components/PersonCard.vue";

export default {
  name: "people",
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
    },
    defaultLetterFilterLabel() {
      if (this.filters.letter === "") {
        return "Filter by Last Initial";
      }

      return "Clear Last Initial Filter";
    },
    defaultDepartmentFilterLabel() {
      if (this.filters.department === "") {
        return "Filter by Department";
      }

      return "Clear Department Filter";
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
      if (name === 'Letter') {
        console.log(name + " " + event);
      this.filters = {
        ...this.filters,
        [name]: event
      };
      console.log({filters: this.filters});
      } else {
        this.filters = {
        ...this.filters,
        [name]: event.title
        };
      }

      this.$nextTick(() => this.fetchPeople({ filters: this.filters}));
    },
    alphabet() {
      var alphabet = [];
      for (var i = 0; i < 26; i++) {
        var char = String.fromCharCode(65 + i);
        alphabet.push(char);
      }
      return alphabet;
    }
  }
};
</script>
