import Vue from 'vue';
import Meta from 'vue-meta';

import 'core-js/stable';
import 'regenerator-runtime/runtime';

import Theme from './plugins/Theme';
import Events from './plugins/Events';

import App from './App.vue';
import ModPageHeader from './components/shared/ModPageHeader.vue';

import store from './store';
import router from './router';

Vue.use(Meta);
Vue.use(Theme);
Vue.use(Events);

Vue.component('mod-page-header', ModPageHeader);

new Vue({
  el: '#app',
  store,
  router,
  components: { App },
  metaInfo: {
    title: 'App',
    titleTemplate: '%s | ModCore™'
  },
  created() {
    const fromWindow = {
      isMobile: window.isMobile,
      kioskId: window.kioskId,
      theme: window.theme
    };

    this.$store.commit('setInitialized', fromWindow);
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      if (this.$route.name !== 'index') return;

      return `background-image: url(/img/welcome-1.jpg); width: 100%; height: 100%;`;
    },
    classes() {
      if (this.$route.name !== 'index') {
        return `bg-white text-gray-900`;
      }

      return `bg-cover bg-center`;
    },
    headerClasses() {
      return ``;
    },
    headerStyles() {
      return this.$bg(this.theme.header.background);
    },
    footerClasses() {
      return ``;
    },
    footerStyles() {
      return `background-color: rgba(255, 255, 255, .75);`;
    }
  }
});
