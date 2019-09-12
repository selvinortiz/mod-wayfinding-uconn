export default [
  {
    name: 'place',
    path: '/places/:id',
    component: () =>
      import(/* webpackChunkName: 'place' */ '../pages/places/_Place.vue')
  },
  {
    name: 'campus',
    path: '/places/campus/:id',
    component: () =>
      import(/* webpackChunkName: 'campus' */ '../pages/places/_Campus.vue')
  },
  {
    name: 'building',
    path: '/places/building/:id',
    component: () =>
      import(/* webpackChunkName: 'building' */ '../pages/places/_Building.vue')
  },
  {
    name: 'floor',
    path: '/places/floor/:id',
    component: () =>
      import(/* webpackChunkName: 'floor' */ '../pages/places/_Floor.vue')
  },
  {
    name: 'room',
    path: '/places/room/:id',
    component: () =>
      import(/* webpackChunkName: 'room' */ '../pages/places/_Room.vue')
  }
];
