<template>
  <nav class="flex text-center uppercase justify-center">
    <div v-for="(link, i) in theme.footer.nav.links" :key="i">
      <a v-if="link.url" :href="link.url" class="link shadow rounded" :style="styles">
        <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
        <span>{{ link.title }}</span>
      </a>
      <router-link
        v-if="link.route"
        :to="{name: link.route}"
        class="link shadow rounded"
        :style="styles"
      >
        <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
        <span>{{ link.title }}</span>
      </router-link>
    </div>
  </nav>
</template>

<style scoped>
.link {
  display: inline-block;
  margin: 0.5rem;
  padding: 0.5rem 1rem;
  font-size: 1rem;
}

.icon {
  display: inline;
  max-height: 1rem;
}
@media screen and (min-width: 720px) {
  .link {
    margin: 1rem;
    padding: 1rem 2rem;
    font-size: 1.25rem;
  }
  .icon {
    max-height: 1.25rem;
  }
}
</style>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return [
        `color: ${this.theme.footer.nav.item.text}`,
        `background-color: ${this.theme.footer.nav.item.bg}`
      ].join(";");
    }
  }
};
</script>
