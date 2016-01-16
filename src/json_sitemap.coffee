###*
 # Grunt JSON sitemap
 # Create a sitemap from a simple json file containing routes
 #
 # Copyright (c) 2016 Ugo Stephant <ugo@oddly.fr>
 # Licensed under MIT license
 # https://github.com/dackmin/grunt-json-sitemap/blob/master/LICENSE
###
"use strict"

module.exports = (grunt) ->
    pkg = grunt.file.readJSON "package.json"
    xmlbuilder = require "xmlbuilder"
    moment = require "moment"
    today = moment(new Date()).format "YYYY-MM-DD"

    grunt.registerMultiTask "json_sitemap", "", ->

        # Check if user has a sitemap property in his package.json file
        # or a mapfile property in config
        map_path = @data.map or pkg.sitemap
        return grunt.log.ok('Requires "map" property in config or "sitemap" property in package.json file. Sitemap was not created.') unless map_path

        # Try to read json mapfile
        try
            mapfile = grunt.file.readJSON map_path
        return grunt.log.ok('Requires map file to be a JSON file. Sitemap was not created.') unless mapfile

        # Check for siteroot property in mapfile
        siteroot = @data.siteroot or mapfile.siteroot
        return grunt.log.ok('Mapfile requires "siteroot" property. Sitemap was not created.') unless siteroot

        # Check for routes property in mapfile
        routes = mapfile.routes
        return grunt.log.ok('Mapfile requires "routes" property. Sitemap was not created.') unless routes

        # Get settings (not mandatory)
        settings =
            locales: @data.locales or mapfile.locales or ["en"]
            lastmod: @data.lastmod or mapfile.lastmod or today
            changefreq: @data.changefreq or mapfile.changefreq or "monthly"
            priority: @data.priority or mapfile.priority or 0.5
            dest: @data.dest or mapfile.dest or "sitemap.xml"

        # Start generating result
        urlset = xmlbuilder
            .create "urlset"
            .att "xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9"

        # Iterates thru locales
        for locale in settings.locales

            # Replace locale in siteroot
            _siteroot = siteroot.replace ":locale", locale

            for route, properties of routes
                route = if typeof properties is "string" then properties else route

                # Create url content
                urlset.ele
                    url:
                        loc: "#{_siteroot}#{route}"
                        lastmod: "#{properties.lastmod or settings.lastmod}"
                        changefreq: "#{properties.changefreq or settings.changefreq}"
                        priority: "#{properties.priority or settings.priority}"

        # End xml root element
        result = urlset.end
            pretty: true
            indent: '    '
            newline: '\n'

        # Write end file
        grunt.file.write settings.dest, result

        grunt.log.ok 'Sitemap created successfully'
        if grunt.task.current.errorCount then no else yes
