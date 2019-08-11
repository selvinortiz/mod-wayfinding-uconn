import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import store from './store';
import router from './router';

// Add global filters here
// Vue.filter('name', filter);

Vue.use(Meta);

new Vue({
  el: '#app',
  store,
  router,
  components: {},
  metaInfo: {
    title: 'App',
    titleTemplate: '%s | ModCore™'
  },
  created() {
    this.$store.commit('setInitialized', true);
  }
});
