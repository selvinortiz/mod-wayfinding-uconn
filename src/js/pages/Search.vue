<template>
  <div class="p-4">
    <div class="mx-auto" style="display: grid; grid-template-rows: 1fr 1fr; max-width: 720px;">
      <section>
        <div v-if="results.length" class="animated slideInDown">
          <mod-page-header>Results</mod-page-header>
          <div class="flex flex-wrap -mx-2 lg:-mx-4">
            <div
              class="w-full lg:w-1/2 xl:w-1/3 flex my-2 px-2 lg:my-4 lg:px-4"
              v-for="result in results"
              :key="result.id"
            >
              <router-link
                class="flex-1 p-4 border border-gray-300 bg-gray-100 rounded"
                :to="{name: 'person', params: {id: result.id}}"
              >
                <p class="font-thin text-xl">{{ result.title }}</p>
              </router-link>
            </div>
          </div>
        </div>
      </section>

      <section>
        <mod-page-header>Search</mod-page-header>
        <div class="flex items-center my-4 border border-gray-200 animated fadeIn">
          <select v-model="context" class="bg-transparent outline-none focus:outline-none">
            <option value>All</option>
            <option value="people">People</option>
            <option value="places">Places</option>
            <option value="building">Buildings</option>
          </select>
          <input
            type="text"
            class="py-2 px-2 outline-none"
            placeholder="Type to search..."
            style="flex: 6;"
            v-model="input"
            @keydown.enter="search"
          />
          <button
            class="py-2 border-l border-gray-200 bg-gray-100 outline-none hover:bg-gray-200 focus:bg-gray-300 focus:outline-none"
            style="flex: 2"
            @click="search"
          >Search</button>
        </div>

        <mod-keyboard
          v-if="showKeyboard"
          animatedClass="slideInUp"
          keyboardClass="keyboard--numeric"
          @change="handleKeyboardChange"
          @click="handleKeyboardClick"
          :input="input"
        ></mod-keyboard>
      </section>
    </div>
  </div>
</template>

<script>
import axios from "../utils/Axios";
import ModKeyboard from "../components/shared/ModKeyboard.vue";

export default {
  metaInfo: {
    title: "Search"
  },
  data() {
    return {
      input: "",
      context: "",
      searching: false,
      results: [],
      searchErrorMessage: "",
      showKeyboard: !("ontouchstart" in document.documentElement),
      keyboardLayout: ["1 2 3", "4 5 6", "7 8 9", "0 {tab}"],
      keyboardButtonLabels: {
        "{space}": "Space",
        "{bksp}": "⇤",
        "{enter}": "Enter",
        "{cancel}": "Cancel",
        "{lock}": "Caps",
        "{tab}": "Next",
        "{shift}": "123"
      }
    };
  },
  components: {
    ModKeyboard
  },
  methods: {
    search() {
      this.searching = true;

      axios
        .post("/actions/sys/search", {
          searchQuery: this.input,
          searchContext: this.context
        })
        .then(response => {
          if (response.data.success) {
            this.results = response.data.results;
          } else {
            this.searchErrorMessage = response.data.message;
          }

          this.searching = false;
        })
        .catch(error => console.error(error));
    },
    handleKeyboardChange(input) {
      console.log("Input changed", input);
      this.input = input;
    },
    handleKeyboardClick(button) {
      console.log("Button clicked", button);
      switch (button) {
        case "{enter}":
          this.search();
          break;
        case "{clear}":
          this.input = "";
          break;

        // Added for parent interaction
        case "{cancel}":
          this.$parent.searchIsOpen = false;
          break;
          
        default:
          console.log(button);
          break;
      }
    }
  }
};
</script>
