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
      transitionDuration: {
        '0': '0ms',
        '2000': '2000ms',
        '3000': '3000ms',
        '4000': '4000ms',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
