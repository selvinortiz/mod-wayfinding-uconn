export default [
  {
    name: "campus",
    path: "/places/campus/:id",
    component: () =>
      import(
        /* webpackChunkName: 'campus' */ "../pages/places/_MobileCampus.vue")
  },
  {
    name: "building",
    path: "/places/building/:id",
    component: () =>
      import(
        /* webpackChunkName: 'building' */ "../pages/places/_MobileBuilding.vue"
      )
  },
  {
    name: "floor",
    path: "/places/floor/:id",
    component: () =>
      import(/* webpackChunkName: 'floor' */ "../pages/places/_Floor.vue")
  },
  {
    name: "room",
    path: "/places/room/:id",
    component: () =>
      import(/* webpackChunkName: 'room' */ "../pages/places/_MobileRoom.vue")
  }
];
