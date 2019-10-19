import Vue from 'vue';
import VueRouter from 'vue-router';

import app from './app';
import places from './places';
import people from './mobile-people';

Vue.use(VueRouter);

let base = ``;

if (window.kiosk.id) {
  base = `/@${window.kiosk.id}`;
} else if (window.mobile) {
  base = `/@mobile`;
}

const routes = app.concat(places, people);

const router = new VueRouter({
  base,
  routes,
  mode: 'history',
});

// Add route guard if necessary

export default router;
