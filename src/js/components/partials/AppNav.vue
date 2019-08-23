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
    </div>
  </nav>
</template>

<script>
export default {
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
