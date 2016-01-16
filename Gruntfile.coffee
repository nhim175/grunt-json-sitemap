module.exports = (grunt) ->

    grunt.initConfig
        coffee:
            build:
                files:
                    'tasks/json_sitemap.js': ['src/*.coffee']
        json_sitemap:
            minimum:
                map: "dummy/map_minimum.json"
                dest: ".tmp/sitemap_minimum.xml"
            all_options:
                map: "dummy/map_all_options.json"
                dest: ".tmp/sitemap_all_options.xml"
            from_package:
                dest: ".tmp/sitemap_from_package.xml"

    grunt.loadTasks "tasks"
    grunt.loadNpmTasks 'grunt-contrib-coffee'

    grunt.registerTask "build", [
        "coffee:build"
    ]

    grunt.registerTask "test", [
        'json_sitemap'
    ]
