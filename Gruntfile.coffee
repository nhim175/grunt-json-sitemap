module.exports = (grunt) ->

    grunt.initConfig

        # General
        clean: [".tmp"]

        # Build
        coffee:
            build:
                files:
                    "tasks/json_sitemap.js": ["src/*.coffee"]

        # Tests
        mochaTest:
            unit:
                options:
                    reporter: "spec"
                src: "tests/**/*.coffee"

        json_sitemap:

            # General files tests
            minimum:
                map: "tests/dummy/map_minimum.json"
                dest: ".tmp/sitemap_minimum.xml"
            all_options:
                map: "tests/dummy/map_all_options.json"
                dest: ".tmp/sitemap_all_options.xml"
            from_package:
                dest: ".tmp/sitemap_from_package.xml"
            missing_routes:
                map: "tests/dummy/map_missing_routes.json"
                dest: ".tmp/sitemap_missing_routes.xml"
            missing_siteroot:
                map: "tests/dummy/map_missing_siteroot.json"
                dest: ".tmp/sitemap_missing_siteroot.xml"
            missing_file:
                map: "tests/dummy/map_missing_file.json"
                dest: ".tmp/sitemap_missing_file.xml"
            text:
                map: "tests/dummy/map_text.txt"
                dest: ".tmp/sitemap_text.xml"

            # Localized files tests
            with_locales:
                map: "tests/dummy/map_with_locales.json"
                dest: ".tmp/sitemap_with_locales.xml"
            without_locales:
                map: "tests/dummy/map_without_locales.json"
                dest: ".tmp/sitemap_without_locales.xml"

    grunt.loadTasks "tasks"
    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-mocha-test"
    grunt.loadNpmTasks "grunt-contrib-clean"

    grunt.registerTask "build", [
        "coffee"
    ]

    grunt.registerTask "test", [
        "clean"
        "json_sitemap"
        "mochaTest"
    ]
