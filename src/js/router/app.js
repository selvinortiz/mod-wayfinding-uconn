import Index from '../pages/Index.vue';

export default [
  {
    name: 'index',
    path: '/',
    component: Index
  },
  {
    name: 'settings',
    path: '/settings',
    component: () =>
      import(/* webpackChunkName: 'settings' */ '../pages/Settings.vue')
  }
];
