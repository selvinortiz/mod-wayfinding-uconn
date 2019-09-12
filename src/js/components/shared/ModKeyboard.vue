<template>
  <section class="animated" :class="animatedClass" :style="keyboardContainerStyles">
    <div :class="keyboardClass" :style="keyboardStyles"></div>
  </section>
</template>

<script>
import SimpleKeyboard from "simple-keyboard";
import "simple-keyboard/build/css/index.css";

const layout = [
  "Q W E R T Y U I O P",
  "A S D F G H J K L",
  "Z X C V B N M",
  "{shift} {bksp} {space} {cancel}",
];

const layoutAfterShift = [
  "1 2 3 4 5 6 7 8 9 0",
  "- / : ; ( ) $ & @ \"",
  ". , ? ! ",
  "{shift} {bksp} {space} {cancel}"
];

const buttonLabels = {
  "{space}": "Space",
  "{bksp}": "⇤",
  "{enter}": "Enter",
  "{cancel}": "Cancel",
  "{lock}": "Caps",
  "{tab}": "Tab",
  "{shift}": "123"
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
    keyboardStyles: {
      type: String,
    },
    keyboardContainerStyles: {
      type: String,
    },
    animatedClass: {
      type: String,
      default: ""
    },
    keyboardLayout: {
      type: Array,
      default: () => layout
    },
    keyboardLayoutAfterShift: {
      type: Array,
      default: () => layoutAfterShift
    },
    keyboardButtonLabels: {
      type: Object,
      default: () => buttonLabels
    },
    keyboardButtonTheme: {
      type: Array,
      default: () => buttonTheme
    },
  },
  data() {
    return {
      keyboard: null
    };
  },
  mounted() {
    this.keyboard = new SimpleKeyboard(`.${this.keyboardClass}`, {
      layout: {
        default: this.keyboardLayout,
        shift: this.keyboardLayoutAfterShift
      },
      display: this.keyboardButtonLabels,
      buttonTheme: this.keyboardButtonTheme,
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

        console.log(layout)

        if (layout === "shift") {
          buttonLabels['{shift}'] = '123'
        } else {
          buttonLabels['{shift}'] = 'ABC'
        }

        this.keyboard.setOptions({
          layoutName: layout === "default" ? "shift" : "default",
          display: {...buttonLabels}
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
  background-color: transparent;
}
</style>
