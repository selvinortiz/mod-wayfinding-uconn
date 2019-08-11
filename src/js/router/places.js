export default [
  {
    name: 'places',
    path: '/places',
    component: () =>
      import(/* webpackChunkName: 'places' */ '../pages/places/Index.vue')
  }
];
