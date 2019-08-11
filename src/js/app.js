import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import Events from './plugins/Events';
import ModClock from './components/shared/ModClock.vue';
import ModKeyboard from './components/shared/ModKeyboard.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Events);

new Vue({
  el: '#app',
  store,
  router,
  components: {
    ModClock,
    ModKeyboard
  },
  metaInfo: {
    title: 'App',
    titleTemplate: '%s | ModCore™'
  },
  created() {
    this.$store.commit('setInitialized', true);
  }
});
