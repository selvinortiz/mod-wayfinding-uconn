<template>
  <div class="p-4">
    <div class="mx-auto" style="display: grid; grid-template-rows: 1fr 1fr; max-width: 50%; height: 100vh">
      <section>
        <div v-if="results.length" class="animated slideInDown overflow-y-scroll overflow-x-hidden" style="max-height: 50vh">
          <mod-page-header>Results</mod-page-header>
          <div class="flex flex-wrap -mx-2 lg:-mx-4">
            <router-link
              class="block w-full lg:w-1/2 xl:w-1/3 flex my-2 px-2 lg:my-4 lg:px-4"
              v-for="result in results"
              :key="result.id"
              :to="{name: 'person', params: {id: result.id}}"
            >
              <div class="flex-1 p-4 border border-gray-300 bg-white rounded">
                <p class="font-thin text-xl">{{ result.title }}</p>
              </div>
            </router-link>
          </div>
        </div>
      </section>

      <section>
        <mod-page-header>Search</mod-page-header>
        <div class="flex items-center my-4 border border-gray-200 bg-gray-100 animated fadeIn">
          <select v-model="context" class="bg-transparent outline-none focus:outline-none">
            <option value>All</option>
            <option value="people">People</option>
            <option value="places">Places</option>
            <option value="building">Buildings</option>
          </select>
          <input
            type="text"
            class="py-2 px-2 bg-white outline-none"
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
          keyboardClass="keyboard--standard"
          :keyboardButtonLabels="keyboardButtonLabels"
          @change="handleKeyboardChange"
          @click="handleKeyboardClick"
          :input="input"
        ></mod-keyboard>
      </section>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModKeyboard from "../shared/ModKeyboard.vue";

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
      keyboardButtonLabels: {
        "{space}": "Space",
        "{bksp}": "⇤",
        "{enter}": "Enter",
        "{cancel}": "Close",
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
            console.log(this.results);
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
          this.$store.state.app.searchIsOpen = false;
          break;

        default:
          console.log(button);
          break;
      }
    }
  }
};
</script>
