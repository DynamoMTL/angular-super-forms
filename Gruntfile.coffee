module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      options:
        bare: false
      compile:
        files:
          'src/angular-super-forms.js': 'src/superForms.coffee'
          'test/superForms.spec.js': 'test/superForms.spec.coffee'
          'test/helpers.js': 'test/helpers.coffee'
    ngmin:
      directives:
        expand: true
        files: [{
          expand: true
          cwd: 'src'
          src: 'angular-super-forms.js'
          dest: 'src'
        }]
    pkg: grunt.file.readJSON('package.json')
    uglify:
      options:
        banner: '/*! <%= pkg.name %> (version <%= pkg.version %>) <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src: 'src/angular-super-forms.js'
        dest: 'src/angular-super-forms.min.js'
    watch:
      files: [
        'src/superForms.coffee'
        'test/superForms.spec.coffee'
      ]
      tasks: 'default'
      karma:
        files: ['src/angular-super-forms.js', 'test/superForms.spec.js']
        tasks: ['karma:unit:run']
    karma:
      unit:
        configFile: 'karma.conf.js'
        background: true
      continuous:
        configFile: 'karma.conf.js'
        singleRun: true
        browsers: ['PhantomJS']

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.registerTask 'default', ['coffee', 'ngmin', 'uglify']
