import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import Fullscreen from 'vue-fullscreen';
import ContentIframe from 'vue-friendly-iframe';
import MultiSelect from 'vue-multiselect';
import 'vue-multiselect/dist/vue-multiselect.min.css';

import Theme from './plugins/Theme';
import Events from './plugins/Events';

import App from './App.vue';
import AppSearch from './components/partials/AppSearch.vue';

import ContentLoader from './components/shared/ContentLoader.vue';
import PageHeader from './components/shared/PageHeader.vue';
import BuildingName from './components/shared/BuildingName.vue';
import UIButton from './components/shared/UIButton.vue';
import UIPhoto from './components/shared/UIPhoto.vue';
import Map from './components/Map.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Theme);
Vue.use(Events);
Vue.use(Fullscreen);

Vue.component('content-iframe', ContentIframe);
Vue.component('content-loader', ContentLoader);
Vue.component('page-header', PageHeader);
Vue.component('building-name', BuildingName);
Vue.component('multi-select', MultiSelect);
Vue.component('ui-button', UIButton);
Vue.component('ui-photo', UIPhoto);
Vue.component('mod-map', Map);

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
