<template>
  <div class="flex flex-1 justify-center">
    <nav class="flex flex-1 max-w-6xl items-center justify-center" :style="navStyles">
      <div v-for="(link, i) in theme.nav.links" :key="i" class="flex-grow">
        <a v-if="link.url" :href="link.url" class="flex" :class="linkClasses" :style="linkStyles">
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>

        <router-link
          v-if="link.route"
          :to="{name: link.route}"
          class="flex"
          :class="linkClasses"
          :style="linkStyles"
        >
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </router-link>

        <a
          v-if="link.id == 'search'"
          @click="() => $store.state.app.searchIsOpen = true"
          class="flex"
          :class="linkClasses"
          :style="linkStyles"
        >
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>
      </div>
    </nav>
  </div>
</template>

<style scoped>
a {
  cursor: pointer;
}
.icon {
  max-height: 28px;
  margin-right: 10px;
}
</style>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    navStyles() {
      return [
        `color: ${this.theme.nav.foreground}`,
        `background-color: ${this.theme.nav.background}`
      ].join(";");
    },
    linkStyles() {
      return [
        `color: ${this.theme.nav.link.foreground}`,
        `background-color: ${this.theme.nav.link.background}`
      ].join(";");
    },
    linkClasses() {
      return this.theme.nav.link.classes || "";
    }
  }
};
</script>
