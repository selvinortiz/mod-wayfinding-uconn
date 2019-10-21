<template>
  <div @click="reset" :class="{mobile: $store.state.app.isMobile}" :style="styles.container">
    <app-slides v-if="isWelcomeScreen"></app-slides>
    <div class="@page absolute z-10 w-full h-full" :class="{ 'bg-gray-100': !isWelcomeScreen }" style="grid-template-rows: 10vh auto;">
      <header
        class="@page__header flex items-center justify-between px-4 md:px-8 xl:px-16 opacity-95"
        :style="styles.header"
      >
        <app-logo></app-logo>
        <div class="@menu__burger">
          <button
            @click="$store.commit('setToggleMobileNav')"
            class="outline-none focus:outline-none"
          >
            <svg
              width="28"
              viewBox="0 0 448 392"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
            >
              <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g id="burger" fill="#fff" fill-rule="nonzero">
                  <path
                    d="M86,72 L432,72 C440.837,72 448,64.837 448,56 L448,16 C448,7.163 440.837,0 432,0 L86,0 C77.163,0 70,7.163 70,16 L70,56 C70,64.837 77.163,72 86,72 Z M16,232 L432,232 C440.837,232 448,224.837 448,216 L448,176 C448,167.163 440.837,160 432,160 L16,160 C7.163,160 0,167.163 0,176 L0,216 C0,224.837 7.163,232 16,232 Z M86,392 L432,392 C440.837,392 448,384.837 448,376 L448,336 C448,327.163 440.837,320 432,320 L86,320 C77.163,320 70,327.163 70,336 L70,376 C70,384.837 77.163,392 86,392 Z"
                    id="Shape"
                  />
                </g>
              </g>
            </svg>
          </button>
        </div>
      </header>

      <main class="@page__content">
        <transition name="fade" mode="out-in">
          <keep-alive exclude="service,people,campus,building,room">
            <router-view></router-view>
          </keep-alive>
        </transition>
      </main>

      <div
        v-if="$store.state.app.searchIsOpen"
        class="fixed top-0 w-full h-full @search__container"
      >
        <div class="fixed top-0 w-full h-full @search__backdrop" :style="styles.search.backdrop"></div>
        <app-search></app-search>
      </div>

      <mobile-nav></mobile-nav>
    </div>
  </div>
</template>

<script>
import moment from "moment";

// import ModClock from "./components/ModClock.vue";
// import ModKeyboard from "./components/ModKeyboard.vue";

// import AppNav from "./components/partials/AppNav.vue";
import AppLogo from "./components/partials/AppLogo.vue";
import AppSearch from "./components/partials/MobileSearch.vue";
// import AppFooter from "./components/partials/AppFooter.vue";
import AppSlides from "./components/partials/MobileSlides.vue";

import MobileNav from "./components/partials/MobileNav.vue";

export default {
  props: {
    timeout: {
      type: Number,
      default: 15
    },
    reloadUrl: {
      type: String,
      default: "/"
    }
  },
  data() {
    return {
      expires: null,
      interval: null
    };
  },
  components: {
    // AppNav,
    AppLogo,
    AppSearch,
    // AppFooter,
    AppSlides,
    MobileNav
    // ModClock,
    // ModKeyboard
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        header: [this.$bg(this.theme.header.bg)].join(";"),
        clock: [`color: ${this.theme.header.clock.fg}`].join(";"),
        footer: [this.$bg(this.theme.footer.bg)].join(";"),
        search: {
          backdrop: [this.$bg(this.theme.search.bg)].join(";")
        },
        container: `font-family: ${this.theme.font.family};`
      };
    },
   dateFormat() {
      return this.theme.header.clock.dateFormatMDY;
    },
    isWelcomeScreen() {
      return this.$route.name === "index";
    }
  },
  created() {
    this.expires = moment().add(this.timeout, "minutes");
    this.interval = setInterval(this.tick, 1000);
  },
  beforeDestroy() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  },
  methods: {
    tick() {
      if (moment().isAfter(this.expires)) {
        window.location.replace(this.reloadUrl);
      }
    },
    reset() {
      this.expires = moment().add(this.timeout, "minutes");
    }
  }
};
</script>
