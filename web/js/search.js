(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["search"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=script&lang=js&":
/*!********************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/Search.vue?vue&type=script&lang=js& ***!
  \********************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _components_shared_ModKeyboard_vue__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../components/shared/ModKeyboard.vue */ \"./src/js/components/shared/ModKeyboard.vue\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Search\"\n  },\n\n  data() {\n    return {\n      input: \"\",\n      showKeyboard: !('ontouchstart' in document.documentElement),\n      keyboardLayout: [\"{tab} q w e r t y u i o p [ ] \\\\\", \"{lock} a s d f g h j k l ; ' {enter}\", \"{shift} z x c v b n m , . / {shift}\", \".com @ {space}\"]\n    };\n  },\n\n  components: {\n    ModKeyboard: _components_shared_ModKeyboard_vue__WEBPACK_IMPORTED_MODULE_0__[\"default\"]\n  },\n  methods: {\n    search() {\n      console.log(this.input);\n    },\n\n    handleKeyboardChange(input) {\n      this.input = input;\n    },\n\n    handleKeyboardClick(button) {\n      switch (button) {\n        case \"{enter}\":\n          this.search();\n          break;\n\n        case \"{clear}\":\n          this.input = \"\";\n          break;\n\n        default:\n          console.log(button);\n          break;\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/Search.vue?vue&type=template&id=3fb76e30&":
/*!**********************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/Search.vue?vue&type=template&id=3fb76e30& ***!
  \**********************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\"div\", { staticClass: \"p-4\" }, [\n    _c(\n      \"div\",\n      { staticClass: \"mx-auto\", staticStyle: { \"max-width\": \"640px\" } },\n      [\n        _c(\"mod-page-header\", [_vm._v(\"Search\")]),\n        _vm._v(\" \"),\n        _c(\n          \"div\",\n          {\n            staticClass:\n              \"flex items-center my-4 border border-gray-200 animated fadeIn\"\n          },\n          [\n            _c(\"input\", {\n              directives: [\n                {\n                  name: \"model\",\n                  rawName: \"v-model\",\n                  value: _vm.input,\n                  expression: \"input\"\n                }\n              ],\n              staticClass: \"py-2 px-2 outline-none\",\n              staticStyle: { flex: \"6\" },\n              attrs: { placeholder: \"Type to search...\", type: \"text\" },\n              domProps: { value: _vm.input },\n              on: {\n                input: function($event) {\n                  if ($event.target.composing) {\n                    return\n                  }\n                  _vm.input = $event.target.value\n                }\n              }\n            }),\n            _vm._v(\" \"),\n            _c(\n              \"button\",\n              {\n                staticClass:\n                  \"py-2 border-l border-gray-200 bg-gray-100 outline-none hover:bg-gray-200 focus:bg-gray-300 focus:outline-none\",\n                staticStyle: { flex: \"2\" },\n                on: { click: _vm.search }\n              },\n              [_vm._v(\"Search\")]\n            )\n          ]\n        ),\n        _vm._v(\" \"),\n        _vm.showKeyboard\n          ? _c(\"mod-keyboard\", {\n              attrs: {\n                animatedClass: \"slideInUp\",\n                keyboardClass: \"keyboard--standard\",\n                input: _vm.input\n              },\n              on: {\n                change: _vm.handleKeyboardChange,\n                click: _vm.handleKeyboardClick\n              }\n            })\n          : _vm._e()\n      ],\n      1\n    )\n  ])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/Search.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

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

/***/ })

}]);