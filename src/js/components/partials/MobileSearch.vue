<template>
  <div class="px-8 xl:py-8 lg:pt-64 md:pt-64 sm:pt-64 ">
    <div
      class="mx-auto"
      style="display: grid; grid-template-rows: 1fr 1fr; row-gap:1.5em; max-width: 75%; height: 100vh"
    >
      <section class="relative @search__results">
        <div v-if="this.noReturn && !this.results.length > 0">
          <h1 class="font-thin text-4xl m-auto text-center text-white">We did not find anything matching your criteria.</h1>
        </div>
        <div
          v-if="results.length"
          class="animated slideInDown absolute inset-x-0 bottom-0 pr-4 pb-6 overflow-y-auto"
          style="max-height: 50vh"
        >
          <h2 class="font-thin text-2xl uppercase text-white">Results</h2>
          <!-- pulls in search cards -->
          <div class="flex flex-wrap ">
            <div
              class="flex w-auto sm:w-1/2 md:w-1/3 xl:w-1/4 lg:w-1/3"
              v-for="result in results"
              :key="result.id"
            >
              <search-card :results="result"></search-card>
            </div>
          </div>
        </div>
      </section>

      <section class="animated fadeIn @search" :style="styles.search">
        <h2 class="font-thin text-2xl uppercase text-white opacity-75">Search People and Places</h2>
        <div class="flex items-center my-4" :style="styles.searchControls">
          <input
            type="text"
            class="py-2 px-2 bg-white text-blue-800 outline-none"
            placeholder="Type to search..."
            style="flex: 6;"
            v-model="input"
            @keydown.enter="search"
          />
        </div>
      </section>
    </div>
  </div>
</template>

<script>
import axios from "../../utils/Axios";
import ModKeyboard from "../ModKeyboard.vue";
import SearchCard from "../SearchCard.vue";

export default {
  metaInfo: {
    title: "Search"
  },
  data() {
    return {
      input: "",
      context: "",
      searching: false,
      noReturn: false,
      results: [],
      searchErrorMessage: "",
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
    ModKeyboard,
    SearchCard
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return {
        search: [`color: #fff`]
          .concat(this.theme.search.styles || [])
          .join(";"),
        searchControls: [`background-color: ${this.theme.colors.primary}`].join(
          ";"
        ),
        defaultColor: [`color: ${this.theme.colors.primary}`].join(";"),
        keyboard: `color: #111`,
        keyboardContainer: ""
      };
    }
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
          if (this.results.length < 1)
          {
            console.log("If statement running")
            this.noReturn = true;
          } else {
            this.noReturn = false;
          }
          console.log(this.results.length)
          this.searching = false;
        })
        .catch(error => console.error(error));
    },
    failedSearch() {
      this.noReturn = true
    },
    handleKeyboardChange(input) {
      this.input = input;
    },
    handleKeyboardClick(button) {
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
