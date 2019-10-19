export default [
  {
    name: 'people',
    path: '/people',
    exact: true,
    component: () =>
      import(/* webpackChunkName: 'people' */ '../pages/people/MobileIndex.vue')
  },
  {
    name: 'person',
    path: '/people/:id',
    component: () =>
      import(/* webpackChunkName: 'person' */ '../pages/people/_MobilePerson.vue')
  }
];
