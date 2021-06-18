const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [
		'../lib/**/*.ex',
		'../lib/**/*.leex',
		'../lib/**/*.eex',
		'./js/**/*.js'
	],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
