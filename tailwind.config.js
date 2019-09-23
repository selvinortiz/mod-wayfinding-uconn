const { colors, opacity } = require("tailwindcss/defaultTheme")

module.exports = {
  theme: {
    extend: {
      colors: {
        red: {
          ...colors.red,
          default: "#cod"
        }
      },
      opacity: {
        ...opacity,
        95: ".95"
      },
      textColor: {
      'default': '#c0d',
      }
    },
  },
  variants: {},
  plugins: []
}
