(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["places"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/Index.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/Index.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\nconst types = {\n  \"4\": \"campus\",\n  \"5\": \"building\",\n  \"6\": \"floor\",\n  \"7\": \"room\"\n};\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  metaInfo: {\n    title: \"Places\"\n  },\n\n  data() {\n    return {\n      places: []\n    };\n  },\n\n  created() {\n    _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/places\").then(response => {\n      if (!response.data.success) {\n        return console.error(response.data.message);\n      }\n\n      this.places = response.data.places;\n      console.log(response.data);\n    }).catch(error => console.error(error));\n  },\n\n  methods: {\n    typeString(typeId) {\n      return types[typeId];\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/Index.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/Index.vue?vue&type=template&id=3c665217&":
/*!****************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/Index.vue?vue&type=template&id=3c665217& ***!
  \****************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _vm.places\n    ? _c(\n        \"div\",\n        { staticClass: \"p-4\" },\n        [\n          _c(\"mod-page-header\", [_vm._v(\"Places\")]),\n          _vm._v(\" \"),\n          _c(\n            \"div\",\n            { staticClass: \"flex flex-wrap -mx-2 lg:-mx-4\" },\n            _vm._l(_vm.places, function(place) {\n              return _c(\n                \"div\",\n                {\n                  key: place.id,\n                  staticClass:\n                    \"w-full md:w-1/2 lg:w-1/3 xl:w-1/4 flex my-2 px-2 lg:my-4 lg:px-4\"\n                },\n                [\n                  _c(\n                    \"router-link\",\n                    {\n                      staticClass:\n                        \"flex-1 p-4 border border-gray-300 bg-gray-100 rounded\",\n                      attrs: { to: { name: \"place\", params: { id: place.id } } }\n                    },\n                    [\n                      _c(\"p\", { staticClass: \"font-thin text-2xl\" }, [\n                        _vm._v(_vm._s(place.title))\n                      ]),\n                      _vm._v(\" \"),\n                      _c(\n                        \"router-link\",\n                        {\n                          staticClass: \"block text-xg text-blue-600\",\n                          attrs: {\n                            to: {\n                              name: _vm.typeString(place.typeId),\n                              params: { id: place.id }\n                            }\n                          }\n                        },\n                        [_vm._v(\"#\" + _vm._s(place.id))]\n                      )\n                    ],\n                    1\n                  )\n                ],\n                1\n              )\n            }),\n            0\n          )\n        ],\n        1\n      )\n    : _vm._e()\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/Index.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/places/Index.vue":
/*!***************************************!*\
  !*** ./src/js/pages/places/Index.vue ***!
  \***************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Index.vue?vue&type=template&id=3c665217& */ \"./src/js/pages/places/Index.vue?vue&type=template&id=3c665217&\");\n/* harmony import */ var _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Index.vue?vue&type=script&lang=js& */ \"./src/js/pages/places/Index.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/places/Index.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/places/Index.vue?");

/***/ }),

/***/ "./src/js/pages/places/Index.vue?vue&type=script&lang=js&":
/*!****************************************************************!*\
  !*** ./src/js/pages/places/Index.vue?vue&type=script&lang=js& ***!
  \****************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/Index.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/places/Index.vue?");

/***/ }),

/***/ "./src/js/pages/places/Index.vue?vue&type=template&id=3c665217&":
/*!**********************************************************************!*\
  !*** ./src/js/pages/places/Index.vue?vue&type=template&id=3c665217& ***!
  \**********************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./Index.vue?vue&type=template&id=3c665217& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/Index.vue?vue&type=template&id=3c665217&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Index_vue_vue_type_template_id_3c665217___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/Index.vue?");

/***/ })

}]);