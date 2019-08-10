export default [
  {
    name: 'places',
    path: '/places',
    component: () =>
      import(/* webpackChunckName: 'places' */ '../pages/places/Index.vue')
  }
];
