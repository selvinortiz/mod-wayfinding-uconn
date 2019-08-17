<template>
  <section class="animated" :class="animatedClass">
    <div :class="keyboardClass"></div>
  </section>
</template>

<script>
import SimpleKeyboard from "simple-keyboard";
import "simple-keyboard/build/css/index.css";

const layout = {
  default: [
    "` 1 2 3 4 5 6 7 8 9 0 - = {bksp}",
    "{tab} q w e r t y u i o p [ ] \\",
    "{lock} a s d f g h j k l ; ' {enter}",
    "{shift} z x c v b n m , . / {shift}",
    ".com @ {space}"
  ],
  shift: [
    "~ ! @ # $ % ^ & * ( ) _ + {bksp}",
    "{tab} Q W E R T Y U I O P { } |",
    '{lock} A S D F G H J K L : " {enter}',
    "{shift} Z X C V B N M < > ? {shift}",
    ".com @ {space}"
  ]
};

const display = {
  "{space}": "Space",
  "{bksp}": "Back",
  "{enter}": "Enter",
  "{cancel}": "Cancel",
  "{lock}": "Caps",
  "{tab}": "Tab",
  "{shift}": "Shift"
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
  },
  {
    class: "keyboard-button-lock",
    buttons: "{lock}"
  },
  {
    class: "keyboard-button-shift",
    buttons: "{shif}"
  },
  {
    class: "keyboard-button-tab",
    buttons: "{tab}"
  }
];

export default {
  props: {
    input: {
      type: String,
      required: true
    },
    keyboardClass: {
      type: String,
      required: true
    },
    animatedClass: {
      type: String,
      default: ""
    }
  },
  data() {
    return {
      keyboard: null
    };
  },
  mounted() {
    this.keyboard = new SimpleKeyboard(`.${this.keyboardClass}`, {
      layout,
      display,
      buttonTheme,
      onChange: this.onChange,
      onKeyPress: this.onKeyPress,
      theme: "simple-keyboard hg-theme-default"
    });
  },
  methods: {
    onChange(input) {
      this.$emit("change", input);
    },
    onKeyPress(button) {
      if (button === "{shift}") {
        let layout = this.keyboard.options.layoutName;

        this.keyboard.setOptions({
          layoutName: layout === "default" ? "shift" : "default"
        });
      }

      this.$emit("click", button);
    }
  },
  watch: {
    input(input) {
      this.keyboard.setInput(input);
    }
  }
};
</script>

<style scoped>
.simple-keyboard.hg-theme-default {
  border-radius: 0;
  background-color: #edf2f7
}
</style>
