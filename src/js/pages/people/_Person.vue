<template>
  <content-loader :loaded="person.loaded" class="p-16">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1">
        <mod-map :maps="place.maps" primary-map="building" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2">
        <h2
          class="w-full font-thin text-4xl leading-none uppercase xl:pb-6 xl:pt-0 lg:py-8 md:py-8"
          :style="`color: ${theme.colors.primary}`"
        >
          {{ person.personFirstName }} {{ person.personLastName }}
        </h2>
        <div v-if="image && directoryPhoto" class="pr-6">
          <img
            class="object-contain"
            style="max-width: 256px;"
            :src="image.url"
          />

        </div>
        <div v-else-if="!image && directoryPhoto" class="pr-6">
          <img
            class="object-contain"
            style="max-width: 256px;"
            src="/uploads/people/photos/Oak Leaf avatar.jpg"
          />
        </div>
        <div>
          <div>
            <div class="pb-4" v-for="role in person.personRoles" :key="role.id">
              <p class="font-bold">{{ role.roleTitle }}</p>
              <p>{{ role.roleDepartment[0].title }}</p>
            </div>

            <div class="pb-4">
              <p class="font-bold">{{ building }} Building</p>
              <p class="font-normal">Suite: {{ room }}</p>
              <p class="font-normal">Floor: {{ floor }}</p>
            </div>
            <div class="pb-4">
              <p>{{ person.personAddress }}</p>
              <p>{{ person.personCity }}</p>
              <p>{{ person.personState }} {{ person.personZipcode }}</p>
            </div>
            <div class="pb-4">
              <p class="font-bold">{{ person.personPhone }}</p>
              <p class="font-bold">{{ person.personEmail }}</p>
            </div>
            <div class="h-40 xl:h-56 w-4/5 overflow-y-auto" v-html="person.personDescription"></div>
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
    image() {
      if (
        this.person &&
        this.person.personPhoto &&
        this.person.personPhoto.length
      ) {
        return this.person.personPhoto[0];
      }
      return null;
    },
    directoryPhoto()
    {
      if (this.theme.directory.photo)
      {
        return true
      }
        return false
    },
    place() {
      let place = this.person.loaded ? this.person.place : null;

      if (!place) {
        place = { id: null };
      }

      place.loaded = true;

      return place;
    },
    floor() {
      if (this.place && this.place.ancestors && this.place.ancestors.length) {
        return this.place.ancestors[0].floorNumber;
      }
      return null;
    },
    building() {
      if (this.place && this.place.ancestors && this.place.ancestors.length) {
        return this.place.ancestors[1].buildingName;
      }
      return null;
    },
    room() {
      if (this.place && this.place.ancestors && this.place.ancestors.length) {
        return this.place.roomNumber;
      }
      return null;
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
        this.person.personAddress,
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
        this.person = {};
        this.fetch();
      }
    }
  }
};
</script>
