module.exports = (grunt)->
  grunt.initConfig

    jade:
      product:
        options:
          data:
            debug: false
        files:
          "demo/index.html": ["demo/index.jade"]

    coffee:
      product:
        options:
          bare: true
        expand: true
        cwd: 'demo'
        src: '*.coffee'
        dest: 'demo'
        ext: '.js'


  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask "default", ["jade:product","coffee:product"]



