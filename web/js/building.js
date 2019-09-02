(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["building"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_shared_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/shared/ModMap.vue */ \"./src/js/components/shared/ModMap.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Place\"\n  },\n  components: {\n    ModMap: _components_shared_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n\n  data() {\n    return {\n      place: {},\n      selectedRoom: ''\n    };\n  },\n\n  created() {\n    _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/place\", {\n      id: this.$route.params.id\n    }).then(response => {\n      this.place = { ...response.data.place,\n        loaded: true\n      };\n      console.log(this.place);\n    }).catch(error => console.error(error));\n  }\n\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&":
/*!********************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98& ***!
  \********************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"div\",\n    { staticClass: \"p-8\" },\n    [\n      _c(\"mod-page-header\", [_vm._v(\"Building\")]),\n      _vm._v(\" \"),\n      _c(\"people-place-header\", {\n        attrs: { heading: \"WAYFINDING\", classes: \"flex lg:hidden\" }\n      }),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"flex flex-wrap justify-center\" }, [\n        _c(\n          \"div\",\n          {\n            staticClass:\n              \"flex flex-wrap justify-center md:w-full md:mb-6 md:order-1 lg:w-1/2 lg:order-2 \"\n          },\n          [_c(\"mod-map\", { attrs: { place: _vm.place } })],\n          1\n        ),\n        _vm._v(\" \"),\n        _c(\"div\", { staticClass: \"lg:w-1/2 lg:order-1 md:w-full md:order-2\" }, [\n          _c(\"div\", { style: _vm.containerStyles }, [\n            _c(\n              \"div\",\n              { staticClass: \"w-full flex flex-wrap justify-center p-4\" },\n              [\n                _c(\"div\", { staticClass: \"w-full mb-4 text-2xl font-black\" }, [\n                  _vm._v(_vm._s(_vm.place.title))\n                ]),\n                _vm._v(\" \"),\n                _vm._m(0),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"w-1/2 text-center\" }, [\n                  _c(\n                    \"select\",\n                    {\n                      directives: [\n                        {\n                          name: \"model\",\n                          rawName: \"v-model\",\n                          value: _vm.selectedRoom,\n                          expression: \"selectedRoom\"\n                        }\n                      ],\n                      staticClass:\n                        \"w-full flex items-center h-12 px-6 border-2 border-gray-600\",\n                      on: {\n                        change: function($event) {\n                          var $$selectedVal = Array.prototype.filter\n                            .call($event.target.options, function(o) {\n                              return o.selected\n                            })\n                            .map(function(o) {\n                              var val = \"_value\" in o ? o._value : o.value\n                              return val\n                            })\n                          _vm.selectedRoom = $event.target.multiple\n                            ? $$selectedVal\n                            : $$selectedVal[0]\n                        }\n                      }\n                    },\n                    [\n                      _c(\n                        \"option\",\n                        {\n                          staticClass: \"hidden\",\n                          attrs: { value: \"\", selected: \"\", disabled: \"\" }\n                        },\n                        [_vm._v(\"Choose Destination\")]\n                      ),\n                      _vm._v(\" \"),\n                      _vm._l(_vm.place.descendants, function(floorOrRoom) {\n                        return _c(\n                          \"option\",\n                          {\n                            key: floorOrRoom.id,\n                            attrs: {\n                              disabled: floorOrRoom.type.handle === \"floor\"\n                            },\n                            domProps: { value: floorOrRoom.id }\n                          },\n                          [_vm._v(_vm._s(floorOrRoom.title))]\n                        )\n                      })\n                    ],\n                    2\n                  ),\n                  _vm._v(\" \"),\n                  _c(\"div\", { staticClass: \"pt-4\" }, [\n                    _vm._v(\n                      \"\\n              Don’t see what you’re looking for?\\n              \"\n                    ),\n                    _c(\n                      \"a\",\n                      {\n                        staticClass: \"text-blue-600 cursor-pointer\",\n                        on: {\n                          click: function() {\n                            return (_vm.$store.state.app.searchIsOpen = true)\n                          }\n                        }\n                      },\n                      [_vm._v(\"Switch to SEARCH\")]\n                    )\n                  ])\n                ])\n              ]\n            )\n          ])\n        ])\n      ])\n    ],\n    1\n  )\n}\nvar staticRenderFns = [\n  function() {\n    var _vm = this\n    var _h = _vm.$createElement\n    var _c = _vm._self._c || _h\n    return _c(\"div\", { staticClass: \"w-1/2\" }, [\n      _c(\"img\", {\n        staticClass: \"w-4/5 mb-4\",\n        attrs: { src: \"http://placehold.it/500\" }\n      }),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"font-bold mb-4\" }, [_vm._v(\"Phone Number\")]),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"font-bold\" }, [_vm._v(\"Address Line 1\")]),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"font-bold mb-4\" }, [_vm._v(\"Address Line 2\")]),\n      _vm._v(\" \"),\n      _c(\"div\", [_vm._v(\"Place Description\")])\n    ])\n  }\n]\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/places/_Building.vue":
/*!*******************************************!*\
  !*** ./src/js/pages/places/_Building.vue ***!
  \*******************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./_Building.vue?vue&type=template&id=3a1b6a98& */ \"./src/js/pages/places/_Building.vue?vue&type=template&id=3a1b6a98&\");\n/* harmony import */ var _Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./_Building.vue?vue&type=script&lang=js& */ \"./src/js/pages/places/_Building.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Building_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Building_vue_vue_type_template_id_3a1b6a98___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/places/_Building.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/places/_Building.vue?");

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