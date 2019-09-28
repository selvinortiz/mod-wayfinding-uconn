<template>
  <router-link
    class="flex-1 flex p-4 cursor-pointer bg-white border border-gray-200 hover:bg-gray-200"
    :to="{ name: 'person', params: {id: person.id}}"
  >
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->

    <div class="w-full shadow-md" :style="styles.background">
      <img :src="role.url" />
      <div class="p-4">
      <h2 class="font-bold text-lg cursor-pointer uppercase" :style="styles.title">
        {{ person.personFirstName }}
        {{ person.personLastName }}
      </h2>
      <p class="text-md cursor-pointer">{{ role.title }}</p>
      <p class="text-md cursor-pointer">{{ role.department}}</p>
      <!-- <p class="text-md cursor-pointer">{{ role.building }}</p>
      <p class="text-md cursor-pointer">{{ role.suite }}</p> -->
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
        id: null;
      }
    }
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        background: [`background-color: ${this.theme.cards.bg}`].join(";"),
        title: [`color: ${this.theme.colors.primary}`].join(";")
      };
    },
    role() {
      const role = {
        title: "",
        department: "",
        url: "",
        building: "",
        suite: ""
      };

      if (this.person.personRoles) {
        return {
          title: this.person.personRoles[0].roleTitle,
          department: this.person.personRoles[0].roleDepartment[0].title,
          url: "/uploads/people/photos/default-avatar.svg", 
          building: "Building Name",
          suite: "Suite 1"
          
        };
      }

      return role;
    }
  }
};
</script>
