<template>
  <div class="p-4">
    <div class="mx-auto" style="max-width: 640px;">
      <mod-page-header>Search</mod-page-header>
      <div class="flex items-center my-4 border border-gray-200 animated fadeIn">
        <input
          class="py-2 px-2 outline-none"
          placeholder="Type to search..."
          style="flex: 6;"
          v-model="input"
          type="text"
        />
        <button class="py-2 border-l border-gray-200 bg-gray-100 outline-none hover:bg-gray-200 focus:bg-gray-300 focus:outline-none" style="flex: 2" @click="search">Search</button>
      </div>

      <mod-keyboard
        v-if="showKeyboard"
        animatedClass="slideInUp"
        keyboardClass="full-keyboard"
        @change="handleKeyboardChange"
        @click="handleKeyboardClick"
        :input="input"
      ></mod-keyboard>
    </div>
  </div>
</template>

<script>
import ModKeyboard from "../components/shared/ModKeyboard.vue";

export default {
  metaInfo: {
    title: "Search"
  },
  data() {
    return {
      input: "",
      showKeyboard: !('ontouchstart' in document.documentElement),
    };
  },
  components: {
    ModKeyboard
  },
  methods: {
    search() {
      console.log(this.input);
    },
    handleKeyboardChange(input) {
      this.input = input
    },
    handleKeyboardClick(button) {
      switch (button) {
        case "{enter}":
          this.search();
          break;
        case "{clear}":
          this.input = ""
          break;
        default:
          console.log(button);
          break;
      }
    }
  }
};
</script>
