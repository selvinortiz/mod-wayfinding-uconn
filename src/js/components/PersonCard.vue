<template>
  <router-link
    class="flex-1 flex p-4 cursor-pointer bg-white border border-gray-200 hover:bg-gray-200"
    :to="{ name: 'person', params: { id: person.id } }"
  >
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->

    <div class="w-full shadow-md" :style="styles.background">
      <div v-if="directoryPhoto">
        <img v-if="role.imageurl" :src="role.imageurl" />
        <img v-else src="/uploads/people/photos/GenericAvatar.jpg" />
      </div>
      <div class="p-4">
        <h2
          class="font-bold text-lg cursor-pointer uppercase"
          :style="styles.title"
        >
          {{ person.personFirstName }}
          {{ person.personLastName }}
        </h2>
        <p v-if="role.title" class="text-md cursor-pointer">{{ role.title }}</p>
        <p v-if="role.department" class="text-md cursor-pointer">
          {{ role.department }}
        </p>
        <p v-if="role.building" class="text-md cursor-pointer">
          {{ role.building }}
        </p>
        <p v-if="role.building" class="text-md cursor-pointer">
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
  data: function() {
    return {
      directoryPhoto: true
    };
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
        imageurl: "",
        building: "",
        suite: ""
      };

      if (this.person.personRoles.length > 0) {
        return {
          title: this.person.personRoles[0].roleTitle,
          department: this.person.personRoles[0].roleDepartment[0].title,
          imageurl: "",
          building: "",
          suite: ""
        };
      }
      return role;
    }
  }
};
</script>
