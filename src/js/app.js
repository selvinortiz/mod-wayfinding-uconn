import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import MultiSelect from 'vue-multiselect';
import 'vue-multiselect/dist/vue-multiselect.min.css';
import Theme from './plugins/Theme';
import Events from './plugins/Events';

import App from './App.vue';
import AppSearch from './components/partials/AppSearch.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Theme);
Vue.use(Events);

Vue.component('multiselect', MultiSelect);

new Vue({
  el: '#app',
  store,
  router,
  components: {
    App,
    AppSearch
  },
  metaInfo: {
    title: `${window.pageTitle || 'App'}`,
    titleTemplate: `%s | ${window.siteName || 'ModCore'}`
  },
  created() {
    const theme = window.theme;
    const kiosk = window.kiosk;
    const campus = window.campus;
    const settings = window.settings;

    this.$store.commit('setInitialized', { theme, campus, kiosk, settings });
  }
});
