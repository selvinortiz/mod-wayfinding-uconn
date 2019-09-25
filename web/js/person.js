(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["person"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=script&lang=js&":
/*!****************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/_Person.vue?vue&type=script&lang=js& ***!
  \****************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo() {\n    return {\n      title: this.title\n    };\n  },\n\n  data() {\n    return {\n      person: {\n        id: 0,\n        loaded: false\n      }\n    };\n  },\n\n  created() {\n    this.fetch();\n  },\n\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    title() {\n      return `${this.person.personFirstName} ${this.person.personLastName}`;\n    },\n\n    place() {\n      let place = this.person.loaded ? this.person.personRelatedPlace[0] : null;\n\n      if (!place) {\n        place = {\n          id: null\n        };\n      }\n\n      place.loaded = true;\n      return place;\n    }\n\n  },\n  methods: {\n    fetch() {\n      Object(_utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"person\"])({\n        id: this.$route.params.id\n      }).then(response => {\n        this.person = { ...response.data.person,\n          loaded: true\n        };\n      }).catch(error => console.error(error));\n    },\n\n    openInMaps() {\n      const address = `maps.google.com/maps?daddr=${[this.person.personCity, this.person.personState, this.person.personZipcode].join(\"+\")}&ll=`;\n\n      if (navigator.platform.includes(\"iP\")) {\n        window.open(`https://${address}`);\n      } else {\n        window.open(`maps://${address}`);\n      }\n    }\n\n  },\n  watch: {\n    $route(to) {\n      if (to.name === \"person\") {\n        this.person = {};\n        this.fetch();\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908&":
/*!******************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908& ***!
  \******************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    { staticClass: \"p-8\", attrs: { loaded: _vm.person.loaded } },\n    [\n      _c(\"section\", { staticClass: \"xl:flex flex-wrap\" }, [\n        _c(\n          \"div\",\n          { staticClass: \"xl:w-1/2 xl:order-1\" },\n          [\n            _c(\"mod-map\", {\n              staticClass: \"xl:px-4\",\n              attrs: { place: _vm.place }\n            })\n          ],\n          1\n        ),\n        _vm._v(\" \"),\n        _c(\"div\", { staticClass: \"w-full flex flex-wrap xl:w-1/2 pt-4\" }, [\n          _c(\"div\", { staticClass: \"pt-8\", staticStyle: { flex: \"4\" } }, [\n            _c(\"img\", {\n              staticStyle: { \"max-width\": \"256px\" },\n              attrs: { src: \"/static/img/avatar.svg\" }\n            })\n          ]),\n          _vm._v(\" \"),\n          _c(\"div\", { staticStyle: { flex: \"8\" } }, [\n            _c(\n              \"div\",\n              { staticClass: \"pt-8 px-4\" },\n              [\n                _c(\n                  \"h2\",\n                  {\n                    staticClass: \"font-thin text-4xl leading-none uppercase\",\n                    style: \"color: \" + _vm.theme.colors.primary\n                  },\n                  [\n                    _vm._v(\n                      _vm._s(_vm.person.personFirstName) +\n                        \" \" +\n                        _vm._s(_vm.person.personLastName)\n                    )\n                  ]\n                ),\n                _vm._v(\" \"),\n                _vm._l(_vm.person.personRoles, function(role) {\n                  return _c(\"div\", { key: role.id, staticClass: \"pt-2\" }, [\n                    _c(\"p\", { staticClass: \"font-bold\" }, [\n                      _vm._v(_vm._s(role.roleTitle))\n                    ]),\n                    _vm._v(\" \"),\n                    _c(\"p\", [_vm._v(_vm._s(role.roleDepartment[0].title))])\n                  ])\n                }),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"pt-4\" }, [\n                  _c(\"p\", { staticClass: \"font-bold\" }, [\n                    _vm._v(_vm._s(_vm.person.personPhone))\n                  ]),\n                  _vm._v(\" \"),\n                  _c(\"p\", { staticClass: \"font-bold mb-4\" }, [\n                    _vm._v(_vm._s(_vm.person.personEmail))\n                  ])\n                ]),\n                _vm._v(\" \"),\n                _c(\"div\", { staticClass: \"pt-4\" }, [\n                  _c(\n                    \"a\",\n                    {\n                      staticClass: \"cursor-pointer\",\n                      style: \"color: \" + _vm.theme.colors.primary,\n                      on: { click: _vm.openInMaps }\n                    },\n                    [\n                      _vm._v(\n                        _vm._s(_vm.person.personCity) +\n                          \", \" +\n                          _vm._s(_vm.person.personState) +\n                          \" \" +\n                          _vm._s(_vm.person.personZipcode) +\n                          \" →\"\n                      )\n                    ]\n                  )\n                ]),\n                _vm._v(\" \"),\n                _c(\"div\", {\n                  staticClass: \"pt-4\",\n                  domProps: { innerHTML: _vm._s(_vm.person.personDescription) }\n                })\n              ],\n              2\n            )\n          ])\n        ])\n      ])\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/people/_Person.vue":
/*!*****************************************!*\
  !*** ./src/js/pages/people/_Person.vue ***!
  \*****************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./_Person.vue?vue&type=template&id=09d68908& */ \"./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908&\");\n/* harmony import */ var _Person_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./_Person.vue?vue&type=script&lang=js& */ \"./src/js/pages/people/_Person.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Person_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/people/_Person.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?");

/***/ }),

/***/ "./src/js/pages/people/_Person.vue?vue&type=script&lang=js&":
/*!******************************************************************!*\
  !*** ./src/js/pages/people/_Person.vue?vue&type=script&lang=js& ***!
  \******************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Person_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Person.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Person_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?");

/***/ }),

/***/ "./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908&":
/*!************************************************************************!*\
  !*** ./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908& ***!
  \************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Person.vue?vue&type=template&id=09d68908& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Person_vue_vue_type_template_id_09d68908___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?");

/***/ })

}]);