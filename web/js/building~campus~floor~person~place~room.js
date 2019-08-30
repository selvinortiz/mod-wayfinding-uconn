(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["building~campus~floor~person~place~room"],{

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/ModMap.vue?vue&type=script&lang=js&":
/*!********************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/shared/ModMap.vue?vue&type=script&lang=js& ***!
  \********************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  props: {\n    place: {\n      type: Object,\n      default: () => ({\n        id: 0,\n        title: '',\n        maps: [{\n          image: ''\n        }, {\n          markers: [{\n            width: 0,\n            height: 0,\n            x: 0,\n            xr: 0,\n            y: 0,\n            yr: 0\n          }]\n        }],\n        loaded: false\n      })\n    }\n  },\n\n  data() {\n    return {\n      defaultedToCenter: false,\n      zoom: 1,\n      zoomFactor: 0.5,\n      translateX: 0,\n      translateY: 0,\n      drag: false,\n      dragX: null,\n      dragY: null,\n      selectedMap: null,\n      primaryColor: this.$store.state.app.theme.main.modMap.text\n    };\n  },\n\n  methods: {\n    centerMap() {\n      // Only run this part once at the start\n      if (!this.defaultedToCenter) {\n        console.log(this.primaryColor); // Gather the smallest and largest cords for\n        // finding the area encompassing all the markers\n\n        var smallX = null,\n            bigX = null,\n            smallY = null,\n            bigY = null;\n\n        for (var ii = 0; ii < this.selectedMap.markers.length; ii++) {\n          var marker = this.selectedMap.markers[ii];\n          smallX == null || smallX > marker.xr ? smallX = marker.xr : null;\n          bigX == null || bigX < marker.xr ? bigX = marker.xr : null;\n          smallY == null || smallY > marker.yr ? smallY = marker.yr : null;\n          bigY == null || bigY < marker.yr ? bigY = marker.yr : null;\n        } // Use the relational amounts to convert to the cords for the new sized image\n\n\n        var image = document.getElementById(\"image\").getBoundingClientRect(); //console.log(image);\n\n        smallX = smallX / 100 * image.width;\n        bigX = bigX / 100 * image.width;\n        smallY = smallY / 100 * image.height;\n        bigY = bigY / 100 * image.height; //console.log([smallX, bigY, bigX - smallX, bigY - smallY]);\n        // Correct for the default xy of the image on page\n\n        smallX += image.x;\n        bigX += image.x;\n        smallY += image.y;\n        bigY += image.y; // Find the difference between the center of the marker encompassing area and the\n        // center of the imageContainer to then translate the image to shair the same center\n\n        var imageContainer = document.getElementById(\"imageContainer\").getBoundingClientRect(); //console.log(imageContainer);\n\n        var imageContainerCenterX = imageContainer.x + imageContainer.width / 2;\n        var imageContainerCenterY = imageContainer.y + imageContainer.height / 2;\n        var markerAreaCenterX = smallX + (bigX - smallX) / 2;\n        var markerAreaCenterY = smallY + (bigY - smallY) / 2; //console.log(imageContainerCenterX + \"  \" + imageContainerCenterY);\n        //console.log(markerAreaCenterX + \"  \" + markerAreaCenterY);\n        //console.log(markerAreaCenterX - imageContainerCenterX + \"  \" + (markerAreaCenterY - imageContainerCenterY));\n\n        this.translateX = -(markerAreaCenterX - imageContainerCenterX);\n        this.translateY = -(markerAreaCenterY - imageContainerCenterY);\n      }\n    },\n\n    getSelectedMap() {\n      if (this.selectedMap == null) this.selectedMap = this.place.maps[0];\n      return this.selectedMap;\n    },\n\n    zoomMap(direction) {\n      this.zoom + this.zoomFactor * direction < 4 && this.zoom + this.zoomFactor * direction >= 1 ? this.zoom += this.zoomFactor * direction : null; // Direct the map back into covering the view port when zooming out near a boundary\n\n      /*\r\n      if (direction == -1) {\r\n        var imageContainer = document.getElementById('imageContainer').getBoundingClientRect();\r\n        var image = document.getElementById('image').getBoundingClientRect();\r\n          if (image.x > imageContainer.x)\r\n          image.x = imageContainer.x;\r\n          if (image.y > imageContainer.y)\r\n          image.y = imageContainer.y;\r\n          this.translateX = 0;\r\n        this.translateY = 0;\r\n      }\r\n      */\n    },\n\n    startDrag(event) {\n      this.drag = true;\n      this.dragX = event.x;\n      this.dragY = event.y;\n    },\n\n    dragMap(event) {\n      if (this.drag) {\n        var diffX = event.x - this.dragX;\n        var diffY = event.y - this.dragY; // Limit the movement of the map to the bounds of the map\n\n        /*\r\n        var imageContainer = document.getElementById('imageContainer').getBoundingClientRect();\r\n        var image = document.getElementById('image').getBoundingClientRect();\r\n          if (diffX > 0)\r\n          image.x + diffX <= imageContainer.x ? (this.translateX += diffX) : null;\r\n        else if (diffX < 0)\r\n          image.x + image.width >= imageContainer.x + imageContainer.width ? (this.translateX += diffX) : null;\r\n          if (diffY > 0)\r\n          image.y + diffY <= imageContainer.y ? (this.translateY += diffY) : null;\r\n        else if (diffY < 0)\r\n          image.y + image.height >= imageContainer.y + imageContainer.height ? (this.translateY += diffY) : null;\r\n        */\n\n        this.translateX += diffX;\n        this.translateY += diffY;\n        this.dragX = event.x;\n        this.dragY = event.y;\n      }\n    },\n\n    stopDrag() {\n      this.drag = false;\n    }\n\n  }\n});\n\n//# sourceURL=webpack:///./src/js/components/shared/ModMap.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js&":
/*!*******************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js& ***!
  \*******************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  props: {\n    heading: {\n      type: String,\n      default: null\n    },\n    classes: {\n      type: String,\n      default: null\n    }\n  },\n\n  data() {\n    return {\n      primaryColor: this.$store.state.app.theme.main.peoplePlaceHeader.text\n    };\n  }\n\n});\n\n//# sourceURL=webpack:///./src/js/components/shared/PeoplePlaceHeader.vue?./node_modules/babel-loader/lib!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108&":
/*!**********************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108& ***!
  \**********************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\"div\", { staticClass: \"w-full md:px-4\" }, [\n    _c(\n      \"div\",\n      {\n        staticClass: \"overflow-hidden relative mb-4\",\n        staticStyle: { height: \"50vh\", outline: \"1px gray solid\" },\n        attrs: { id: \"imageContainer\" },\n        on: {\n          mousedown: function($event) {\n            return _vm.startDrag($event)\n          },\n          mousemove: function($event) {\n            return _vm.dragMap($event)\n          },\n          mouseup: function($event) {\n            return _vm.stopDrag()\n          },\n          mouseleave: function($event) {\n            return _vm.stopDrag()\n          }\n        }\n      },\n      [\n        _vm.place.loaded\n          ? _c(\"img\", {\n              staticClass: \"w-full\",\n              style: {\n                transform:\n                  \"scale(\" +\n                  _vm.zoom +\n                  \") translate(\" +\n                  (_vm.translateX + \"px\") +\n                  \", \" +\n                  (_vm.translateY + \"px\") +\n                  \")\"\n              },\n              attrs: {\n                id: \"image\",\n                src: _vm.getSelectedMap().image,\n                draggable: \"false\"\n              },\n              on: {\n                load: function($event) {\n                  return _vm.centerMap()\n                }\n              }\n            })\n          : _vm._e(),\n        _vm._v(\" \"),\n        _vm.place.loaded\n          ? _c(\n              \"div\",\n              { staticClass: \"w-1/6 absolute bottom-0 right-0\" },\n              _vm._l(_vm.place.maps, function(map, index) {\n                return _c(\"img\", {\n                  key: index,\n                  staticClass: \"w-full\",\n                  attrs: { src: map.image, draggable: \"false\" },\n                  on: {\n                    click: function() {\n                      return (_vm.selectedMap = map)\n                    }\n                  }\n                })\n              }),\n              0\n            )\n          : _vm._e()\n      ]\n    ),\n    _vm._v(\" \"),\n    _c(\"div\", { staticClass: \"flex w-full justify-start\" }, [\n      _c(\n        \"button\",\n        {\n          class:\n            \"flex w-1/4 justify-center mr-4 bg-transparent \" +\n            \"font-semibold hover:text-white py-2 px-4 border hover:border-transparent \" +\n            \"hover:bg-\" +\n            _vm.primaryColor +\n            \" text-\" +\n            _vm.primaryColor +\n            \" border-\" +\n            _vm.primaryColor\n        },\n        [_vm._v(\"\\n        Campus Map\\n      \")]\n      ),\n      _vm._v(\" \"),\n      _c(\n        \"button\",\n        {\n          class:\n            \"flex w-1/4 justify-center bg-transparent \" +\n            \"font-semibold hover:text-white py-2 px-4 border hover:border-transparent \" +\n            \"hover:bg-\" +\n            _vm.primaryColor +\n            \" text-\" +\n            _vm.primaryColor +\n            \" border-\" +\n            _vm.primaryColor\n        },\n        [_vm._v(\"\\n        Building Map\\n      \")]\n      ),\n      _vm._v(\" \"),\n      _c(\"div\", { staticClass: \"flex w-1/2 justify-end\" }, [\n        _c(\n          \"button\",\n          {\n            staticClass: \"w-10 mr-2\",\n            on: {\n              click: function($event) {\n                return _vm.zoomMap(1)\n              }\n            }\n          },\n          [_c(\"img\", { attrs: { src: \"http://placehold.it/500\" } })]\n        ),\n        _vm._v(\" \"),\n        _c(\n          \"button\",\n          {\n            staticClass: \"w-10\",\n            on: {\n              click: function($event) {\n                return _vm.zoomMap(-1)\n              }\n            }\n          },\n          [_c(\"img\", { attrs: { src: \"http://placehold.it/500\" } })]\n        )\n      ])\n    ])\n  ])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/components/shared/ModMap.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72&":
/*!*********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72& ***!
  \*********************************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return render; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return staticRenderFns; });\nvar render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c(\"div\", { class: \"w-full flex-wrap pl-4 md:mb-4 \" + _vm.classes }, [\n    _c(\n      \"div\",\n      { class: \"w-full text-3xl text-\" + _vm.primaryColor + \" font-300\" },\n      [_vm._v(_vm._s(_vm.heading))]\n    ),\n    _vm._v(\" \"),\n    _c(\"div\", { class: \"w-full text-1xl text-\" + _vm.primaryColor }, [\n      _vm._v(\n        \"\\n      \" +\n          _vm._s(\"Breadcrumb nav 1\") +\n          \"\\n      >\\n      \" +\n          _vm._s(\"Breadcrumb nav 2\") +\n          \"\\n  \"\n      )\n    ])\n  ])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n\n\n\n//# sourceURL=webpack:///./src/js/components/shared/PeoplePlaceHeader.vue?./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options");

/***/ }),

/***/ "./src/js/components/shared/ModMap.vue":
/*!*********************************************!*\
  !*** ./src/js/components/shared/ModMap.vue ***!
  \*********************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./ModMap.vue?vue&type=template&id=2772c108& */ \"./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108&\");\n/* harmony import */ var _ModMap_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./ModMap.vue?vue&type=script&lang=js& */ \"./src/js/components/shared/ModMap.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _ModMap_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/components/shared/ModMap.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/components/shared/ModMap.vue?");

