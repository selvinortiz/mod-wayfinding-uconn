export default [
  {
    name: 'places',
    path: '/places',
    component: () =>
      import(/* webpackChunkName: 'places' */ '../pages/places/Index.vue')
  },
  {
    name: 'place',
    path: '/places/:id',
    component: () =>
      import(/* webpackChunkName: 'place' */ '../pages/places/_Place.vue')
  }
];
