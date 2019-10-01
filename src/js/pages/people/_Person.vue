<template>
  <content-loader :loaded="person.loaded" class="p-8">
    <section class="xl:flex flex-wrap">
      <div class="xl:w-1/2 xl:order-1">
        <mod-map :place="place" class="xl:px-4"></mod-map>
      </div>
      <div class="w-full flex flex-wrap xl:w-1/2 pt-4">
        <h2
          class="w-full font-thin text-4xl leading-none uppercase xl:pt-0 lg:pt-6 md:pt-6"
          :style="`color: ${theme.colors.primary}`"
        >
          {{ person.personFirstName }} {{ person.personLastName }}
        </h2>
        <div v-if="image" class="pt-8 pr-6" style="flex: 4;">
          <img
            class="m-auto object-contain"
            style="max-width: 256px;"
            :src="image.url"
          />

        </div>
        <div v-else class="pt-8 pr-6" style="flex: 4;">
          <img
            class="m-auto object-contain"
            style="max-width: 256px;"
            src="/uploads/people/photos/Oak Leaf avatar.jpg"
          />
        </div>
        <div style="flex: 8;">
          <div class="xl:pt-8 lg:pt-4, md-pt-4">
            <div class="pt-4" v-for="role in person.personRoles" :key="role.id">
              <p class="font-bold">{{ role.roleTitle }}</p>
              <p>{{ role.roleDepartment[0].title }}</p>
            </div>

            <div class="pt-4">
              <p class="font-bold">{{ building }} Building</p>
              <p class="font-normal">Suite: {{ room }}</p>
              <p class="font-normal">Floor: {{ floor }}</p>
            </div>

            <div class="pt-4">
              <p>{{ person.personAddress }}</p>
              <p>{{ person.personCity }}</p>
              <p>{{ person.personState }} {{ person.personZipcode }}</p>
            </div>

            <!-- <div class="pt-4">
              <a
                class="cursor-pointer"
                :style="`color: ${theme.colors.primary}`"
                @click="openInMaps"
                >{{ person.personCity }}, {{ person.personState }}
                {{ person.personZipcode }} &rarr;</a
              >
            </div> -->

            <div class="pt-4">
              <p class="font-bold">{{ person.personPhone }}</p>
              <p class="font-bold mb-4">{{ person.personEmail }}</p>
            </div>

            <!-- <div class="font-bold">Building Name</div>
              <div>Suite #</div>
            <div class="mb-4">Floor #</div>-->
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
