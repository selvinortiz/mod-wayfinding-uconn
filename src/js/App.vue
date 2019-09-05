<template>
  <div class="@page">
    <header class="@page__header flex items-center justify-between px-4 border-b border-gray-400">
      <app-logo></app-logo>
      <div>
        <mod-clock>
          <template v-slot:display="{ params }">
            <h1 class="text-right text-xl">
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

    <footer class="@page__footer flex flex-col justify-between border-t border-gray-400">
      <app-nav></app-nav>
      <app-footer></app-footer>
    </footer>
  </div>
</template>

<script>
import ModClock from "./components/shared/ModClock.vue";
import ModKeyboard from "./components/shared/ModKeyboard.vue";

import AppNav from "./components/partials/AppNav.vue";
import AppLogo from "./components/partials/AppLogo.vue";
import AppSearch from "./components/partials/AppSearch.vue";
import AppFooter from "./components/partials/AppFooter.vue";

export default {
  components: {
    AppNav,
    AppLogo,
    AppSearch,
    AppFooter,
    ModClock,
    ModKeyboard
  }
};
</script>
