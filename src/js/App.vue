<template>
  <div class="@page">
    <header
      class="@page__header flex items-center justify-between px-4 border-b border-gray-400"
      :style="headerStyles"
    >
      <app-logo></app-logo>
      <div>
        <mod-clock>
          <template v-slot:display="{ params }">
            <h1 class="font-sans font-normal text-right text-xl">
              <span class="uppercase" v-text="params.monthName"></span>
              <span v-text="params.day"></span>,
              <span v-text="params.year"></span>
              <br />
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
        <router-view></router-view>
      </transition>
    </main>

    <footer
      class="@page__footer flex flex-col justify-between border-t border-gray-400"
      :style="footerStyles"
    >
      <app-nav></app-nav>
      <app-end></app-end>
    </footer>
  </div>
</template>

<script>
import ModClock from "./components/shared/ModClock.vue";
import ModKeyboard from "./components/shared/ModKeyboard.vue";

import AppNav from "./components/partials/AppNav.vue";
import AppEnd from "./components/partials/AppEnd.vue";
import AppLogo from "./components/partials/AppLogo.vue";
import AppSearch from "./components/partials/AppSearch.vue";

export default {
  components: {
    AppEnd,
    AppNav,
    AppLogo,
    AppSearch,
    ModClock,
    ModKeyboard
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      if (this.$route.name !== "index") return;

      return `background-image: url(/img/welcome-1.jpg); width: 100%; height: 100%;`;
    },
    classes() {
      if (this.$route.name !== "index") {
        return `bg-white text-gray-900`;
      }

      return `bg-cover bg-center`;
    },
    headerClasses() {
      return ``;
    },
    headerStyles() {
      debugger;
      return this.$bg(this.theme.header.background);
    },
    footerClasses() {
      return ``;
    },
    footerStyles() {
      return `background-color: rgba(255, 255, 255, .75);`;
    }
  }
};
</script>
