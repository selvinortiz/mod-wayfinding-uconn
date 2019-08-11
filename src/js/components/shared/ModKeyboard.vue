<template>
  <section id="search__query__keyboard" class="animated">
    <p class="pb-8">
      <input
        ref="inputField"
        :value="value"
        @input="(e) => sync(e.target.value)"
        class="w-full leading-none px-3 tracking-wide text-black py-2 text-4xl bg-white border-4 border-white focus:outline-none focus:border-gray-700"
        :placeholder="placeholder"
      />
    </p>
    <div :class="keyboardClass"></div>
  </section>
</template>

<script>
import SimpleKeyboard from "simple-keyboard";
import "simple-keyboard/build/css/index.css";

/**
 * Default layout config
 *
const layout = {
  'default': [
    '` 1 2 3 4 5 6 7 8 9 0 - = {bksp}',
    '{tab} q w e r t y u i o p [ ] \\',
    '{lock} a s d f g h j k l ; \' {enter}',
    '{shift} z x c v b n m , . / {shift}',
    '.com @ {space}'
  ],
  'shift': [
    '~ ! @ # $ % ^ & * ( ) _ + {bksp}',
    '{tab} Q W E R T Y U I O P { } |',
    '{lock} A S D F G H J K L : " {enter}',
    '{shift} Z X C V B N M < > ? {shift}',
    '.com @ {space}'
  ]
};
 */

const layout = {
  default: [
    "Q W E R T Y U I O P",
    "A S D F G H J K L",
    "Z X C V B N M",
    "{space} {bksp}"
  ]
};

const display = {
  "{space}": "Space",
  "{bksp}": "Back",
  "{enter}": "Enter",
  "{cancel}": "Cancel"
};

const buttonTheme = [
  {
    class: "keyboard-button-back",
    buttons: "{bksp}"
  },
  {
    class: "keyboard-button-enter",
    buttons: "{enter}"
  },
  {
    class: "keyboard-button-space",
    buttons: "{space}"
  },
  {
    class: "keyboard-button-cancel search-close-button",
    buttons: "{cancel}"
  }
];

export default {
  props: {
    placeholder: {
      type: String,
      default: ""
    },
    keyboardClass: {
      type: String,
      required: true,
    }
  },
  data() {
    return {
      value: "",
      keyboard: null
    };
  },
  mounted() {
    this.keyboard = new SimpleKeyboard(`.${this.keyboardClass}`, {
      layout,
      display,
      buttonTheme,
      onChange: this.handleChange,
      onKeyPress: this.handleKeyPress,
      theme: "simple-keyboard hg-theme-default"
    });

    this.$refs.inputField.focus();
  },
  methods: {
    sync(value) {
      this.value = value;
      this.keyboard.setInput(value);

      this.$emit("keyboard-input-sync", value);
    },
    handleInputKeyUp(e) {
      switch (e.key.toLowerCase()) {
        case "escape":
          this.handleEscapeKeyPress();
          break;
        case "shift":
          this.handleShiftKeyPress();
          break;
        case "enter":
          this.handleInputEnterKeyPress(e);
          break;
        default:
          this.sync(e.target.value);
          break;
      }
    },
    handleChange(value) {
      this.sync(value);
    },
    handleKeyPress(button) {
      switch (button) {
        case "{shift}":
          this.handleShiftKeyPress();
          break;
        case "{enter}":
          this.handleInputEnterKeyPress();
          break;
        case "{clear}":
          this.sync("");
          break;
        case "{cancel}":
          this.close();
          break;
        default:
          console.log(button);
          break;
      }
    },
    handleShiftKeyPress() {
      let layout = this.keyboard.options.layoutName;

      keyboard.setOptions({
        layoutName: layout === "default" ? "shift" : "default"
      });
    },
    handleEscapeKeyPress() {
      // Simulate a click on the close button link
      this.$refs.searchCloseButton.click();
    }
  }
};
</script>

<style>
#search__query__keyboard .simple-keyboard {
  border-radius: 0;
  background-color: transparent;
}

#search__query__keyboard .hg-button {
  color: #222;
  font-size: 1.5rem;
  border-radius: 3px;
  padding: 25px 5px;
  box-shadow: none;
  border: none;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#search__query__keyboard .hg-button img,
#search__query__keyboard .button img {
  height: 21px;
  margin: 0;
  padding: 0;
}

#search__query__keyboard .keyboard-button-back {
  color: #fff;
  background-color: #555;
}

#search__query__keyboard .keyboard-button-enter {
  color: #fff;
  background-color: rgba(11, 80, 145, 1);
  flex-grow: 2;
}

#search__query__keyboard .keyboard-button-cancel {
  color: #111;
  background-color: rgba(245, 193, 63, 1);
  flex-grow: 2;
}

#search__query__keyboard .keyboard-button-space {
  flex-grow: 10;
}
</style>