/***/ }),

/***/ "./src/js/components/shared/ModMap.vue?vue&type=script&lang=js&":
/*!**********************************************************************!*\
  !*** ./src/js/components/shared/ModMap.vue?vue&type=script&lang=js& ***!
  \**********************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_ModMap_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./ModMap.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/ModMap.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_ModMap_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/components/shared/ModMap.vue?");

/***/ }),

/***/ "./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108&":
/*!****************************************************************************!*\
  !*** ./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108& ***!
  \****************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./ModMap.vue?vue&type=template&id=2772c108& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/ModMap.vue?vue&type=template&id=2772c108&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ModMap_vue_vue_type_template_id_2772c108___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/components/shared/ModMap.vue?");

/***/ }),

/***/ "./src/js/components/shared/PeoplePlaceHeader.vue":
/*!********************************************************!*\
  !*** ./src/js/components/shared/PeoplePlaceHeader.vue ***!
  \********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72& */ \"./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72&\");\n/* harmony import */ var _PeoplePlaceHeader_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./PeoplePlaceHeader.vue?vue&type=script&lang=js& */ \"./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ \"./node_modules/vue-loader/lib/runtime/componentNormalizer.js\");\n\n\n\n\n\n/* normalize component */\n\nvar component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _PeoplePlaceHeader_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null\n  \n)\n\n/* hot reload */\nif (false) { var api; }\ncomponent.options.__file = \"src/js/components/shared/PeoplePlaceHeader.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);\n\n//# sourceURL=webpack:///./src/js/components/shared/PeoplePlaceHeader.vue?");

/***/ }),

/***/ "./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js&":
/*!*********************************************************************************!*\
  !*** ./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_PeoplePlaceHeader_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib!../../../../node_modules/vue-loader/lib??vue-loader-options!./PeoplePlaceHeader.vue?vue&type=script&lang=js& */ \"./node_modules/babel-loader/lib/index.js!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=script&lang=js&\");\n/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__[\"default\"] = (_node_modules_babel_loader_lib_index_js_node_modules_vue_loader_lib_index_js_vue_loader_options_PeoplePlaceHeader_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"]); \n\n//# sourceURL=webpack:///./src/js/components/shared/PeoplePlaceHeader.vue?");

/***/ }),

/***/ "./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72&":
/*!***************************************************************************************!*\
  !*** ./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72& ***!
  \***************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72& */ \"./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./src/js/components/shared/PeoplePlaceHeader.vue?vue&type=template&id=17fe7b72&\");\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"render\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__[\"render\"]; });\n\n/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, \"staticRenderFns\", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_PeoplePlaceHeader_vue_vue_type_template_id_17fe7b72___WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"]; });\n\n\n\n//# sourceURL=webpack:///./src/js/components/shared/PeoplePlaceHeader.vue?");

/***/ })

}]);