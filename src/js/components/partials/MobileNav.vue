<template>
  <transition name="fade" mode="out-in">
    <div
      v-show="$store.state.app.mobileNavIsOpen"
      class="absolute top-0 left-0 bottom-0 right-0 h-screen w-screen"
      :style="`top: 10vh; background-color: ${theme.nav.bg}`"
    >
      <nav class="@nav--mobile flex flex-wrap" @click="$store.commit('setToggleMobileNav')">
        <div class="w-full @link">
          <p class="px-4 py-4 font-bold text-xl uppercase">(x) Close Menu</p>
        </div>
        <div class="w-full @link" v-for="(link, i) in theme.nav.links" :key="i">
          <router-link
            v-if="link.type === 'route'"
            class="flex items-center px-4 py-4 cursor-pointer"
            :to="route(link)"
            :class="classes.link"
            :style="applyStyles(link)"
          >
            <img class="@link__icon px-2" :src="`/static/icons/${link.icon}`" alt />
            <span class="text-lg" v-html="link.title"></span>
          </router-link>

          <a
            v-if="link.type === 'action'"
            class="flex items-center px-4 py-4 cursor-pointer"
            :class="classes.link"
            :style="applyStyles(link)"
            @click="action(link.id)"
          >
            <img class="@link__icon px-2" :src="`/static/icons/${link.icon}`" alt />
            <span class="text-lg" v-html="link.title"></span>
          </a>

          <a
            v-if="link.type === 'url'"
            class="flex items-center px-4 py-4 cursor-pointer"
            :class="classes.link"
            :style="applyStyles(link)"
            @click="service(link.url)"
          >
            <img class="@link__icon px-2" :src="`/static/icons/${link.icon}`" alt />
            <span class="text-lg" v-html="link.title"></span>
          </a>
        </div>
      </nav>
    </div>
  </transition>
</template>

<style>
.\@link {
  border-bottom: 1px dotted;
}
.\@link__icon {
  max-height: 32px;
}
</style>

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
        link: []
          .concat(this.theme.nav.link.styles)
          .join(";"),
        linkActive: []
          .concat(this.theme.nav.link.active.styles || [])
          .join(";")
      };
    },
    classes() {
      return {
        link: [].concat([]).join(" "),
        icon: [].concat([]).join(" ")
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
