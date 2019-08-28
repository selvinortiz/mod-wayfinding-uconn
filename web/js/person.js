(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["person"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=script&lang=js&":
/*!****************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/_Person.vue?vue&type=script&lang=js& ***!
  \****************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_shared_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/shared/ModMap.vue */ \"./src/js/components/shared/ModMap.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo() {\n    return {\n      title: this.title\n    };\n  },\n\n  data() {\n    return {\n      person: {},\n      primaryColor: 'blue-800'\n    };\n  },\n\n  components: {\n    ModMap: _components_shared_ModMap_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n  computed: {\n    title() {\n      return `${this.person.personFirstName} ${this.person.personLastName}`;\n    }\n\n  },\n\n  created() {\n    _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/person\", {\n      id: this.$route.params.id\n    }).then(response => {\n      this.person = response.data.person;\n    }).catch(error => console.error(error));\n  }\n\n});\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908&":
/*!******************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/_Person.vue?vue&type=template&id=09d68908& ***!
  \******************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\"div\", { staticClass: \"p-4\" }, [\n    _c(\n      \"div\",\n      { staticClass: \"w-full flex flex-wrap justify-center lg:hidden\" },\n      [\n        _c(\"div\", { staticClass: \"lg:w-11/12 w-full mb-4\" }, [\n          _c(\n            \"div\",\n            { class: \"text-3xl text-\" + _vm.primaryColor + \" font-300\" },\n            [_vm._v(\"DIRECTORY\")]\n          ),\n          _vm._v(\" \"),\n          _c(\"div\", { class: \"text-1xl text-\" + _vm.primaryColor }, [\n            _vm._v(\n              \"\\n          \" +\n                _vm._s(\"Breadcrumb nav 1\") +\n                \"\\n          >\\n          \" +\n                _vm._s(\"Breadcrumb nav 2\") +\n                \"\\n        \"\n            )\n          ])\n        ])\n      ]\n    ),\n    _vm._v(\" \"),\n    _c(\"div\", { staticClass: \"flex flex-wrap\" }, [\n      _c(\n        \"div\",\n        {\n          staticClass:\n            \"flex flex-wrap justify-center lg:w-1/2 lg:order-2 md:w-full md:order-1\"\n        },\n        [\n          _c(\n            \"div\",\n            { staticClass: \"flex w-full\" },\n            [_c(\"mod-map\", { attrs: { place: _vm.person } })],\n            1\n          ),\n          _vm._v(\" \"),\n          _c(\n            \"div\",\n            {\n              staticClass:\n                \"flex w-full justify-center lg:justify-end xl:justify-end\"\n            },\n            [\n              _c(\n                \"button\",\n                {\n                  class:\n                    \"flex w-1/4 justify-center m-4 bg-transparent \" +\n                    \"font-semibold hover:text-white py-2 px-4 border hover:border-transparent \" +\n                    \"hover:bg-\" +\n                    _vm.primaryColor +\n                    \" text-\" +\n                    _vm.primaryColor +\n                    \" border-\" +\n                    _vm.primaryColor\n                },\n                [_vm._v(\"\\n          Campus Map\\n        \")]\n              ),\n              _vm._v(\" \"),\n              _c(\n                \"button\",\n                {\n                  class:\n                    \"flex w-1/4 justify-center m-4 bg-transparent \" +\n                    \"font-semibold hover:text-white py-2 px-4 border hover:border-transparent \" +\n                    \"hover:bg-\" +\n                    _vm.primaryColor +\n                    \" text-\" +\n                    _vm.primaryColor +\n                    \" border-\" +\n                    _vm.primaryColor\n                },\n                [_vm._v(\"\\n          Building Map\\n        \")]\n              )\n            ]\n          )\n        ]\n      ),\n      _vm._v(\" \"),\n      _c(\n        \"div\",\n        {\n          staticClass:\n            \"flex flex-wrap justify-center lg:w-1/2 lg:order-1 md:w-full md:order-2\"\n        },\n        [\n          _c(\"div\", { staticClass: \"w-full justify-center hidden lg:flex\" }, [\n            _c(\"div\", { staticClass: \"lg:w-11/12 w-full mb-4\" }, [\n              _c(\n                \"div\",\n                { class: \"text-3xl text-\" + _vm.primaryColor + \" font-300\" },\n                [_vm._v(\"DIRECTORY\")]\n              ),\n              _vm._v(\" \"),\n              _c(\"div\", { class: \"text-1xl text-\" + _vm.primaryColor }, [\n                _vm._v(\n                  \"\\n              \" +\n                    _vm._s(\"Breadcrumb nav 1\") +\n                    \"\\n              >\\n              \" +\n                    _vm._s(\"Breadcrumb nav 2\") +\n                    \"\\n            \"\n                )\n              ])\n            ])\n          ]),\n          _vm._v(\" \"),\n          _c(\"div\", { staticClass: \"flex flex-wrap w-11/12\" }, [\n            _c(\"div\", { class: \"w-3/5 text-\" + _vm.primaryColor }, [\n              _c(\n                \"div\",\n                { class: \"font-black mb-4 text-2xl text-\" + _vm.primaryColor },\n                [\n                  _vm._v(\n                    _vm._s(_vm.person.personFirstName) +\n                      \" \" +\n                      _vm._s(_vm.person.personLastName)\n                  )\n                ]\n              ),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"font-bold\" }, [_vm._v(\"Title 1\")]),\n              _vm._v(\" \"),\n              _c(\"div\", [_vm._v(\"Department\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"font-bold\" }, [_vm._v(\"Title 2\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"mb-4\" }, [_vm._v(\"Department\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"font-bold\" }, [\n                _vm._v(\"Building Name\")\n              ]),\n              _vm._v(\" \"),\n              _c(\"div\", [_vm._v(\"Suite #\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"mb-4\" }, [_vm._v(\"Floor #\")]),\n              _vm._v(\" \"),\n              _c(\"div\", [_vm._v(\"Address Line 1\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"mb-4\" }, [_vm._v(\"Address Line 2\")]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"font-bold\" }, [\n                _vm._v(_vm._s(_vm.person.personPhone))\n              ]),\n              _vm._v(\" \"),\n              _c(\"div\", { staticClass: \"font-bold mb-4\" }, [\n                _vm._v(_vm._s(_vm.person.personEmail))\n              ]),\n              _vm._v(\" \"),\n              _c(\"div\", [_vm._v(_vm._s(_vm.person.personDescription))])\n            ]),\n            _vm._v(\" \"),\n            _c(\"div\", { staticClass: \"w-2/5 text-center\" }, [\n              _c(\"img\", {\n                staticClass: \"w-3/5 mb-6\",\n                staticStyle: { \"max-width\": \"300px\" },\n                attrs: { src: \"http://placehold.it/500\" }\n              }),\n              _vm._v(\" \"),\n              _c(\n                \"div\",\n                {\n                  class:\n                    \"w-3/5 w-auto text-\" +\n                    _vm.primaryColor +\n                    \" border border-\" +\n                    _vm.primaryColor\n                },\n                [_vm._v(\"Send to Phone\")]\n              )\n            ])\n          ])\n        ]\n      )\n    ])\n  ])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/_Person.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

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