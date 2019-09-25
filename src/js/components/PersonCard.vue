<template>
  <router-link 
  class="flex-1 flex p-4 cursor-pointer bg-white border border-gray-200 hover:bg-gray-200" 
  :to="{ name: 'person', params: {id: person.id}}" 
  :style="styles.background">
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->

    <div :style="styles.textColor">
      <h2 class="cursor-pointer font-semibold uppercase">
        {{ person.personFirstName }}
        {{ person.personLastName }}
      </h2>
      <p class="cursor-pointer">
        Department
        <!--{{ person.personFirstName }}-->
      </p>
      <p class="cursor-pointer">
        Suite #
        <!--{{ person.personFirstName }}-->
      </p>
      <p class="cursor-pointer">
        Building Name 
      </p>
    </div>
  </router-link>
</template>

<script>
export default {
  props: {
    person: {
      type: Object,
      default: () => {id: null}
    }
  },
  computed:{
     theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {background: [`background-color: ${this.theme.cards.bg}`].join(";"),
      textColor: [`color: ${this.theme.colors.primary}`].join(";")
      };
    }
  }
}
</script>
