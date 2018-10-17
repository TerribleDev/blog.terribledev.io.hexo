title: Navigating the JavaScript waters in 2015
tags:

  - node.js
  - javascript
permalink: navigating-the-javascript-waters-in-2015
id: 48
updated: '2015-09-01 20:18:27'
date: 2015-09-01 19:39:41
---

In this last year I have done much more JavaScript development than I have before. The landscape, and tools have exploded over the last few years. Gone are the days of JQuery widgets, and come forth have advanced virtual dom libraries, JavaScript servers, and multiple package managers. Along with new language features.
<!-- more -->
## Node.js and io.js

Right now there are two versions of Node.js. Although fairly soon the code bases will [merge back together](http://thenextweb.com/dd/2015/06/16/node-js-and-io-js-are-settling-their-differences-merging-back-together/).

For those of you whom don't know, node.js is a server side JavaScript environment. io.js was a recent fork of the node.js code base to include newer language features, and updated versions of V8.

In the long run both of these runtimes will merge to make the Node Foundation. In the short term I'd stick with node, unless you have a compelling reason to use io.

## Package Management

* [Bower](http://bower.io/) - Simple package manager to download files and place them on the file system.

* [jspm](http://jspm.io/) - Client side focused package manager

* [npm](https://www.npmjs.com) - Package manager mostly focused on shipping CommonJS modules, mostly for node.js


## Modules

Modules are a pattern that encapsulates JavaScript code so scripts do not have to rely on the global namespace, but instead reference the file definitions.

* CommonJS essentially defines module patterns with the use of an exports object.
* [AMD](http://requirejs.org/docs/whyamd.html) is a module definition designed for files to be downloaded separately, with the browser in mind.

## Great libraries to mention

These are some of the libraries I have liked. I'm sure I am leaving out many great others.

* [Babel](https://babeljs.io/) - ES6 to ES5 transpiler. People use this to write ES6 code, and have it recompile to ES5 for use with older browsers.
* [ReactJS](http://facebook.github.io/react/) Client-Side framework for building UI's. Reacts strength is a Virtual DOM system that figures out what to alter in the UI, and just alters those elements, instead of altering the whole document.
* [Mithril](https://lhorie.github.io/mithril/) - Client Side MVC with Virtual DOM diff system (akin to ReactJS)
* [Tungstenjs](https://github.com/wayfair/tungstenjs) Virtual DOM system using Mustache server side, with plugins for backbonejs and ambersandjs client side.
* [Browserify](http://browserify.org/) A library that bundles commonJS modules into a file for use with the browser.
* [Grunt](http://gruntjs.com/) JavaScript task runner similar to Ant or Rake
* [Gulp](http://gulpjs.com/) Much like grunt, a JavaScript task framework much like Rake
