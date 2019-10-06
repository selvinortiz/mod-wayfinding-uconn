<template>
  <router-link
    class="flex-1 flex cursor-pointer bg-white border border-gray-200 hover:bg-gray-200"
    :to="{name: results.type, params: { id: results.id}}"
     @click.native="handleCardClick"
  >
    <!-- <img class="block p-2" src="/static/img/avatar.svg" style="max-height: 80px;" /> -->
      <div class="flex p-4 w-full" :style="styles.background">
        <div v-if="results.type === 'person'" class="flex w-1/4 mr-2">
          <img src="/static/icons/People_Icon.svg" alt="People Icon" />
        </div>
        <div v-else class="flex w-1/4 mr-2">
          <img src="/static/icons/Places_Icon.svg" alt="People Icon" />
        </div>
        <div class="flex w-3/4">
        <h2
          class="font-bold text-sm cursor-pointer uppercase "
          :style="styles.title"
        >
        {{ results.title }}
        </h2>
        </div>
      </div>
  </router-link>
</template>

<script>
export default {
  props: {
    results: {
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
        background: [`background-color: ${this.theme.search.cards.bg}`].join(";"),
        title: [`color: ${this.theme.search.cards.color}`].join(";")
      };
    },
  },
  methods:{
     handleCardClick() {
      this.$store.commit("setSearchIsOpen", false);
    },
  }
};
</script>
