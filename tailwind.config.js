const { colors } = require("tailwindcss/defaultTheme")

module.exports = {
  theme: {
    extend: {
      colors: {
        red: {
          ...colors.red,
          default: "#cod"
        }
      }
    },
    inset: {
      "0": 0,
      auto: "auto",
      "1/4": "25%"
    }
  },
  variants: {},
  plugins: []
}
