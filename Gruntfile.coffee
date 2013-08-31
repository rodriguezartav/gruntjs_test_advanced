class Helper

module.exports = (grunt) ->

  grunt.initConfig

    clean:
      lib:
        src: "./javascript/**/*.*"
      unit:
        src: "./test/unit/*.js"

    coffee:
      lib: 
        expand: true,
        flatten: true,
        cwd: './src/',
        src: ['*.coffee'],
        dest: './javascript/single',
        ext: '.js'

      unit:
        expand: true,
        flatten: true,
        cwd: './test/unit-src',
        src: ['*.coffee'],
        dest: './test/unit',
        ext: '.js'          

    mochaTest:
      unit:
        options:
          reporter: 'spec'
        src: ['test/unit/*.js']

    watch:
      lib:
        files: ["./src/*.coffee"]
        tasks: ['compile']
      unit:
        files: ["./test/unit-src/**/*.coffee"]
        tasks: ['test']
      both:
        files: ["./src/*.coffee", "./test/unit-src/**/*.coffee"]
        tasks: ["compile", "test"]


  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.registerTask('compile', ['clean:lib','coffee:lib']);  
   
  grunt.registerTask('test', ['clean:unit','coffee:unit', "mochaTest"]);   
  
  grunt.registerTask('autotest', ['watch:unit']);

  grunt.registerTask('autocompile', ['watch:lib']);  

  grunt.registerTask('auto', ['watch']);  
