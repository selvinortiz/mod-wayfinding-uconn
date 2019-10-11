(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["room"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _utils_Axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../utils/Axios */ \"./src/js/utils/Axios.js\");\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  name: 'room',\n  metaInfo: {\n    title: \"Place\"\n  },\n\n  data() {\n    return {\n      place: {\n        id: 0,\n        type: {\n          name: \"\"\n        },\n        loaded: false,\n        ancestors: []\n      }\n    };\n  },\n\n  created() {\n    this.fetch();\n  },\n\n  computed: {\n    maps() {\n      return this.place.maps || [];\n    },\n\n    theme() {\n      return this.$store.state.app.theme;\n    },\n\n    photo() {\n      if (this.building && this.building.roomPhoto && this.building.roomPhoto.length) {\n        return this.building.roomPhoto[0];\n      }\n\n      return {\n        url: \"\",\n        width: 0,\n        height: 0\n      };\n    },\n\n    kiosk() {\n      return this.$store.state.app.kiosk || {\n        id: null\n      };\n    },\n\n    floor() {\n      return this.place.ancestors[0] || {};\n    },\n\n    building() {\n      return this.place.ancestors[1] || {};\n    },\n\n    campus() {\n      return this.place.ancestors[2] || {};\n    },\n\n    options() {\n      if (!this.building || !this.building.descendants) {\n        return [];\n      }\n\n      return this.building.descendants.map(item => {\n        if (item.type.handle === \"floor\") {\n          item[\"$isDisabled\"] = true;\n        }\n\n        return item;\n      });\n    },\n\n    styles() {\n      return {\n        defaultColor: [`color: ${this.theme.colors.primary}`].join(\";\")\n      };\n    }\n\n  },\n  methods: {\n    fetch() {\n      const id = this.$route.params.id;\n      const locationId = this.kiosk.id;\n      _utils_Axios__WEBPACK_IMPORTED_MODULE_0__[\"default\"].post(\"/actions/sys/wayfinding/place\", {\n        id,\n        locationId\n      }).then(response => {\n        this.place = { ...response.data.place,\n          loaded: true\n        };\n      }).catch(error => console.error(error));\n    },\n\n    handleSelectedPlace(place) {\n      if (place && place.id) {\n        this.$router.push({\n          name: \"room\",\n          params: {\n            id: place.id\n          }\n        });\n      }\n    }\n\n  },\n  watch: {\n    $route(to) {\n      if (to.name === \"room\" && this.$route.params.id != this.place.id) {\n        this.place = {\n          id: 0,\n          loaded: false,\n          ancestors: []\n        };\n        this.fetch();\n      }\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&":
/*!*************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css& ***!
  \*************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("exports = module.exports = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ \"./node_modules/css-loader/dist/runtime/api.js\")(false);\n// Module\nexports.push([module.i, \"\\n.multiselect__select:before {\\r\\n  top: 80%;\\r\\n  color: #000e2f;\\r\\n  border-color: #000e2f transparent transparent transparent;\\r\\n  border-width: 12px 12px 0;\\n}\\n.multiselect__option--highlight {\\r\\n  color: #fff;\\r\\n  background-color: #000e2f;\\n}\\n.multiselect__tags {\\r\\n  border: 2px solid #000e2f;\\r\\n  border-radius: 0;\\n}\\n.multiselect__placeholder {\\r\\n  color: #000e2f;\\n}\\r\\n\", \"\"]);\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&":
/*!****************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982& ***!
  \****************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function () {}\nvar staticRenderFns = []\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&":
/*!*********************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css& ***!
  \*********************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("// style-loader: Adds some css to the DOM by adding a <style> tag\n\n// load the styles\nvar content = __webpack_require__(/*! !../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&\");\nif(typeof content === 'string') content = [[module.i, content, '']];\nif(content.locals) module.exports = content.locals;\n// add the styles to the DOM\nvar add = __webpack_require__(/*! ../../../../node_modules/vue-style-loader/lib/addStylesClient.js */ \"./node_modules/vue-style-loader/lib/addStylesClient.js\").default\nvar update = add(\"1cc71f9c\", content, false, {});\n// Hot Module Replacement\nif(false) {}\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?./node_modules/vue-style-loader!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue":
/*!***************************************!*\
  !*** ./src/js/pages/places/_Room.vue ***!
  \***************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./_Room.vue?vue&type=template&id=17fe1982& */ \"./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&\");\n/* harmony import */ var _Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./_Room.vue?vue&type=script&lang=js& */ \"./src/js/pages/places/_Room.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./_Room.vue?vue&type=style&index=0&lang=css& */ \"./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__[\"default\"])(\n  _Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/pages/places/_Room.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue?vue&type=script&lang=js&":
/*!****************************************************************!*\
  !*** ./src/js/pages/places/_Room.vue?vue&type=script&lang=js& ***!
  \****************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&":
/*!************************************************************************!*\
  !*** ./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css& ***!
  \************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-style-loader!../../../../node_modules/css-loader/dist/cjs.js!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=style&index=0&lang=css& */ \"./node_modules/vue-style-loader/index.js!./node_modules/css-loader/dist/cjs.js!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=style&index=0&lang=css&\");\n/* harmony import */ var _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_vue_style_loader_index_js_node_modules_css_loader_dist_cjs_js_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default.a); \n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ }),

/***/ "./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&":
/*!**********************************************************************!*\
  !*** ./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982& ***!
  \**********************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./_Room.vue?vue&type=template&id=17fe1982& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/pages/places/_Room.vue?vue&type=template&id=17fe1982&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Room_vue_vue_type_template_id_17fe1982___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/pages/places/_Room.vue?");

/***/ })

}]);