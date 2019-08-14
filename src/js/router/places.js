export default [
  {
    name: 'places',
    path: '/places',
    component: () =>
      import(/* webpackChunkName: 'places' */ '../pages/places/Index.vue')
  },
  {
    name: 'places/place',
    path: '/places/:id',
    component: () =>
      import(/* webpackChunkName: 'places/place' */ '../pages/places/_Place.vue')
  }
];
