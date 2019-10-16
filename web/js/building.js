(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["building"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  name: 'building',\n  metaInfo: {\n    title: \"Place\"\n  },\n\n  data() {\n    return {\n      place: {\n        id: 0,\n        type: {\n          name: \"\"\n        },\n        loaded: false,\n        descendants: []\n      }\n    };\n  },\n\n  created() {\n    this.fetch();\n  },\n\n  computed: {\n    maps() {\n      return this.place.maps || [];\n    },\n\n    kiosk() {\n      return this.$store.state.app.kiosk || {\n        id: null\n      };\n    },\n\n    campus() {\n      return this.$store.state.app.campus;\n    },\n\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    photo() {\n      if (this.place.loaded && this.place.buildingPhoto) {\n        return this.place.buildingPhoto[0];\n      }\n\n      return {\n        url: \"\",\n        width: 0,\n        height: 0\n      };\n    },\n\n    options() {\n      return this.place.descendants.map(item => {\n        if (item.type.handle === \"floor\") {\n          item[\"$isDisabled\"] = true;\n        }\n\n        return item;\n      });\n    },\n\n    styles() {\n      return {\n        defaultColor: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    }\n\n  },\n  methods: {\n    fetch() {\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/place\", {\n        id: this.$route.params.id,\n        locationId: this.kiosk.id\n      }).then(response => {\n        this.place = { ...response.data.place,\n          loaded: true\n        };\n      }).catch(error => console.error(error));\n    },\n\n    handleSelectedPlace(place) {\n      if (place && place.id) {\n        this.$router.push({\n          name: \"room\",\n          params: {\n            id: place.id\n          }\n        });\n      }\n    }\n\n  },\n\n  route() {\n    return {\n      name: \"campus\",\n      params: {\n        id: this.campus.id\n      }\n    };\n  },\n\n  watch: {\n    $route(to) {\n      if (to.name === \"building\" && to.params.id != this.place.id) {\n        this.place = {\n          id: 0,\n          type: {\n            name: \"\"\n          },\n          loaded: false,\n          descendants: []\n        };\n        this.fetch();\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css&":
/*!*****************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=style&index=0&lang=css& ***!
  \*****************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("exports = module.exports = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ \"./node_modules/css-loader/dist/runtime/api.js\")(false);\n// Module\nexports.push([module.i, \"\\n::-webkit-scrollbar {\\r\\nwidth: 15px;\\n}\\n.multiselect__select:before {\\r\\n  top: 80%;\\r\\n  color: #000e2f;\\r\\n  border-color: #000e2f transparent transparent transparent;\\r\\n  border-width: 12px 12px 0;\\n}\\n.multiselect__option--highlight {\\r\\n  color: #fff;\\r\\n  background-color: #000e2f;\\n}\\n.multiselect__tags {\\r\\n  border: 2px solid #000e2f;\\r\\n  border-radius: 0;\\n}\\n.multiselect__placeholder {\\r\\n  color: #000e2f;\\n}\\n._scroll {\\r\\n  overflow-y: auto;\\n}\\r\\n/* Handle */\\n._scroll::-webkit-scrollbar-thumb {\\r\\nbackground: #111;\\r\\nborder-radius: 10px;\\n}\\r\\n/* Handle on hover */\\n._scroll::-webkit-scrollbar-thumb:hover {\\r\\nbackground: #111;\\n}\\r\\n\", \"\"]);\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&":
/*!********************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98& ***!
  \********************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    { attrs: { loaded: _vm.place.loaded, classes: \"pt-8 px-16\" } },\n    [\n      _c(\"section\", { staticClass: \"xl:flex flex-wrap\" }, [\n        _c(\n          \"div\",\n          { staticClass: \"xl:w-1/2 xl:order-1 xl:pt-6 lg:pb-6 md:pb-6\" },\n          [\n            _c(\"mod-map\", { staticClass: \"xl:px-4\", attrs: { maps: _vm.maps } })\n          ],\n          1\n        ),\n        _vm._v(\" \"),\n        _c(\"div\", { staticClass: \"w-full flex flex-wrap xl:w-1/2 xl:pt-6\" }, [\n          _vm.photo\n            ? _c(\n                \"div\",\n                { staticClass: \"w-full xl:pb-0 lg:pb-4 md:pb-4\" },\n                [\n                  _c(\n                    \"page-header\",\n                    {\n                      staticClass: \"block xl:hidden lg:block md:block sm:block\"\n                    },\n                    [\n                      _vm._v(\n                        _vm._s(_vm.place.buildingName) +\n                          \" \" +\n                          _vm._s(_vm.place.type.name)\n                      )\n                    ]\n                  )\n                ],\n                1\n              )\n            : _c(\n                \"div\",\n                { staticClass: \"w-full mb-6\" },\n                [\n                  _c(\"page-header\", { staticClass: \"block\" }, [\n                    _vm._v(\n                      _vm._s(_vm.place.buildingName) +\n                        \" \" +\n                        _vm._s(_vm.place.type.name)\n                    )\n                  ])\n                ],\n                1\n              ),\n          _vm._v(\" \"),\n          _c(\"div\", { staticClass: \"w-1/2 pr-10\" }, [\n            _c(\n              \"div\",\n              [\n                _c(\"ui-photo\", {\n                  staticClass: \"xl:pb-4 lg:pb-6 md:pb-6\",\n                  attrs: { photo: _vm.photo }\n                }),\n                _vm._v(\" \"),\n                _vm.photo\n                  ? _c(\n                      \"p\",\n                      { staticClass: \"xl:pb-4\" },\n                      [\n                        _c(\n                          \"page-header\",\n                          {\n                            staticClass: \"hidden xl:block md:hidden sm:hidden\"\n                          },\n                          [\n                            _vm._v(\n                              _vm._s(_vm.place.buildingName) +\n                                \" \" +\n                                _vm._s(_vm.place.type.name)\n                            )\n                          ]\n                        )\n                      ],\n                      1\n                    )\n                  : _vm._e(),\n                _vm._v(\" \"),\n                _vm.place.placePhone\n                  ? _c(\"p\", { staticClass: \"pb-4\" }, [\n                      _c(\"span\", { staticClass: \"block font-bold\" }, [\n                        _vm._v(_vm._s(_vm.place.placePhone))\n                      ])\n                    ])\n                  : _vm._e(),\n                _vm._v(\" \"),\n                _c(\"p\", { staticClass: \"pb-4\" }, [\n                  _c(\"span\", { staticClass: \"block\" }, [\n                    _vm._v(_vm._s(_vm.place.placeAddress))\n                  ]),\n                  _vm._v(\" \"),\n                  _c(\"span\", { staticClass: \"block\" }, [\n                    _vm._v(\n                      \"\\n              \" +\n                        _vm._s(_vm.place.placeCity) +\n                        \", \" +\n                        _vm._s(_vm.place.placeState) +\n                        \"\\n              \" +\n                        _vm._s(_vm.place.placeZipcode) +\n                        \"\\n            \"\n                    )\n                  ])\n                ]),\n                _vm._v(\" \"),\n                _c(\"p\", { staticClass: \"pb-4\" }, [\n                  _c(\"span\", {\n                    staticClass: \"block h-40 xl:h-56 max-w-full pr-2 _scroll\",\n                    domProps: {\n                      innerHTML: _vm._s(_vm.place.buildingDescription)\n                    }\n                  })\n                ])\n              ],\n              1\n            )\n          ]),\n          _vm._v(\" \"),\n          _c(\"div\", { staticClass: \"w-1/2\" }, [\n            _c(\n              \"div\",\n              { staticClass: \"pr-6\" },\n              [\n                _c(\"multi-select\", {\n                  attrs: {\n                    \"track-by\": \"id\",\n                    label: \"title\",\n                    placeholder: \"CHOOSE YOUR DESTINATION\",\n                    value: \"\",\n                    options: _vm.options,\n                    \"show-labels\": false,\n                    \"allow-empty\": true\n                  },\n                  on: { input: _vm.handleSelectedPlace },\n                  scopedSlots: _vm._u([\n                    {\n                      key: \"option\",\n                      fn: function(ref) {\n                        var option = ref.option\n                        return [\n                          _c(\"p\", { staticClass: \"cursor-pointer\" }, [\n                            _vm._v(_vm._s(option.title))\n                          ])\n                        ]\n                      }\n                    }\n                  ])\n                }),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"flex w-full pt-6\" }, [\n                  _c(\n                    \"div\",\n                    { staticClass: \"pr-4 text-lg w-1/2\" },\n                    [\n                      _c(\n                        \"router-link\",\n                        {\n                          attrs: {\n                            to: {\n                              name: \"campus\",\n                              params: { id: _vm.campus.id }\n                            }\n                          }\n                        },\n                        [\n                          _c(\"p\", [\n                            _c(\n                              \"span\",\n                              {\n                                staticClass: \"flex cursor-pointer underline\",\n                                style: _vm.styles.defaultColor\n                              },\n                              [_vm._v(\"CAMPUS\\n                  \")]\n                            )\n                          ])\n                        ]\n                      )\n                    ],\n                    1\n                  ),\n                  _vm._v(\" \"),\n                  _c(\"div\", { staticClass: \"w-1/2 \" }, [\n                    _c(\"span\", { staticClass: \"flex flex-row-reverse\" }, [\n                      _c(\n                        \"a\",\n                        {\n                          staticClass: \"cursor-pointer underline text-lg\",\n                          style: _vm.styles.defaultColor,\n                          on: {\n                            click: function() {\n                              return (_vm.$store.state.app.searchIsOpen = true)\n                            }\n                          }\n                        },\n                        [_vm._v(\"SEARCH\")]\n                      )\n                    ])\n                  ])\n                ])\n              ],\n              1\n            )\n          ])\n        ])\n      ])\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

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