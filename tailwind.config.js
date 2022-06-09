module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography')
  ]
}

