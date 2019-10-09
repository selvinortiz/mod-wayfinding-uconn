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
      class="w-full flex justify-right items-center self-end border-t border-dotted border-gray-500"
      style="height: 10vh;"
    >
      <div class="flex w-1/3 h-12 mt-1 mr-2 pr-8">
        <multi-select
          v-model="filters.department"
          track-by="title"
          label="title"
          placeholder="Filter by Department"
          :options="departments"
          :show-labels="false"
          :allow-empty="true"
          @input="fetchPeople"
        ></multi-select>
      </div>
      <div v-if="filters.department" class="flex w-1/3 h-12 mt-1 mr-2 px-8">
        <multi-select
          v-model="filters.letter"
          placeholder="Filter by Last Initial"
          :options="alphabet()"
          :show-labels="false"
          :allow-empty="true"
          @input="fetchPeople"
        ></multi-select>
      </div>
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
    fetchPeople() {
      this.loaded.people = false;

      const filters = {
        letter: this.filters.letter,
        department: this.filters.department ? this.filters.department.id : ''
      }
      axios
        .post("/actions/sys/wayfinding/people", { filters })
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
