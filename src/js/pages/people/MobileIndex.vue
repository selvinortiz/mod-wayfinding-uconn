<template>
  <content-loader :loaded="loaded.people && loaded.departments" classes="flex flex-wrap p-2">
    <div class="w-full">
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
      <div class="flex flex-wrap pt-2">
        <div class="w-1/2 flex" v-for="person in people" :key="person.id">
          <person-card :person="person"></person-card>
        </div>
      </div>
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
import PersonCard from "../../components/MobilePersonCard.vue";

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
        department: this.filters.department ? this.filters.department.id : ""
      };
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
