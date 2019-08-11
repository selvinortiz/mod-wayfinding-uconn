import Index from '../pages/Index.vue';

export default [
  {
    name: 'index',
    path: '/',
    component: Index
  },
  {
    name: 'search',
    path: '/search',
    component: () =>
      import(/* webpackChunkName: 'app/search' */ '../pages/Search.vue')
  },
  {
    name: 'settings',
    path: '/settings',
    component: () =>
      import(/* webpackChunkName: 'app/settings' */ '../pages/Settings.vue')
  }
];
