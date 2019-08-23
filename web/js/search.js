(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["search"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=script&lang=js&":
/*!********************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/Search.vue?vue&type=script&lang=js& ***!
  \********************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_shared_ModKeyboard_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../components/shared/ModKeyboard.vue */ \"./src/js/components/shared/ModKeyboard.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Search\"\n  },\n\n  data() {\n    return {\n      input: \"\",\n      context: \"\",\n      searching: false,\n      results: [],\n      searchErrorMessage: \"\",\n      showKeyboard: !(\"ontouchstart\" in document.documentElement),\n      keyboardLayout: [\"1 2 3\", \"4 5 6\", \"7 8 9\", \"0 {tab}\"],\n      keyboardButtonLabels: {\n        \"{space}\": \"Space\",\n        \"{bksp}\": \"⇤\",\n        \"{enter}\": \"Enter\",\n        \"{cancel}\": \"Cancel\",\n        \"{lock}\": \"Caps\",\n        \"{tab}\": \"Next\",\n        \"{shift}\": \"123\"\n      }\n    };\n  },\n\n  components: {\n    ModKeyboard: _components_shared_ModKeyboard_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n  methods: {\n    search() {\n      this.searching = true;\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/search\", {\n        searchQuery: this.input,\n        searchContext: this.context\n      }).then(response => {\n        if (response.data.success) {\n          this.results = response.data.results;\n        } else {\n          this.searchErrorMessage = response.data.message;\n        }\n\n        this.searching = false;\n      }).catch(error => console.error(error));\n    },\n\n    handleKeyboardChange(input) {\n      console.log(\"Input changed\", input);\n      this.input = input;\n    },\n\n    handleKeyboardClick(button) {\n      console.log(\"Button clicked\", button);\n\n      switch (button) {\n        case \"{enter}\":\n          this.search();\n          break;\n\n        case \"{clear}\":\n          this.input = \"\";\n          break;\n\n        default:\n          console.log(button);\n          break;\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=template&id=3fb76e30&":
/*!**********************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/Search.vue?vue&type=template&id=3fb76e30& ***!
  \**********************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\"div\", { staticClass: \"p-4\" }, [\n    _c(\n      \"div\",\n      {\n        staticClass: \"mx-auto\",\n        staticStyle: {\n          display: \"grid\",\n          \"grid-template-rows\": \"1fr 1fr\",\n          \"max-width\": \"720px\"\n        }\n      },\n      [\n        _c(\"section\", [\n          _vm.results.length\n            ? _c(\n                \"div\",\n                { staticClass: \"animated slideInDown\" },\n                [\n                  _c(\"mod-page-header\", [_vm._v(\"Results\")]),\n                  _vm._v(\" \"),\n                  _c(\n                    \"div\",\n                    { staticClass: \"flex flex-wrap -mx-2 lg:-mx-4\" },\n                    _vm._l(_vm.results, function(result) {\n                      return _c(\n                        \"div\",\n                        {\n                          key: result.id,\n                          staticClass:\n                            \"w-full lg:w-1/2 xl:w-1/3 flex my-2 px-2 lg:my-4 lg:px-4\"\n                        },\n                        [\n                          _c(\n                            \"router-link\",\n                            {\n                              staticClass:\n                                \"flex-1 p-4 border border-gray-300 bg-gray-100 rounded\",\n                              attrs: {\n                                to: {\n                                  name: \"person\",\n                                  params: { id: result.id }\n                                }\n                              }\n                            },\n                            [\n                              _c(\"p\", { staticClass: \"font-thin text-xl\" }, [\n                                _vm._v(_vm._s(result.title))\n                              ])\n                            ]\n                          )\n                        ],\n                        1\n                      )\n                    }),\n                    0\n                  )\n                ],\n                1\n              )\n            : _vm._e()\n        ]),\n        _vm._v(\" \"),\n        _c(\n          \"section\",\n          [\n            _c(\"mod-page-header\", [_vm._v(\"Search\")]),\n            _vm._v(\" \"),\n            _c(\n              \"div\",\n              {\n                staticClass:\n                  \"flex items-center my-4 border border-gray-200 animated fadeIn\"\n              },\n              [\n                _c(\n                  \"select\",\n                  {\n                    directives: [\n                      {\n                        name: \"model\",\n                        rawName: \"v-model\",\n                        value: _vm.context,\n                        expression: \"context\"\n                      }\n                    ],\n                    staticClass:\n                      \"bg-transparent outline-none focus:outline-none\",\n                    on: {\n                      change: function($event) {\n                        var $$selectedVal = Array.prototype.filter\n                          .call($event.target.options, function(o) {\n                            return o.selected\n                          })\n                          .map(function(o) {\n                            var val = \"_value\" in o ? o._value : o.value\n                            return val\n                          })\n                        _vm.context = $event.target.multiple\n                          ? $$selectedVal\n                          : $$selectedVal[0]\n                      }\n                    }\n                  },\n                  [\n                    _c(\"option\", { attrs: { value: \"\" } }, [_vm._v(\"All\")]),\n                    _vm._v(\" \"),\n                    _c(\"option\", { attrs: { value: \"people\" } }, [\n                      _vm._v(\"People\")\n                    ]),\n                    _vm._v(\" \"),\n                    _c(\"option\", { attrs: { value: \"places\" } }, [\n                      _vm._v(\"Places\")\n                    ]),\n                    _vm._v(\" \"),\n                    _c(\"option\", { attrs: { value: \"building\" } }, [\n                      _vm._v(\"Buildings\")\n                    ])\n                  ]\n                ),\n                _vm._v(\" \"),\n                _c(\"input\", {\n                  directives: [\n                    {\n                      name: \"model\",\n                      rawName: \"v-model\",\n                      value: _vm.input,\n                      expression: \"input\"\n                    }\n                  ],\n                  staticClass: \"py-2 px-2 outline-none\",\n                  staticStyle: { flex: \"6\" },\n                  attrs: { type: \"text\", placeholder: \"Type to search...\" },\n                  domProps: { value: _vm.input },\n                  on: {\n                    keydown: function($event) {\n                      if (\n                        !$event.type.indexOf(\"key\") &&\n                        _vm._k($event.keyCode, \"enter\", 13, $event.key, \"Enter\")\n                      ) {\n                        return null\n                      }\n                      return _vm.search($event)\n                    },\n                    input: function($event) {\n                      if ($event.target.composing) {\n                        return\n                      }\n                      _vm.input = $event.target.value\n                    }\n                  }\n                }),\n                _vm._v(\" \"),\n                _c(\n                  \"button\",\n                  {\n                    staticClass:\n                      \"py-2 border-l border-gray-200 bg-gray-100 outline-none hover:bg-gray-200 focus:bg-gray-300 focus:outline-none\",\n                    staticStyle: { flex: \"2\" },\n                    on: { click: _vm.search }\n                  },\n                  [_vm._v(\"Search\")]\n                )\n              ]\n            ),\n            _vm._v(\" \"),\n            _vm.showKeyboard\n              ? _c(\"mod-keyboard\", {\n                  attrs: {\n                    animatedClass: \"slideInUp\",\n                    keyboardClass: \"keyboard--numeric\",\n                    input: _vm.input\n                  },\n                  on: {\n                    change: _vm.handleKeyboardChange,\n                    click: _vm.handleKeyboardClick\n                  }\n                })\n              : _vm._e()\n          ],\n          1\n        )\n      ]\n    )\n  ])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/Search.vue":
/*!*********************************!*\
  !*** ./src/js/pages/Search.vue ***!
  \*********************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Search.vue?vue&type=template&id=3fb76e30& */ \"./src/js/pages/Search.vue?vue&type=template&id=3fb76e30&\");\n/* harmony import */ var _Search_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Search.vue?vue&type=script&lang=js& */ \"./src/js/pages/Search.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Search_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/Search.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?");

/***/ }),

