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

import ContentLoader from './components/shared/ContentLoader.vue';
import PageHeader from './components/shared/PageHeader.vue';
import UIButton from './components/shared/UIButton.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Theme);
Vue.use(Events);

Vue.component('content-loader', ContentLoader);
Vue.component('page-header', PageHeader);
Vue.component('multi-select', MultiSelect);
Vue.component('ui-button', UIButton);

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
    titleTemplate: `%s | ${window.theme.app.title || 'ModCore'}`
  },
  created() {
    const theme = window.theme;
    const kiosk = window.kiosk;
    const campus = window.campus;
    const settings = window.settings;

    this.$store.commit('setInitialized', { theme, campus, kiosk, settings });
  }
});
