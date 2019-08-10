export default [
  {
    name: 'people',
    path: '/people',
    component: () =>
      import(/* webpackChunckName: 'people' */ '../pages/people/Index.vue')
  }
];