/***/ "./src/js/pages/Search.vue?vue&type=script&lang=js&":
/*!**********************************************************!*\
  !*** ./src/js/pages/Search.vue?vue&type=script&lang=js& ***!
  \**********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Search_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/babel-loader/lib!../../../node_modules/vue-loader/lib??vue-loader-options!./Search.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Search_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?");

/***/ }),

/***/ "./src/js/pages/Search.vue?vue&type=template&id=3fb76e30&":
/*!****************************************************************!*\
  !*** ./src/js/pages/Search.vue?vue&type=template&id=3fb76e30& ***!
  \****************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../node_modules/vue-loader/lib??vue-loader-options!./Search.vue?vue&type=template&id=3fb76e30& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=template&id=3fb76e30&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Search_vue_vue_type_template_id_3fb76e30___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?");

/***/ }),

/***/ "./src/js/utils/Axios.js":
/*!*******************************!*\
  !*** ./src/js/utils/Axios.js ***!
  \*******************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! axios */ \"./node_modules/axios/index.js\");\n/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_0__);\n\n/* harmony default export */ __webpack_exports__[\"default\"] = (axios__WEBPACK_IMPORTED_MODULE_0___default.a.create({\n  headers: {\n    'X-CSRF-TOKEN': window.csrfTokenValue\n  }\n}));\n\n//# sourceURL=webpack:///./src/js/utils/Axios.js?");

/***/ })

}]);