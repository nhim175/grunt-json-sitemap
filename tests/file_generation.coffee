"use strict"

assert = require "assert"
grunt = require "grunt"

describe "Files generation", ->

    it "should create a sitemap_from_package.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_from_package.xml"), true
        done()

    it "should create a sitemap_minimum.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_minimum.xml"), true
        done()

    it "should create a sitemap_all_options.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_all_options.xml"), true
        done()

    it "should not create a sitemap_missing_routes.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_missing_routes.xml"), false
        done()

    it "should not create a sitemap_text.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_text.xml"), false
        done()

    it "should not create a sitemap_missing_siteroot.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_missing_siteroot.xml"), false
        done()

    it "should not create a sitemap_missing_file.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_missing_file.xml"), false
        done()
