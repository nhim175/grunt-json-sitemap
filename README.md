# grunt-json-sitemap [![Build Status](https://travis-ci.org/dackmin/grunt-json-sitemap.svg?branch=master)](https://travis-ci.org/dackmin/grunt-json-sitemap)

> Create a sitemap from a simple json file containing routes.

The idea behind this plugin was to help us at [Oddly](http://www.oddly.fr) to easily generate a full sitemap of our Angular apps without really having to write XML.


## Getting Started

This plugin requires Grunt >=0.4.0

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```sh
npm install grunt-json-sitemap --save
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks("grunt-json-sitemap");
```

## json_sitemap task

Run this task with the `grunt json_sitemap` command.

### Usage examples

```js
json_sitemap: {
    dev: {
        // You can use "sitemap" property in your package.json
        // instead of adding "map" property here
        dest: ".tmp/sitemap.xml"
    },
    dist: {
        map: "app/sitemap.json",
        dest: "dist/sitemap.xml"
    }
}
```

## Default map file

```json
{
    "siteroot": "http://www.google.fr/:locale",
    "locales": ["fr","en","es"],
    "changefreq": "yearly",
    "lastmod": "2016-01-12",
    "routes": {
        "/route/1": {
            "priority": 0.8
        },
        "/route/2": {}
    }
}
```

### Properties

#### siteroot

- Type : `String`
- Required : `true`

First part of all urls `loc` elements


#### routes

- Type : `Array|Object`
- Required : `true`

Basically your site pages. Can either be an array or strings or an object with key/value pairs (as provided in the default map file above)


#### locales

- Type : `Array`
- Default : `["en"]`

If your site has multiple locales, you can add them here, and use the `:locale` tag in your `siteroot` url


#### changefreq

- Type : `String`
- Default : `"monthly"`

Frequency at which you update your site pages. See [sitemap.xml schema](http://www.sitemaps.org/protocol.html) for more informations on this property.

You can also add this property as a __route-specific__ property.


#### lastmod

- Type : `String`
- Default : `"YYYY-MM-DD"` (today's date)

Last time you updated your site pages. See [sitemap.xml schema](http://www.sitemaps.org/protocol.html) for more informations on this property.

You can also add this property as a __route-specific__ property.


#### priority

- Type : `float`
- Default : `0.5`

Your site's pages priority. See [sitemap.xml schema](http://www.sitemaps.org/protocol.html) for more informations on this property.

You can also add this property as a __route-specific__ property.


## Contributing

1. Fork the repository :)
2. Create your feature branch: `git checkout -b feature/awesome-feature`
3. Run: `npm i` to install dependencies
4. Run: `grunt build` to build the project
5. Do changes
6. __ADD TESTS__ ! and launch them with `grunt test`
7. Commit your changes: `git commit -m 'Adds awesome feature'`
8. Push your commits: `git push origin feature/awesome-feature`
9. Submit a pull request !

Your build/test has to pass travis builds.
You also have to respect the coding styles I used in this project, otherwise your pull request might be rejected.


## Release History

See [Changelog.md](Changelog.md)
