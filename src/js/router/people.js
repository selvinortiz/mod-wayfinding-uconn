export default [
  {
    name: 'people',
    path: '/people',
    component: () =>
      import(/* webpackChunkName: 'people' */ '../pages/people/Index.vue')
  }
];
