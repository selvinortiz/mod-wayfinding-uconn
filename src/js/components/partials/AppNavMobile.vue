<template>
  <transition name="fade" mode="out-in">
    <div
      v-show="$store.state.app.mobileNavIsOpen"
      class="absolute top-0 left-0 h-screen w-screen"
      :style="`top: 10vh; background-color: ${theme.nav.bg}`"
    >
      <nav class="@nav--mobile flex flex-wrap" @click="$store.commit('setToggleMobileNav')">
        <div class="w-full @link" v-for="(link, i) in theme.nav.links" :key="i">
          <router-link
            v-if="link.type === 'route'"
            class="flex"
            :to="route(link)"
            :class="classes.link"
            :style="applyStyles(link)"
          >
            <p class="flex cursor-pointer">
              <img :class="classes.icon" :src="`/static/icons/${link.icon}`" alt />
              <span class="pt-2" v-html="link.title"></span>
            </p>
          </router-link>

          <a
            v-if="link.type === 'action'"
            class="flex"
            :class="classes.link"
            :style="applyStyles(link)"
            @click="action(link.id)"
          >
            <p class="flex cursor-pointer text-2xl">
              <img :class="classes.icon" :src="`/static/icons/${link.icon}`" alt />
              <span class="pt-2" v-html="link.title"></span>
            </p>
          </a>

          <a
            v-if="link.type === 'url'"
            class="flex"
            :class="classes.link"
            :style="applyStyles(link)"
            @click="service(link.url)"
          >
            <p class="flex cursor-pointer">
              <img :class="classes.icon" :src="`/static/icons/${link.icon}`" alt />
              <span class="pt-2" v-html="link.title"></span>
            </p>
          </a>
        </div>
      </nav>
    </div>
  </transition>
</template>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    kiosk() {
      return this.$store.state.app.kiosk;
    },
    campus() {
      return this.$store.state.app.campus;
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
          .concat(this.theme.nav.link.active.styles || [])
          .join(";")
      };
    },
    classes() {
      return {
        container: [].concat(this.theme.nav.classes).join(" "),
        link: [].concat(this.theme.nav.link.classes).join(" "),
        icon: [].concat(this.theme.nav.link.icon.classes).join(" ")
      };
    }
  },
  methods: {
    route(link) {
      if (link.route === "places") {
        if (this.kiosk.id) {
          return { name: "building", params: { id: this.kiosk.id } };
        }

        return { name: "campus", params: { id: this.campus.id } };
      }

      return {
        name: link.route
      };
    },
    action(id) {
      switch (id) {
        case "search":
          return this.search();
      }
    },
    service(url) {
      this.$router.push({ name: "service", query: { url } });
    },
    search() {
      this.$store.commit("setSearchIsOpen", true);
    },
    applyStyles(link) {
      if (link.id == "search" && this.$store.state.app.searchIsOpen) {
        return this.styles.linkActive;
      }

      if (
        link.url &&
        this.$route &&
        this.$route.query.url &&
        this.$route.query.url === link.url
      ) {
        return this.styles.linkActive;
      }

      if (link.route && this.$route && this.$route.path.includes(link.route)) {
        return this.styles.linkActive;
      }

      return this.styles.link;
    }
  }
};
</script>
