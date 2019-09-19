<template>
  <div class="p-8">
    <div class="mx-auto" style="display: grid; grid-template-rows: 1fr 1fr; max-width: 65%; height: 100vh">
      <section class="@search__results">
        <div v-if="results.length" class="animated slideInDown overflow-y-scroll overflow-x-hidden" style="max-height: 50vh">
          <h2 class="font-thin text-2xl uppercase text-white">Results</h2>
          <div class="flex flex-wrap -mx-2 lg:-mx-4">
            <a
              class="block w-full lg:w-1/2 xl:w-1/3 flex my-2 px-2 lg:my-4 lg:px-4"
              v-for="result in results"
              :key="result.id"
              @click.prevent="navigate(result, $event)"
            >
              <div class="flex-1 p-4 border border-gray-300 bg-white rounded">
                <p class="font-thin text-xl">{{ result.title }}</p>
              </div>
            </a>
          </div>
        </div>
      </section>

      <section class="animated fadeIn @search" :style="styles.search">
        <h2 class="font-thin text-2xl uppercase text-white">Search</h2>
        <div class="flex items-center my-4" :style="styles.searchControls">
          <select v-model="context" class="bg-transparent outline-none focus:outline-none">
            <option value>All</option>
            <option value="people">People</option>
            <option value="places">Places</option>
            <option value="building">Buildings</option>
          </select>
          <input
            type="text"
            class="py-2 px-2 bg-white text-blue-800 outline-none"
            placeholder="Type to search..."
            style="flex: 6;"
            v-model="input"
            @keydown.enter="search"
          />
          <ui-button :loading="searching" style="flex: 2;" @click="search">Search</ui-button>
        </div>

        <mod-keyboard
          v-if="true"
          animatedClass="slideInUp"
          keyboardClass="keyboard--standard"
          :keyboardStyles="styles.keyboard"
          :keyboardContainerStyles="styles.keyboardContainer"
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
  computed: {
    theme() {
      return this.$store.state.app.theme
    },
    styles() {
      return {
        search: [
          `color: #fff`
        ].concat(this.theme.search.styles || []).join(";"),
        searchControls: [
          `background-color: ${this.theme.colors.primary}`
        ].join(";"),
        keyboard: `color: #111`,
        keyboardContainer: '',
      }
    },
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
    },
    navigate(place, event) {
      console.log(place, event)
      this.$store.commit('setSearchIsOpen', false)
      this.$nextTick(() => {
        this.$router.push({name: 'person', params: {id: place.id} })
      })
    }
  }
};
</script>
