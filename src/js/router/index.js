import Vue from 'vue';
import VueRouter from 'vue-router';

import app from './app';
import places from './places';
import people from './people';

Vue.use(VueRouter);

const routes = app.concat(places, people);

const base = window.kiosk.id ? `/@${window.kiosk.id}` : ``;

export default new VueRouter({
  base,
  routes,
  mode: 'history',
});
