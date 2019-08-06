const { colors } = require('tailwindcss/defaultTheme')

module.exports = {
  theme: {
    extend: {
      colors: {
        red: {
          ...colors.red,
          default: '#cod'
        }
      }
    }
  },
  variants: {},
  plugins: []
}
