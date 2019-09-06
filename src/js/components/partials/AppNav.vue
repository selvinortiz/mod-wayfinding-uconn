<template>
  <div class="flex justify-center" :class="classes.container" :style="styles.container">
    <nav class="flex flex-1 max-w-6xl items-center justify-center">
      <div class="flex-grow @link" v-for="(link, i) in theme.nav.links" :key="i">
        <a
          class="flex"
          v-if="link.type === 'url'"
          :href="link.url"
          :class="classes.link"
          :style="applyStyles(link)"
        >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>

        <router-link
          v-if="link.type === 'route'"
          class="flex"
          :to="{name: link.route}"
          :class="classes.link"
          :style="applyStyles(link)"
        >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </router-link>

        <a
          v-if="link.type === 'action'"
          class="flex"
          :class="classes.link"
          :style="applyStyles(link)"
          @click="action(link.id)"
        >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        container: [this.$bg(this.theme.nav.bg), `color: ${this.theme.nav.fg}`]
          .concat(this.theme.nav.styles)
          .join(";"),
        link: [
            this.$bg(this.theme.nav.link.bg),
            `color: ${this.theme.nav.link.fg}`
          ]
          .concat(this.theme.nav.link.styles)
          .join(";"),
        linkActive: [
          this.$bg(this.theme.nav.link.active.bg),
            `color: ${this.theme.nav.link.active.fg}`
          ]
          .concat(this.theme.nav.link.active.styles||[])
          .join(";")
      };
    },
    classes() {
      return {
        container: [].concat(this.theme.nav.classes).join(" "),
        link: [
          'p-6',
          'justify-around'
        ].concat(this.theme.nav.link.classes).join(" ")
      };
    }
  },
  methods: {
    action(id) {
      switch (id) {
        case "search":
          return this.search();
      }
    },
    search() {
      this.$store.commit("setSearchIsOpen", true);
    },
    applyStyles(link) {
      const styles = this.styles.link;

      if (link.route && this.$route && this.$route.path.includes(link.route)) {
        return this.styles.linkActive;
      }

      return this.styles.link;
    }
  }
};
</script>
