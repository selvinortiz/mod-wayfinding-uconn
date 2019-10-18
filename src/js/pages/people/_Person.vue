<template>
  <content-loader :loaded="person.loaded" class="p-16">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-3/5 xl:order-1">
        <mod-map :maps="place.maps" primary-map="building" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-2/5">
        <h2
          class="w-full font-thin text-4xl leading-none uppercase xl:pb-6 xl:pt-0 lg:py-8 md:py-8"
          :style="`color: ${theme.colors.primary}`"
        >
          {{ person.personFirstName }} {{ person.personLastName }}
        </h2>
        <div v-if="image && directoryPhoto" class="xl:pb-6 pr-6">
          <img
            class="object-contain"
            style="max-width: 256px;"
            :src="image.url"
          />

        </div>
        <div v-else-if="!image && directoryPhoto" class="xl:pb-6 pr-6">
          <img
            class="object-contain"
            style="max-width: 256px;"
            src="/uploads/people/photos/Oak Leaf avatar.jpg"
          />
        </div>
        <div>
          <div>
            <div v-for="role in person.personRoles" :key="role.id" class="pb-4">
              <p class="font-bold">{{ role.roleTitle }}</p>
              <p>{{ role.roleDepartment[0].title }}</p>
            </div>

            <div v-if="place.ancestors" class="pb-4">
              <p v-if="building" class="font-bold">{{ building }} Building</p>
              <p v-if="room" class="font-normal">Suite: {{ room }}</p>
              <p v-if="floor" class="font-normal">Floor: {{ floor }}</p>
              <p v-if="campus" class="font-normal">{{ campus }} Campus</p>
            </div>
            <div v-if="person.Address || person.personCity || person.personstate" class="pb-4">
              <p v-if="person.Address">{{ person.personAddress }}</p>
              <p v-if="person.personCity">{{ person.personCity }}</p>
              <p v-if="person.personstate" >{{ person.personState }} {{ person.personZipcode }}</p>
            </div>
            <div v-if="person.personPhone || person.personEmail" class="pb-4">
              <p v-if="person.personPhone" class="font-bold">{{ person.personPhone }}</p>
              <p v-if="person.personEmail" class="font-bold">{{ person.personEmail }}</p>
            </div>
            <div class="pb-4 h-40 xl:h-56 w-4/5 overflow-y-auto" v-html="person.personDescription"></div>
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
    campus() {
       if (this.place && this.place.ancestors && this.place.ancestors.length) {
        return this.place.ancestors[2].campusName;
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
