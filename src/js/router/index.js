import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import PageOne from '../pages/PageOne.vue'
import PageTwo from '../pages/PageTwo.vue'

const routes = [
  {
    name: 'pageOne',
    path: '/spa',
    component: PageOne,
    exact: true,
  },
  {
    name: 'pageTwo',
    path: '/spa/page-two',
    component: PageTwo,
    exact: true,
  },
];

export default new VueRouter({
  routes,
  mode: 'history'
});
