(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["people"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/PersonCard.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  props: {\n    person: {\n      type: Object,\n      default: () => {\n        id: null;\n      }\n    }\n  },\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    styles() {\n      return {\n        background: [`background-color: ${this.theme.cards.bg}`].join(\";\"),\n        title: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    },\n\n    role() {\n      const role = {\n        title: \"\",\n        department: \"\"\n      };\n\n      if (this.person.personRoles) {\n        return {\n          title: this.person.personRoles[0].roleTitle,\n          department: this.person.personRoles[0].roleDepartment[0].title\n        };\n      }\n\n      return role;\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_PersonCard_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/PersonCard.vue */ \"./src/js/components/PersonCard.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"People\"\n  },\n  components: {\n    PersonCard: _components_PersonCard_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n\n  data() {\n    return {\n      loaded: {\n        people: false,\n        departments: false\n      },\n      filters: {\n        letter: \"\",\n        department: \"\"\n      },\n      people: [],\n      departments: []\n    };\n  },\n\n  created() {\n    this.fetchPeople();\n    this.fetchDepartments();\n  },\n\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    styles() {\n      return {\n        border: [`border-color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    }\n\n  },\n  methods: {\n    fetchPeople(params = {}) {\n      this.loaded.people = false;\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/people\", params).then(response => {\n        if (response.data.success) {\n          this.people = response.data.people;\n        } else {\n          this.people = [];\n        }\n\n        this.loaded.people = true;\n      }).catch(error => console.error(error));\n    },\n\n    fetchDepartments() {\n      this.loaded.departments = false;\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/departments\").then(response => {\n        if (response.data.success) {\n          this.departments = response.data.departments;\n          this.loaded.departments = true;\n        }\n      }).catch(error => console.error(error));\n    },\n\n    handleSelectedFilter(name, event) {\n      this.filters = { ...this.filters,\n        [name]: event.target.value\n      };\n      this.$nextTick(() => this.fetchPeople({\n        filters: this.filters\n      }));\n    },\n\n    alphabet() {\n      var alphabet = [];\n\n      for (var i = 0; i < 25; i++) {\n        var char = String.fromCharCode(65 + i);\n        alphabet.push(char);\n      }\n\n      return alphabet;\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=template&id=4898b751&":
/*!*******************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/PersonCard.vue?vue&type=template&id=4898b751& ***!
  \*******************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"router-link\",\n    {\n      staticClass:\n        \"flex-1 flex p-4 cursor-pointer bg-white border border-gray-200 hover:bg-gray-200\",\n      style: _vm.styles.background,\n      attrs: { to: { name: \"person\", params: { id: _vm.person.id } } }\n    },\n    [\n      _c(\"div\", [\n        _c(\n          \"h2\",\n          {\n            staticClass: \"font-semibold text-lg cursor-pointer uppercase\",\n            style: _vm.styles.title\n          },\n          [\n            _vm._v(\n              \"\\n      \" +\n                _vm._s(_vm.person.personFirstName) +\n                \"\\n      \" +\n                _vm._s(_vm.person.personLastName) +\n                \"\\n    \"\n            )\n          ]\n        ),\n        _vm._v(\" \"),\n        _c(\"p\", { staticClass: \"text-md cursor-pointer\" }, [\n          _vm._v(_vm._s(_vm.role.title))\n        ]),\n        _vm._v(\" \"),\n        _c(\"p\", { staticClass: \"text-sm cursor-pointer opacity-75 \" }, [\n          _vm._v(_vm._s(_vm.role.department))\n        ])\n      ])\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&":
/*!****************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a& ***!
  \****************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    {\n      attrs: {\n        loaded: _vm.loaded.people && _vm.loaded.departments,\n        classes: \"flex flex-wrap\"\n      }\n    },\n    [\n      !this.people.length\n        ? _c(\n            \"div\",\n            {\n              staticClass: \"flex-1 flex items-center justify-center\",\n              staticStyle: { height: \"65vh\" }\n            },\n            [\n              _c(\"h1\", { staticClass: \"font-thin text-4xl text-center\" }, [\n                _vm._v(\n                  \"\\n      We did not find anyone matching your criteria.\\n    \"\n                )\n              ])\n            ]\n          )\n        : _c(\n            \"div\",\n            {\n              staticClass: \"w-full p-4 overflow-y-scroll overflow-x-hidden\",\n              staticStyle: { height: \"60vh\" }\n            },\n            [\n              _c(\"page-header\", [_vm._v(\"Directory\")]),\n              _vm._v(\" \"),\n              _c(\n                \"div\",\n                { staticClass: \"flex flex-wrap -mx-2 lg:-mx-4\" },\n                _vm._l(_vm.people, function(person) {\n                  return _c(\n                    \"div\",\n                    {\n                      key: person.id,\n                      staticClass:\n                        \"w-1/2 sm:w-1/3 md:w-1/3 lg:w-1/4 xl:w-1/5 flex my-2 px-2 lg:my-4 lg:px-4\"\n                    },\n                    [_c(\"person-card\", { attrs: { person: person } })],\n                    1\n                  )\n                }),\n                0\n              )\n            ],\n            1\n          ),\n      _vm._v(\" \"),\n      _c(\n        \"div\",\n        {\n          staticClass:\n            \"w-full flex justify-center items-center self-end px-4 border-t border-dotted border-gray-500\",\n          staticStyle: { height: \"10vh\" }\n        },\n        [\n          _c(\n            \"select\",\n            {\n              staticClass: \"flex w-1/2 h-12 mt-1 mr-2 px-8 border-2\",\n              style: _vm.styles.border,\n              domProps: { value: _vm.filters.letter },\n              on: {\n                input: function($event) {\n                  return _vm.handleSelectedFilter(\"letter\", $event)\n                }\n              }\n            },\n            [\n              _c(\n                \"option\",\n                {\n                  staticClass: \"hidden\",\n                  attrs: { value: \"\", disabled: \"\", selected: \"\" }\n                },\n                [_vm._v(\"Filter by Last Initial\")]\n              ),\n              _vm._v(\" \"),\n              _vm._l(_vm.alphabet(), function(option) {\n                return _c(\n                  \"option\",\n                  { key: option, domProps: { value: option } },\n                  [_vm._v(_vm._s(option))]\n                )\n              })\n            ],\n            2\n          ),\n          _vm._v(\" \"),\n          _c(\n            \"select\",\n            {\n              staticClass: \"flex w-1/2 h-12 mt-1 ml-2 px-8 border-2\",\n              style: _vm.styles.border,\n              domProps: { value: _vm.filters.department },\n              on: {\n                input: function($event) {\n                  return _vm.handleSelectedFilter(\"department\", $event)\n                }\n              }\n            },\n            [\n              _c(\n                \"option\",\n                {\n                  staticClass: \"hidden\",\n                  attrs: { value: \"\", disabled: \"\", selected: \"\" }\n                },\n                [_vm._v(\"Filter by Department\")]\n              ),\n              _vm._v(\" \"),\n              _vm._l(_vm.departments, function(department) {\n                return _c(\n                  \"option\",\n                  { key: department.id, domProps: { value: department.id } },\n                  [_vm._v(_vm._s(department.title))]\n                )\n              })\n            ],\n            2\n          )\n        ]\n      )\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/components/PersonCard.vue":
/*!******************************************!*\
  !*** ./src/js/components/PersonCard.vue ***!
  \******************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./PersonCard.vue?vue&type=template&id=4898b751& */ \"./src/js/components/PersonCard.vue?vue&type=template&id=4898b751&\");\n/* harmony import */ var _PersonCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./PersonCard.vue?vue&type=script&lang=js& */ \"./src/js/components/PersonCard.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _PersonCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/components/PersonCard.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?");

/***/ }),

/***/ "./src/js/components/PersonCard.vue?vue&type=script&lang=js&":
/*!*******************************************************************!*\
  !*** ./src/js/components/PersonCard.vue?vue&type=script&lang=js& ***!
  \*******************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_PersonCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/babel-loader/lib!../../../node_modules/vue-loader/lib??vue-loader-options!./PersonCard.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_PersonCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?");

/***/ }),

