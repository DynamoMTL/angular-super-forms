module.exports = (grunt) ->

  grunt.initConfig
    clean:
      build:
        src: 'build'

    copy:
      build:
        cwd: '../src'
        src: [ 'angular-super-forms.js' ],
        dest: 'build',
        expand: true

    coffee:
      build:
        expand: true,
        cwd: 'scripts',
        src: [ '**/*.coffee' ],
        dest: 'build',
        ext: '.js'

    jade:
      compile:
        options:
          data: {}

        files: [{
          cwd: '.'
          expand: true,
          src: [ 'index.jade', '*.jade' ],
          dest: 'build',
          ext: '.html'
        }]

    'http-server':
      dev:
        port: 9000
        host: "127.0.0.1"
        showDir : true
        autoIndex: true
        ext: "html"
        runInBackground: false

  grunt.loadNpmTasks('grunt-http-server')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-jade')

  grunt.registerTask(
    'build',
    'Compiles all of the assets and copies the files to the build directory.',
    [ 'clean', 'copy', 'coffee', 'jade' ])
