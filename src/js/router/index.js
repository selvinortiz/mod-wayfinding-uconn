import Vue from 'vue';
import VueRouter from 'vue-router';

import app from './app';
import places from './places';
import people from './people';

Vue.use(VueRouter);

const base   = window.kiosk.id ? `/@${window.kiosk.id}` : ``;
const routes = app.concat(places, people);

const router = new VueRouter({
  base,
  routes,
  mode: 'history',
});

// Add route guard if necessary

export default router;
