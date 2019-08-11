import Vue from 'vue';

const Events = new Vue();

export default {
  install: (V, options) => {
    V.prototype.$on   = Events.$on;
    V.prototype.$once = Events.$once;
    V.prototype.$emit = Events.$emit;
  }
};
