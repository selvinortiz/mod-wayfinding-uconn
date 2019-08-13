export default [
  {
    name: 'people',
    path: '/people',
    component: () =>
      import(/* webpackChunkName: 'people' */ '../pages/people/Index.vue')
  },
  {
    name: 'people/person',
    path: '/people/:id',
    component: () =>
      import(/* webpackChunkName: 'people/person' */ '../pages/people/_Person.vue')
  }
];
