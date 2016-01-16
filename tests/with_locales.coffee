"use strict"

assert = require "assert"
grunt = require "grunt"

describe "Localized sitemaps", ->

    it "should create a sitemap_with_locales.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_with_locales.xml"), true
        done()

    it "should generate same sitemap_with_locales.xml file than target", (done) ->
        dummy = grunt.file.read ".tmp/sitemap_with_locales.xml"
        target = grunt.file.read "tests/targets/sitemap_with_locales.xml"
        assert.equal dummy, target
        done()

    it "should create a sitemap_without_locales.xml file", (done) ->
        assert.equal grunt.file.exists(".tmp/sitemap_without_locales.xml"), true
        done()

    it "should generate same sitemap_without_locales.xml file than target", (done) ->
        dummy = grunt.file.read ".tmp/sitemap_without_locales.xml"
        target = grunt.file.read "tests/targets/sitemap_without_locales.xml"
        assert.equal dummy, target
        done()
