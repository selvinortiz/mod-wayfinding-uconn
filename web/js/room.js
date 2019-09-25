(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["room"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Place\"\n  },\n\n  data() {\n    return {\n      place: {\n        id: 0,\n        type: {\n          name: \"\"\n        },\n        loaded: false,\n        ancestors: []\n      }\n    };\n  },\n\n  created() {\n    this.fetch();\n  },\n\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    styles() {\n      return {\n        defaultColor: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    },\n\n    floor() {\n      return this.place.ancestors[0] || {};\n    },\n\n    building() {\n      return this.place.ancestors[1] || {};\n    },\n\n    campus() {\n      return this.place.ancestors[2] || {};\n    }\n\n  },\n  methods: {\n    fetch() {\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/place\", {\n        id: this.$route.params.id\n      }).then(response => {\n        this.place = { ...response.data.place,\n          loaded: true\n        };\n      }).catch(error => console.error(error));\n    }\n\n  },\n  watch: {\n    $route(to) {\n      if (to.name === \"room\" && this.$route.params.id != this.place.id) {\n        this.place = {\n          id: 0,\n          loaded: [],\n          ancestors: []\n        };\n        this.fetch();\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&":
/*!****************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982& ***!
  \****************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    { attrs: { loaded: _vm.place.loaded, classes: \"p-8\" } },\n    [\n      _c(\"page-header\", [_vm._v(\"Wayfinding\")]),\n      _vm._v(\" \"),\n      _c(\"section\", { staticClass: \"xl:flex flex-wrap\" }, [\n        _c(\n          \"div\",\n          { staticClass: \"xl:w-1/2 xl:order-1\" },\n          [_c(\"mod-map\", { attrs: { place: _vm.place } })],\n          1\n        ),\n        _vm._v(\" \"),\n        _c(\"div\", { staticClass: \"w-full flex flex-wrap xl:w-1/2\" }, [\n          _c(\"div\", { staticClass: \"w-full\" }, [\n            _c(\"div\", { staticClass: \"pt-8 px-4\" }, [\n              _c(\n                \"h2\",\n                {\n                  staticClass: \"font-thin text-4xl leading-none\",\n                  style: _vm.styles.defaultColor\n                },\n                [_vm._v(_vm._s(_vm.place.title))]\n              ),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"text-xl\" }, [\n                _c(\"p\", { staticClass: \"pt-4 text-2xl\" }, [\n                  _c(\n                    \"span\",\n                    { staticClass: \"block\", style: _vm.styles.defaultColor },\n                    [_vm._v(_vm._s(_vm.building.buildingName) + \" Building\")]\n                  )\n                ]),\n                _vm._v(\" \"),\n                _c(\"p\", { staticClass: \"pt-4\" }, [\n                  _c(\n                    \"span\",\n                    { staticClass: \"block\", style: _vm.styles.defaultColor },\n                    [_vm._v(\"Floor #: \" + _vm._s(_vm.floor.floorNumber))]\n                  ),\n                  _vm._v(\" \"),\n                  _c(\n                    \"span\",\n                    { staticClass: \"block\", style: _vm.styles.defaultColor },\n                    [_vm._v(\"Suite #: \" + _vm._s(_vm.place.roomNumber))]\n                  )\n                ]),\n                _vm._v(\" \"),\n                _c(\"p\", { staticClass: \"pt-4\" }, [\n                  _c(\n                    \"span\",\n                    { staticClass: \"block\", style: _vm.styles.defaultColor },\n                    [\n                      _vm._v(\n                        \"\\n                \" +\n                          _vm._s(_vm.building.placeCity) +\n                          \", \" +\n                          _vm._s(_vm.building.placeState) +\n                          \" \" +\n                          _vm._s(_vm.building.placeZipcode) +\n                          \"\\n              \"\n                      )\n                    ]\n                  )\n                ])\n              ])\n            ])\n          ])\n        ])\n      ])\n    ],\n    1\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue":
/*!***************************************!*\
  !*** ./src/js/pages/places/_Room.vue ***!
  \***************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./_Room.vue?vue&type=template&id=17fe1982& */ \"./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&\");\n/* harmony import */ var _Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./_Room.vue?vue&type=script&lang=js& */ \"./src/js/pages/places/_Room.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/places/_Room.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue?vue&type=script&lang=js&":
/*!****************************************************************!*\
  !*** ./src/js/pages/places/_Room.vue?vue&type=script&lang=js& ***!
  \****************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&":
/*!**********************************************************************!*\
  !*** ./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982& ***!
  \**********************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=template&id=17fe1982& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ })

}]);