<template>
  <router-link
    class="flex-1 flex cursor-pointer bg-transparent border-gray-200"
    :to="{ name: results.type, params: { id: results.id } }"
    @click.native="handleCardClick"
  >
    <div class="block w-full mx-1 my-1" :style="styles.background">
      <!-- Icon Parent Container -->
      <div class="block p-2 w-full">
        <!-- Icon Conditional Child Container One -->
        <div v-if="results.type === 'person'" class=" h-6">
          <img
            style="height: 100%;"
            src="/static/icons/People_Icon.svg"
            alt="People Icon"
          />
        </div>
        <!-- Icon Conditional Child Container Two -->
        <div v-else class="h-6">
          <img
            style="height: 100%;"
            src="/static/icons/Places_Icon.svg"
            alt="People Icon"
          />
        </div>
      </div>
      <!-- Card Text Container -->
      <div class="block px-4 pb-2 w-full ">
        <h2
          class="font-bold text-md cursor-pointer uppercase"
          :style="styles.title"
        >
          {{ results.title }}
        </h2>
        <p
          v-for="(line, index) in results.info"
          :key="index"
          class="text-sm opacity-75"
        >
          {{ line }}
        </p>
      </div>
    </div>
  </router-link>
</template>

<script>
export default {
  props: {
    results: {
      type: Object,
      default: () => {}
    }
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        background: [`background-color: ${this.theme.search.cards.bg}`].join(
          ";"
        ),
        title: [`color: ${this.theme.search.cards.color}`].join(";")
      };
    }
  },
  methods: {
    handleCardClick() {
      this.$store.commit("setSearchIsOpen", false);
    }
  }
};
</script>
