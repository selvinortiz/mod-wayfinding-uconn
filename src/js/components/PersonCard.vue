<template>
  <router-link
    class="flex-1 flex p-4 cursor-pointer bg-white border border-gray-200 hover:bg-gray-200"
    :to="{ name: 'person', params: {id: person.id}}"
    :style="styles.background"
  >
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->

    <div>
      <h2 class="font-semibold text-lg cursor-pointer uppercase" :style="styles.title">
        {{ person.personFirstName }}
        {{ person.personLastName }}
      </h2>
      <p class="text-md cursor-pointer">{{ role.title }}</p>
      <p class="text-sm cursor-pointer opacity-75 ">{{ role.department}}</p>
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
        department: ""
      };

      if (this.person.personRoles) {
        return {
          title: this.person.personRoles[0].roleTitle,
          department: this.person.personRoles[0].roleDepartment[0].title
        };
      }

      return role;
    }
  }
};
</script>
