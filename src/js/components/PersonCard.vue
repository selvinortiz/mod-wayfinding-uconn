<template>
  <router-link
    class="flex-1 flex cursor-pointer bg-white border border-gray-200 hover:bg-gray-200"
    :to="{ name: 'person', params: { id: person.id } }"
  >
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->
    <div class="block w-full shadow-md mr-4" :style="styles.background">
      <div v-if="directoryphoto" class="block">
        <img v-if="image" class="w-full object-contain" :src="image.url" />
        <img v-else src="/uploads/people/photos/GenericAvatar.jpg" />
      </div>
      <div class="block px-4 pt-4 pb-2">
        <h2
          class="font-bold text-base cursor-pointer uppercase"
          :style="styles.title"
        >
          {{ person.personFirstName }}
          {{ person.personLastName }}
        </h2>
      </div>
      <div class=" block w-full px-4 pb-4 overflow-x-hidden">
        <p v-if="role.title" class="text-base cursor-pointer">{{ role.title }}</p>
        <p v-if="role.department" class="text-base cursor-pointer">
          {{ role.department }}
        </p>
        <p v-if="role.building" class="text-base cursor-pointer">
          {{ role.building }}
        </p>
        <p v-if="role.building" class="text-base cursor-pointer">
          {{ role.suite }}
        </p>
        </div>
    </div>
  </router-link>
</template>

<script>
export default {
  props: {
    person: {
      type: Object,
      default: () => {
        null;
      }
    }
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        background: [`background-color: ${this.theme.directory.cards.bg}`].join(
          ";"
        ),
        title: [`color: ${this.theme.directory.cards.color}`].join(";")
      };
    },
    directoryphoto() {
      if (this.theme.directory.cards.cardphoto) {
        return true;
      }
      return false;
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
    role() {
      const role = {
        title: "",
        department: "",
        building: "",
        suite: ""
      };

      if (this.person.personRoles.length > 0) {
        return {
          title: this.person.personRoles[0].roleTitle,
          department: this.person.personRoles[0].roleDepartment[0].title,
          building: "",
          suite: ""
        };
      }
      return role;
    }
  }
};
</script>
