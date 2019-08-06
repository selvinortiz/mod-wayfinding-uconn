import Vue from 'vue';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import store from './store';
import router from './router';

// Add global filters here
// Vue.filter('name', filter);

new Vue({
  el: '#app',
  store,
  router,
  components: {},
  created() {
    this.$store.commit('setInitialized', true);
  }
});
