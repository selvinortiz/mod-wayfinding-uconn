<template>
  <content-loader :loaded="person.loaded" class="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 pt-4">
        <div class="pt-8" style="flex: 4;">
          <img style="max-width: 256px;" src="/static/img/avatar.svg" />
        </div>
        <div style="flex: 8;">
          <div class="pt-8 px-4">
            <h2
              class="font-thin text-4xl leading-none uppercase"
              :style="`color: ${theme.colors.primary}`"
            >{{ person.personFirstName }} {{ person.personLastName }}</h2>

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
              <a
                class="cursor-pointer"
                :style="`color: ${theme.colors.primary}`"
                @click="openInMaps"
              >{{ person.personCity }}, {{ person.personState }} {{ person.personZipcode }} &rarr;</a>
            </div>

            <div class="pt-4" v-html="person.personDescription"></div>
          </div>
        </div>
      </div>
    </section>
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
      const place = this.person.loaded
        ? this.person.personRelatedPlace[0]
        : { id: null };

      if (place.id) {
        place.loaded = true;
      }

      return place;
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
    },
    openInMaps() {
      const address = `maps.google.com/maps?daddr=${[
        this.person.personCity,
        this.person.personState,
        this.person.personZipcode
      ].join("+")}&ll=`;

      if (navigator.platform.includes("iP")) {
        window.open(`https://${address}`);
      } else {
        window.open(`maps://${address}`);
      }
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
