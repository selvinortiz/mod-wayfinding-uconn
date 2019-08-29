<template>
  <nav class="flex flex-1 items-center text-center uppercase justify-center">
    <div v-for="(link, i) in theme.footer.nav.links" :key="i">
      <a v-if="link.url" :href="link.url" class="mx-2 px-4" :style="styles">
        <!--img class="icon" :src="`/svg/icons/${link.icon}`" alt /-->
        <span>{{ link.title }}</span>
      </a>

      <router-link
        v-if="link.route"
        :to="{name: link.route}"
        class="mx-2 p-4"
        :style="styles"
      >
        <!--img class="icon" :src="`/svg/icons/${link.icon}`" alt /-->
        <span>{{ link.title }}</span>
      </router-link>

      <a v-if="link.component == 'search'" href="JavaScript:void(0);" @click="() => $store.state.app.searchIsOpen = true" class="mx-2 px-4" :style="styles">
        <!--img class="icon" :src="`/svg/icons/${link.icon}`" alt /-->
        <span>{{ link.title }}</span>
      </a>
    </div>

    <div v-if="$store.state.app.searchIsOpen" class="fixed top-0 w-full h-full">
      <div class="fixed top-0 w-full h-full bg-gray-200 opacity-50"></div>
      <search ref='search'></search>
    </div>
  </nav>
</template>

<script>
import search from "../../pages/Search.vue";

export default {
  components: {
    search
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return [
        `color: ${this.theme.footer.nav.item.text}`,
        // `background-color: ${this.theme.footer.nav.item.bg}`
      ].join(";");
    }
  }
};
</script>
