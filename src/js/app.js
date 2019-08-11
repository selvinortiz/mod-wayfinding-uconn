import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import Events from './plugins/Events';
import ModClock from './components/shared/ModClock.vue';
import ModKeyboard from './components/shared/ModKeyboard.vue';

import AppNav from './components/partials/AppNav.vue';
import AppLogo from './components/partials/AppLogo.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Events);

new Vue({
  el: '#app',
  store,
  router,
  components: {
    AppNav,
    AppLogo,
    ModClock,
    ModKeyboard
  },
  metaInfo: {
    title: 'App',
    titleTemplate: '%s | ModCore™'
  },
  created() {
    this.$store.commit('setInitialized', true);
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    }
  }
});
