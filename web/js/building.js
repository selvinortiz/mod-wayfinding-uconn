(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["building"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/ModMap.vue */ \"./src/js/components/ModMap.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Place\"\n  },\n  components: {\n    ModMap: _components_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n\n  data() {\n    return {\n      place: {\n        id: 0,\n        type: {\n          name: \"\"\n        },\n        loaded: false,\n        descendants: []\n      }\n    };\n  },\n\n  created() {\n    this.fetch();\n  },\n\n  computed: {\n    photo() {\n      if (this.place.loaded && this.place.buildingPhoto) {\n        return this.place.buildingPhoto[0];\n      }\n\n      return {\n        url: \"\",\n        width: 0,\n        height: 0\n      };\n    },\n\n    styles() {\n      return {\n        link: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    }\n\n  },\n  methods: {\n    fetch() {\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/place\", {\n        id: this.$route.params.id\n      }).then(response => {\n        this.place = { ...response.data.place,\n          loaded: true\n        };\n      }).catch(error => console.error(error));\n    },\n\n    handleSelectedPlace(place) {\n      if (place && place.id) {\n        this.$router.push({\n          name: \"room\",\n          params: {\n            id: place.id\n          }\n        });\n      }\n    }\n\n  },\n  watch: {\n    $route(to) {\n      if (to.name === \"building\" && to.params.id != this.place.id) {\n        this.place = {\n          id: 0,\n          type: {\n            name: \"\"\n          },\n          loaded: false,\n          descendants: []\n        };\n        this.fetch();\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&":
/*!*****************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css& ***!
  \*****************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("exports = module.exports = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ \"./node_modules/css-loader/dist/runtime/api.js\")(false);\n// Module\nexports.push([module.i, \"\\n.multiselect__option--highlight {\\n  color: #333;\\n  background-color: #ddd;\\n}\\n\", \"\"]);\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&":
/*!********************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98& ***!
  \********************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    { attrs: { loaded: _vm.place.loaded, classes: \"p-8\" } },\n    [\n      _c(\"page-header\", [_vm._v(\"Back\")]),\n      _vm._v(\" \"),\n      _c(\"section\", { staticClass: \"lg:flex flex-wrap\" }, [\n        _c(\n          \"div\",\n          { staticClass: \"lg:w-1/2 lg:order-1\" },\n          [_c(\"mod-map\", { attrs: { place: _vm.place } })],\n          1\n        ),\n        _vm._v(\" \"),\n        _c(\"div\", { staticClass: \"w-full lg:w-1/2 lg:flex\" }, [\n          _c(\"div\", { staticClass: \"lg:w-1/2\" }, [\n            _c(\n              \"div\",\n              { staticClass: \"p-8 pr-4\" },\n              [\n                _c(\"ui-photo\", { attrs: { photo: _vm.photo } }),\n                _vm._v(\" \"),\n                _c(\"h2\", { staticClass: \"font-thin text-4xl pt-4\" }, [\n                  _vm._v(\n                    _vm._s(_vm.place.buildingName) +\n                      \" \" +\n                      _vm._s(_vm.place.type.name)\n                  )\n                ]),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"text-xl\" }, [\n                  _c(\"p\", { staticClass: \"pt-4\" }, [\n                    _c(\"span\", { staticClass: \"block\" }, [\n                      _vm._v(_vm._s(_vm.place.placeAddress))\n                    ]),\n                    _vm._v(\" \"),\n                    _c(\"span\", { staticClass: \"block\" }, [\n                      _vm._v(\n                        _vm._s(_vm.place.placeCity) +\n                          \", \" +\n                          _vm._s(_vm.place.placeState) +\n                          \" \" +\n                          _vm._s(_vm.place.placeZipcode)\n                      )\n                    ])\n                  ])\n                ])\n              ],\n              1\n            )\n          ]),\n          _vm._v(\" \"),\n          _c(\"div\", { staticClass: \"w-full lg:w-1/2\" }, [\n            _c(\n              \"div\",\n              { staticClass: \"py-8 px-4\" },\n              [\n                _c(\"multi-select\", {\n                  attrs: {\n                    \"track-by\": \"id\",\n                    label: \"title\",\n                    placeholder: \"Chose Destination\",\n                    value: \"\",\n                    options: _vm.place.descendants,\n                    \"show-labels\": false,\n                    \"allow-empty\": true\n                  },\n                  on: { input: _vm.handleSelectedPlace },\n                  scopedSlots: _vm._u([\n                    {\n                      key: \"singleLabel\",\n                      fn: function(ref) {\n                        var option = ref.option\n                        return [\n                          _c(\n                            \"span\",\n                            {\n                              class: {\n                                \"text-gray-600\": option.type.handle !== \"floor\"\n                              }\n                            },\n                            [_vm._v(_vm._s(option.title))]\n                          )\n                        ]\n                      }\n                    }\n                  ])\n                }),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"pt-4\" }, [\n                  _vm._v(\n                    \"\\n            Don’t see what you’re looking for?\\n            \"\n                  ),\n                  _c(\n                    \"a\",\n                    {\n                      staticClass: \"text-blue-600 cursor-pointer\",\n                      on: {\n                        click: function() {\n                          return (_vm.$store.state.app.searchIsOpen = true)\n                        }\n                      }\n                    },\n                    [_vm._v(\"Switch to SEARCH\")]\n                  )\n                ])\n              ],\n              1\n            )\n          ])\n        ])\n      ])\n    ],\n    1\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&":
/*!*************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css& ***!
  \*************************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("// style-loader: Adds some css to the DOM by adding a <style> tag\n\n// load the styles\nvar content = __webpack_require__(/*! !../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Building.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&\");\nif(typeof content === 'string') content = [[module.i, content, '']];\nif(content.locals) module.exports = content.locals;\n// add the styles to the DOM\nvar add = __webpack_require__(/*! ../../../../node_modules/vue-style-loader/lib/addStylesClient.js */ \"./node_modules/vue-style-loader/lib/addStylesClient.js\").default\nvar update = add(\"5d7fb05c\", content, false, {});\n// Hot Module Replacement\nif(false) {}\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/places/_Building.vue":
/*!*******************************************!*\
  !*** ./src/js/pages/places/_Building.vue ***!
  \*******************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./_Building.vue?vue&type=template&id=3a1b6a98& */ \"./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&\");\n/* harmony import */ var _Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./_Building.vue?vue&type=script&lang=js& */ \"./src/js/pages/places/_Building.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./_Building.vue?vue&type=style&index=0&lang=css& */ \"./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__[\"default\"])(\n  _Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/places/_Building.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Building.vue?vue&type=script&lang=js&":
/*!********************************************************************!*\
  !*** ./src/js/pages/places/_Building.vue?vue&type=script&lang=js& ***!
  \********************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Building.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&":
/*!****************************************************************************!*\
  !*** ./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css& ***!
  \****************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-style-loader!../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Building.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default.a); \n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&":
/*!**************************************************************************!*\
  !*** ./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98& ***!
  \**************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Building.vue?vue&type=template&id=3a1b6a98& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?");

/***/ })

}]);