import Vue from 'vue';
import VueRouter from 'vue-router';

import app from './app';
import places from './places';
import people from './people';

Vue.use(VueRouter);

const routes = app.concat(places, people);

export default new VueRouter({ routes, mode: 'history' });
