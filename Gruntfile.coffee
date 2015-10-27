module.exports = (grunt)->
  grunt.initConfig

    jade:
      debug:
        options:
          data:
            debug: true,
            timestamp: "<%= new Date().getTime() %>"
        files:
          "demo/index.html": "demo/index.jade"

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

  grunt.registerTask "default", ["jade:debug"]
  grunt.registerTask "default", ["coffee:product"]


