(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["people"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/PersonCard.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  props: {\n    person: {\n      type: Object,\n      default: () => {\n        null;\n      }\n    }\n  },\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    styles() {\n      return {\n        background: [`background-color: ${this.theme.directory.cards.bg}`].join(\";\"),\n        title: [`color: ${this.theme.directory.cards.color}`].join(\";\")\n      };\n    },\n\n    directoryphoto() {\n      if (this.theme.directory.cards.cardphoto) {\n        return true;\n      }\n\n      return false;\n    },\n\n    image() {\n      if (this.person && this.person.personPhoto && this.person.personPhoto.length) {\n        return this.person.personPhoto[0];\n      }\n\n      return null;\n    },\n\n    role() {\n      const role = {\n        title: \"\",\n        department: \"\",\n        building: \"\",\n        suite: \"\"\n      };\n\n      if (this.person.personRoles.length > 0) {\n        return {\n          title: this.person.personRoles[0].roleTitle,\n          department: this.person.personRoles[0].roleDepartment[0].title,\n          building: \"\",\n          suite: \"\"\n        };\n      }\n\n      return role;\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n/* harmony import */ var _components_PersonCard_vue__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/PersonCard.vue */ \"./src/js/components/PersonCard.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  name: \"people\",\n  metaInfo: {\n    title: \"People\"\n  },\n  components: {\n    PersonCard: _components_PersonCard_vue__WEBPACK_IMPORTED_MODULE_1__[\"default\"]\n  },\n\n  data() {\n    return {\n      loaded: {\n        people: false,\n        departments: false\n      },\n      filters: {\n        letter: \"\",\n        department: \"\"\n      },\n      people: [],\n      departments: []\n    };\n  },\n\n  created() {\n    this.fetchPeople();\n    this.fetchDepartments();\n  },\n\n  computed: {\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    styles() {\n      return {\n        border: [`border-color: ${this.theme.colors.primary}`].join(\";\"),\n        defaultColor: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    },\n\n    defaultLetterFilterLabel() {\n      if (this.filters.letter === \"\") {\n        return \"Filter by Last Initial\";\n      }\n\n      return \"Clear Last Initial Filter\";\n    },\n\n    defaultDepartmentFilterLabel() {\n      if (this.filters.department === \"\") {\n        return \"Filter by Department\";\n      }\n\n      return \"Clear Department Filter\";\n    }\n\n  },\n  methods: {\n    fetchPeople() {\n      this.loaded.people = false;\n      const filters = {\n        letter: this.filters.letter,\n        department: this.filters.department ? this.filters.department.id : ''\n      };\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/people\", {\n        filters\n      }).then(response => {\n        if (response.data.success) {\n          this.people = response.data.people;\n        } else {\n          this.people = [];\n        }\n\n        this.loaded.people = true;\n      }).catch(error => console.error(error));\n    },\n\n    fetchDepartments() {\n      this.loaded.departments = false;\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/departments\").then(response => {\n        if (response.data.success) {\n          this.departments = response.data.departments;\n          this.loaded.departments = true;\n        }\n      }).catch(error => console.error(error));\n    },\n\n    alphabet() {\n      var alphabet = [];\n\n      for (var i = 0; i < 26; i++) {\n        var char = String.fromCharCode(65 + i);\n        alphabet.push(char);\n      }\n\n      return alphabet;\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&":
/*!*************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css& ***!
  \*************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("exports = module.exports = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ \"./node_modules/css-loader/dist/runtime/api.js\")(false);\n// Module\nexports.push([module.i, \"\\n.multiselect__select:before {\\r\\n  top: 80%;\\r\\n  color: #000e2f;\\r\\n  border-color: #000e2f transparent transparent transparent;\\r\\n  border-width: 12px 12px 0;\\n}\\n.multiselect__option--highlight {\\r\\n  color: #fff;\\r\\n  background-color: #000e2f;\\n}\\n.multiselect__tags {\\r\\n  border: 2px solid #000e2f;\\r\\n  border-radius: 0;\\n}\\n.multiselect__placeholder {\\r\\n  color: #000e2f;\\n}\\r\\n\", \"\"]);\n\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/PersonCard.vue?vue&type=template&id=4898b751&":
/*!*******************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/PersonCard.vue?vue&type=template&id=4898b751& ***!
  \*******************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"router-link\",\n    {\n      staticClass:\n        \"flex-1 flex cursor-pointer bg-white border border-gray-200 hover:bg-gray-200\",\n      attrs: { to: { name: \"person\", params: { id: _vm.person.id } } }\n    },\n    [\n      _c(\n        \"div\",\n        {\n          staticClass: \"block w-full shadow-md mr-4\",\n          style: _vm.styles.background\n        },\n        [\n          _vm.directoryphoto\n            ? _c(\"div\", { staticClass: \"block\" }, [\n                _vm.image\n                  ? _c(\"img\", {\n                      staticClass: \"w-full object-contain\",\n                      attrs: { src: _vm.image.url }\n                    })\n                  : _c(\"img\", {\n                      attrs: { src: \"/uploads/people/photos/GenericAvatar.jpg\" }\n                    })\n              ])\n            : _vm._e(),\n          _vm._v(\" \"),\n          _c(\"div\", { staticClass: \"block px-4 pt-4 pb-2\" }, [\n            _c(\n              \"h2\",\n              {\n                staticClass: \"font-bold text-base cursor-pointer uppercase\",\n                style: _vm.styles.title\n              },\n              [\n                _vm._v(\n                  \"\\n        \" +\n                    _vm._s(_vm.person.personFirstName) +\n                    \"\\n        \" +\n                    _vm._s(_vm.person.personLastName) +\n                    \"\\n      \"\n                )\n              ]\n            )\n          ]),\n          _vm._v(\" \"),\n          _c(\n            \"div\",\n            { staticClass: \" block w-full px-4 pb-4 overflow-x-hidden\" },\n            [\n              _vm.role.title\n                ? _c(\"p\", { staticClass: \"text-base cursor-pointer\" }, [\n                    _vm._v(_vm._s(_vm.role.title))\n                  ])\n                : _vm._e(),\n              _vm._v(\" \"),\n              _vm.role.department\n                ? _c(\"p\", { staticClass: \"text-base cursor-pointer\" }, [\n                    _vm._v(\n                      \"\\n        \" + _vm._s(_vm.role.department) + \"\\n      \"\n                    )\n                  ])\n                : _vm._e(),\n              _vm._v(\" \"),\n              _vm.role.building\n                ? _c(\"p\", { staticClass: \"text-base cursor-pointer\" }, [\n                    _vm._v(\n                      \"\\n        \" + _vm._s(_vm.role.building) + \"\\n      \"\n                    )\n                  ])\n                : _vm._e(),\n              _vm._v(\" \"),\n              _vm.role.building\n                ? _c(\"p\", { staticClass: \"text-base cursor-pointer\" }, [\n                    _vm._v(\"\\n        \" + _vm._s(_vm.role.suite) + \"\\n      \")\n                  ])\n                : _vm._e()\n            ]\n          )\n        ]\n      )\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/components/PersonCard.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&":
/*!****************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a& ***!
  \****************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\n    \"content-loader\",\n    {\n      attrs: {\n        loaded: _vm.loaded.people && _vm.loaded.departments,\n        classes: \"flex flex-wrap p-16\"\n      }\n    },\n    [\n      _c(\n        \"div\",\n        { staticClass: \"pb-4\" },\n        [\n          _c(\"page-header\", { staticClass: \"uppercase\" }, [_vm._v(\"Directory\")])\n        ],\n        1\n      ),\n      _vm._v(\" \"),\n      !this.people.length\n        ? _c(\n            \"div\",\n            {\n              staticClass: \"flex-1 flex items-center justify-center\",\n              staticStyle: { height: \"65vh\" }\n            },\n            [\n              _c(\"h1\", { staticClass: \"font-thin text-4xl text-center\" }, [\n                _vm._v(\n                  \"\\n      We did not find anyone matching your criteria.\\n    \"\n                )\n              ])\n            ]\n          )\n        : _c(\n            \"div\",\n            {\n              staticClass: \"w-full overflow-y-scroll overflow-x-hidden\",\n              staticStyle: { height: \"60vh\" }\n            },\n            [\n              _c(\n                \"div\",\n                { staticClass: \"flex flex-wrap\" },\n                _vm._l(_vm.people, function(person) {\n                  return _c(\n                    \"div\",\n                    {\n                      key: person.id,\n                      staticClass:\n                        \"w-1/2 max-h-screen sm:w-1/3 md:w-1/4 xl:w-1/6 lg:w-1/4 flex my-2 px-0\"\n                    },\n                    [_c(\"person-card\", { attrs: { person: person } })],\n                    1\n                  )\n                }),\n                0\n              )\n            ]\n          ),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"w-full flex pt-6\" }, [\n        _c(\n          \"div\",\n          { staticClass: \"flex w-1/3 h-12 mt-1 mr-2 pr-8\" },\n          [\n            _c(\"multi-select\", {\n              attrs: {\n                \"track-by\": \"title\",\n                label: \"title\",\n                placeholder: \"Filter by Department\",\n                options: _vm.departments,\n                \"show-labels\": false,\n                \"allow-empty\": true\n              },\n              on: { input: _vm.fetchPeople },\n              model: {\n                value: _vm.filters.department,\n                callback: function($$v) {\n                  _vm.$set(_vm.filters, \"department\", $$v)\n                },\n                expression: \"filters.department\"\n              }\n            })\n          ],\n          1\n        ),\n        _vm._v(\" \"),\n        _vm.filters.department\n          ? _c(\n              \"div\",\n              { staticClass: \"flex w-1/3 h-12 mt-1 mr-2 px-8\" },\n              [\n                _c(\"multi-select\", {\n                  attrs: {\n                    placeholder: \"Filter by Last Initial\",\n                    options: _vm.alphabet(),\n                    \"show-labels\": false,\n                    \"allow-empty\": true\n                  },\n                  on: { input: _vm.fetchPeople },\n                  model: {\n                    value: _vm.filters.letter,\n                    callback: function($$v) {\n                      _vm.$set(_vm.filters, \"letter\", $$v)\n                    },\n                    expression: \"filters.letter\"\n                  }\n                })\n              ],\n              1\n            )\n          : _vm._e()\n      ]),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"pt-2\" }, [\n        _vm._v(\"\\n    Don’t see what you’re looking for?\\n    \"),\n        _c(\n          \"a\",\n          {\n            staticClass: \"cursor-pointer underline\",\n            style: _vm.styles.defaultColor,\n            on: {\n              click: function() {\n                return (_vm.$store.state.app.searchIsOpen = true)\n              }\n            }\n          },\n          [_vm._v(\"Switch to SEARCH\")]\n        )\n      ])\n    ]\n  )\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&":
/*!*********************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css& ***!
  \*********************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("// style-loader: Adds some css to the DOM by adding a <style> tag\n\n// load the styles\nvar content = __webpack_require__(/*! !../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&\");\nif(typeof content === 'string') content = [[module.i, content, '']];\nif(content.locals) module.exports = content.locals;\n// add the styles to the DOM\nvar add = __webpack_require__(/*! ../../../../node_modules/vue-style-loader/lib/addStylesClient.js */ \"./node_modules/vue-style-loader/lib/addStylesClient.js\").default\nvar update = add(\"f6aa2c96\", content, false, {});\n// Hot Module Replacement\nif(false) {}\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

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
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Index.vue?vue&type=template&id=4f88849a& */ \"./src/js/pages/people/Index.vue?vue&type=template&id=4f88849a&\");\n/* harmony import */ var _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Index.vue?vue&type=script&lang=js& */ \"./src/js/pages/people/Index.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./Index.vue?vue&type=style&index=0&lang=css& */ \"./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__[\"default\"])(\n  _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Index_vue_vue_type_template_id_4f88849a___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/people/Index.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?");

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

/***/ "./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&":
/*!************************************************************************!*\
  !*** ./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css& ***!
  \************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-style-loader!../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/people/Index.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default.a); \n\n//# sourceURL=webpack:///./src/js/pages/people/Index.vue?");

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