/***/ "./src/js/components/PersonCard.vue?vue&type=template&id=4898b751&":
/*!*************************************************************************!*\
  !*** ./src/js/components/PersonCard.vue?vue&type=template&id=4898b751& ***!
  \*************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../node_modules/vue-loader/lib??vue-loader-options!./PersonCard.vue?vue&type=template&id=4898b751& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=template&id=4898b751&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PersonCard_vue_vue_type_template_id_4898b751___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?");

/***/ }),

/***/ "./src/js/pages/people/Index.vue":
/*!***************************************!*\
  !*** ./src/js/pages/people/Index.vue ***!
  \***************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Index.vue?vue&type=template&id=4f88849a& */ \"./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&\");\n/* harmony import */ var _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Index.vue?vue&type=script&lang=js& */ \"./src/js/pages/people/Index.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/people/Index.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?");

/***/ }),

/***/ "./src/js/pages/people/Index.vue?vue&type=script&lang=js&":
/*!****************************************************************!*\
  !*** ./src/js/pages/people/Index.vue?vue&type=script&lang=js& ***!
  \****************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?");

/***/ }),

/***/ "./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&":
/*!**********************************************************************!*\
  !*** ./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a& ***!
  \**********************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=template&id=4f88849a& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?");

/***/ })

}]);