<template>
  <div @click="reset" :class="{mobile: $store.state.app.isMobile}" :style="styles.container">
    <app-slides v-if="isWelcomeScreen"></app-slides>
    <div class="@page absolute z-10 w-full h-full" :class="{ 'bg-gray-100': !isWelcomeScreen }">
      <header
        class="@page__header flex items-center justify-between px-4 md:px-8 xl:px-16 opacity-95"
        :style="styles.header"
      >
        <app-logo></app-logo>
        <div class="@clock">
          <mod-clock>
            <template v-slot:display="{ params }">
              <h1 v-if="dateFormat" class="text-right text-xl" :style="styles.clock">
                <span class="uppercase" v-text="params.monthName"></span>
                <span v-text="params.day"></span>,
                <span v-text="params.year"></span>
                <span>&nbsp;|&nbsp;</span>
                <span v-text="params.hour"></span>
                <span class="inline-block font-bold animated infinite fadeOut">:</span>
                <span v-text="params.minute"></span>
                <span v-text="params.suffix"></span>
              </h1>
              <h1 v-else class="text-right text-xl" :style="styles.clock">
                <span v-text="params.day"></span>,
                <span class="uppercase" v-text="params.monthName"></span>
                <span v-text="params.year"></span>
                <span>&nbsp;|&nbsp;</span>
                <span v-text="params.hour"></span>
                <span class="inline-block font-bold animated infinite fadeOut">:</span>
                <span v-text="params.minute"></span>
                <span v-text="params.suffix"></span>
              </h1>
            </template>
          </mod-clock>
        </div>
      </header>

      <main class="@page__content">
        <transition name="fade" mode="out-in">
          <keep-alive exclude="service,people,campus,building,room">
            <router-view></router-view>
          </keep-alive>
        </transition>
      </main>

      <footer class="@page__footer flex flex-col justify-between opacity-95" :style="styles.footer">
        <app-nav></app-nav>
        <app-footer></app-footer>
      </footer>

      <div
        v-if="$store.state.app.searchIsOpen"
        class="fixed top-0 w-full h-full @search__container"
      >
        <div class="fixed top-0 w-full h-full @search__backdrop" :style="styles.search.backdrop"></div>
        <app-search></app-search>
      </div>
    </div>
  </div>
</template>

<script>
import moment from "moment";

import ModClock from "./components/ModClock.vue";
import ModKeyboard from "./components/ModKeyboard.vue";

import AppNav from "./components/partials/AppNav.vue";
import AppLogo from "./components/partials/AppLogo.vue";
import AppSearch from "./components/partials/AppSearch.vue";
import AppFooter from "./components/partials/AppFooter.vue";
import AppSlides from "./components/partials/AppSlides.vue";

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
    AppNav,
    AppLogo,
    AppSearch,
    AppFooter,
    AppSlides,
    ModClock,
    ModKeyboard
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
