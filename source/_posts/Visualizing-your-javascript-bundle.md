title: The battle of the bulge. Visualizing your javascript bundle
date: 2018-10-17 13:19:18
tags:
- javascript
- battle of the bulge
- performance
---

So incase you havn't been following me. I joined Cargurus in July. At cargurus we're currently working on our mobile web experience written in react, redux and reselect. As our implementation grew so did our time to first paint.

<!-- more -->

So I've been spending a lot of time working on our performance. One tool I have found invaluable in the quest for page perf mecca is [source-map-explorer](https://www.npmjs.com/package/source-map-explorer). This is a tool that dives into a bundled file, and its map. Then visualizes the bundle in a tree view. This view lets you easily understand exactly what is taking up space in the bundle. What I love about this tool is that it works with any type of bundled javascript file, and is completely de-void of any builds. So any bugs in your webpack config leading to duplicate files in a bundle will show up here.


## Getting started

You get started by `npm install -g source-map-explorer` then just download your bundles, and sourcemaps. You can do this from production if you have them. Otherwise build bundles locally. **Note** You should always use this on minified code where any tree shaking and dead code elimination has occurred. In the command line run `source-map-explorer ./yourbundle.js ./yourbundle.js.map` Your browser should then open with a great tree view of what is inside your bundle. From here you can look to see what dependencies you have, and their sizes. Obviously, you can then decide to keep or throw them away.  

Here is a great youtube video explaining it in detail!


{% youtube 7aY9BoMEpG8 %}