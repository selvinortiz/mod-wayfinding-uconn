<template>
  <router-link
    class="flex-1 flex cursor-pointer border-2 border-transparent"
    :to="{ name: 'person', params: { id: person.id } }"
  >
    <div :style="styles.background">
      <div v-if="directoryphoto" class="block">
        <img v-if="image" class="w-full" :src="image.url" />
        <img v-else class="w-full" src="/uploads/people/photos/GenericAvatar.jpg" />
      </div>

      <div class="p-2">
        <h2 class="text-base font-bold leading-none cursor-pointer uppercase" :style="styles.title">
          {{ person.personFirstName }}
          {{ person.personLastName }}
        </h2>
        <p v-if="role.title" class=" text-sm leading-none cursor-pointer">{{ role.title }}</p>
      </div>

      <div class="p-2">
        <p v-if="role.department" class="text-sm leading-tight cursor-pointer">{{ role.department }}</p>
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
        background: [`background-color: ${this.theme.directory.cards.bg}`]
        .join(";"),
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
