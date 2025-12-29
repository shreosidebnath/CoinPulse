module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'cyber-dark': '#0a0e27',
        'cyber-darker': '#050814',
        'neon-green': '#39ff14',
        'neon-blue': '#00f0ff',
        'neon-red': '#ff073a',
        'neon-purple': '#bc13fe',
      },
    },
  },
  plugins: [],
}