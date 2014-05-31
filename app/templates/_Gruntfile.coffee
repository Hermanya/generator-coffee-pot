module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      options:
        livereload: true<%
 switch (CSSpreprocessor) {
      case 'none': break;
    case 'SASS':%>
      sass:
        files: '_app/stylesheets/*.{scss,sass}'
        tasks: ['sass']<%
        break;
    default:%>
      stylus:
        files: '_app/stylesheets/*.styl'
        tasks: ['stylus']<%
      break;}%>
      coffee:
        files: '_app/*coffee'
        tasks: ['coffeeify']
      css:
        files: 'app/*.css'
        tasks: ['autoprefixer']<%
 switch (CSSpreprocessor) {
    case 'none': break;
    case 'SASS':%>
    sass:
      compile:
        options:
          sourcemap: true
        files: [{
          'app/style.css': '_app/stylesheets/*.{scss,sass}'
        }]<%
      break;
      default:%>
    stylus:
      compile:
        files:
          'app/style.css': '_app/stylesheets/*.styl'<%
        break;
      }%>
    coffeelint:
      app: ['*.coffee']
      options:
        configFile: 'coffeelint.json'
    coffeeify:
      options:
        debug: true
      files:
        src: '_app/*.coffee',
        dest: 'app/script.js'
    connect:
      server:
        options:
          livereload: 35729
          open: true
          hostname: 'localhost'
    autoprefixer:
      sourcemap:
        options:
          map: true
        src: 'app/*.css'<%
 switch (CSSpreprocessor) {
  case 'none': break;
  case 'SASS':%>
  grunt.loadNpmTasks 'grunt-contrib-sass'<%
    break;
    default:%>
  grunt.loadNpmTasks 'grunt-contrib-stylus'<%
    break;}%>
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-coffeeify'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.registerTask 'default',
    ['coffeelint','coffeeify',<%
     switch (CSSpreprocessor) {
        case 'none': break;
        case 'SASS':%> 'sass',<%
          break;
        default:%> 'stylus',<%
          break;
    }%> 'autoprefixer','connect','watch']
