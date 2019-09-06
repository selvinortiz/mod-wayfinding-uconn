import Vue from 'vue';

const Events = new Vue();

export default {
  install: (vue, options) => {
    vue.prototype.$on = Events.$on;
    vue.prototype.$once = Events.$once;
    vue.prototype.$emit = Events.$emit;
  }
};
