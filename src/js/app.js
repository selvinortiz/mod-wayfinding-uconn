import Vue from "vue"
import Meta from "vue-meta"

import "core-js/stable"
import "regenerator-runtime/runtime"

import Events from "./plugins/Events"
import ModClock from "./components/shared/ModClock.vue"
import ModKeyboard from "./components/shared/ModKeyboard.vue"
import ModMap from "./components/shared/ModMap.vue"

import AppNav from "./components/partials/AppNav.vue"
import AppLogo from "./components/partials/AppLogo.vue"

import store from "./store"
import router from "./router"

Vue.use(Meta)
Vue.use(Events)

new Vue({
  el: "#app",
  store,
  router,
  components: {
    AppNav,
    AppLogo,
    ModClock,
    ModKeyboard,
    ModMap
  },
  metaInfo: {
    title: "App",
    titleTemplate: "%s | ModCore™"
  },
  data: {
    appClasses: ""
  },
  created() {
    this.$store.commit("setInitialized", true)
  },
  computed: {
    theme() {
      return this.$store.state.app.theme
    },
    styles() {
      if (this.$route.name !== "index") return

      return `background-image: url(/img/welcome-1.jpg); width: 100%; height: 100%;`
    },
    classes() {
      if (this.$route.name !== "index") {
        return `bg-white text-gray-900`
      }

      return `bg-cover bg-center`
    },
    headerClasses() {
      return ``
    },
    headerStyles() {
      return `background-color: rgba(255, 255, 255, .90);`
    },
    footerClasses() {
      return ``
    },
    footerStyles() {
      return `background-color: rgba(255, 255, 255, .75);`
    }
  }
})
