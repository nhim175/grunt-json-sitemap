
/**
  * Grunt JSON sitemap
  * Create a sitemap from a simple json file containing routes
  *
  * Copyright (c) 2016 Ugo Stephant <ugo@oddly.fr>
  * Licensed under MIT license
  * https://github.com/dackmin/grunt-json-sitemap/blob/master/LICENSE
 */

(function() {
  "use strict";
  module.exports = function(grunt) {
    var moment, pkg, today, xmlbuilder;
    pkg = grunt.file.readJSON("package.json");
    xmlbuilder = require("xmlbuilder");
    moment = require("moment");
    today = moment(new Date()).format("YYYY-MM-DD");
    return grunt.registerMultiTask("json_sitemap", "", function() {
      var _siteroot, i, len, locale, map_path, mapfile, properties, ref, result, route, routes, settings, siteroot, urlset;
      map_path = this.data.map || pkg.sitemap;
      if (!map_path) {
        grunt.fail.warn('Requires "map" property in config or "sitemap" property in package.json file. Sitemap was not created.', 3);
      }
      mapfile = grunt.file.readJSON(map_path);
      if (!mapfile) {
        grunt.fail.warn('Requires map file to be a JSON file. Sitemap was not created.', 3);
      }
      siteroot = this.data.siteroot || mapfile.siteroot;
      if (!siteroot) {
        grunt.fail.warn('Mapfile requires "siteroot" property. Sitemap was not created.', 3);
      }
      routes = mapfile.routes;
      if (!routes) {
        grunt.fail.warn('Mapfile requires "routes" property. Sitemap was not created.', 3);
      }
      settings = {
        locales: this.data.locales || mapfile.locales || ["en"],
        lastmod: this.data.lastmod || mapfile.lastmod || today,
        changefreq: this.data.changefreq || mapfile.changefreq || "monthly",
        priority: this.data.priority || mapfile.priority || 0.5,
        dest: this.data.dest || mapfile.dest || "sitemap.xml"
      };
      urlset = xmlbuilder.create("urlset").att("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9");
      ref = settings.locales;
      for (i = 0, len = ref.length; i < len; i++) {
        locale = ref[i];
        _siteroot = siteroot.replace(":locale", locale);
        for (route in routes) {
          properties = routes[route];
          route = typeof properties === "string" ? properties : route;
          urlset.ele({
            url: {
              loc: "" + _siteroot + route,
              lastmod: "" + (properties.lastmod || settings.lastmod),
              changefreq: "" + (properties.changefreq || settings.changefreq),
              priority: "" + (properties.priority || settings.priority)
            }
          });
        }
      }
      result = urlset.end({
        pretty: true,
        indent: '    ',
        newline: '\n'
      });
      grunt.file.write(settings.dest, result);
      grunt.log.ok('Sitemap created successfully');
      if (grunt.task.current.errorCount) {
        return false;
      } else {
        return true;
      }
    });
  };

}).call(this);
