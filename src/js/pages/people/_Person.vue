<template>
  <content-loader :loaded="person.loaded" class="p-8">
    <page-header>Directory</page-header>
    <div class="flex flex-wrap justify-center">
      <div class="flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:mb-6 md:order-1">
        <mod-map :place="place"></mod-map>
      </div>
      <div class="lg:w-1/2 lg:order-1 md:w-full md:order-2">
        <div class="w-full flex flex-wrap justify-center">
          <div class="w-3/5 pt-4">
            <div
              class="text-2xl uppercase"
              :style="`color: ${theme.colors.primary}`"
            >{{ person.personFirstName }} {{ person.personLastName }}</div>

            <div class="pt-2" v-for="role in person.personRoles" :key="role.id">
              <p class="font-bold">{{ role.roleTitle }}</p>
              <p>{{ role.roleDepartment[0].title }}</p>
            </div>

            <div class="pt-4">
              <p class="font-bold">{{ person.personPhone }}</p>
              <p class="font-bold mb-4">{{ person.personEmail }}</p>
            </div>

            <!-- <div class="font-bold">Building Name</div>
            <div>Suite #</div>
            <div class="mb-4">Floor #</div>-->

            <div class="pt-4">
              <p>{{ person.personCity }}, {{ person.personState }} {{ person.personZipcode }}</p>
            </div>

            <div>{{ person.personDescription }}</div>
          </div>

          <div class="w-2/5" :style="`color: `">
            <img class="w-3/5 mb-6" style="max-width: 300px" src="/static/img/avatar.svg" />
          </div>
        </div>
      </div>
    </div>
  </content-loader>
</template>

<script>
import { person } from "../../utils/Axios";

export default {
  metaInfo() {
    return {
      title: this.title
    };
  },
  data() {
    return {
      person: {
        id: 0,
        loaded: false
      }
    };
  },
  created() {
    this.fetch();
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    title() {
      return `${this.person.personFirstName} ${this.person.personLastName}`;
    },
    place() {
      return this.person.loaded
        ? this.person.personRelatedPlace[0]
        : { id: null };
    }
  },
  methods: {
    fetch() {
      person({ id: this.$route.params.id })
        .then(response => {
          this.person = {
            ...response.data.person,
            loaded: true
          };
        })
        .catch(error => console.error(error));
    }
  },
  watch: {
    $route(to) {
      if (to.name === "person") {
        this.place = {};
        this.fetch();
      }
    }
  }
};
</script>
