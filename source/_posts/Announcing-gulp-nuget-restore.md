title: Announcing gulp-nuget-restore
date: 2016-02-24 09:58:04
tags:
- gulp
- build
- dotnet
- CI
---

So recently I have thought about build tools. We have many tools including [cake](https://github.com/cake-build/cake), [sake](https://github.com/sakeproject/sake), [albacore](https://github.com/Albacore/albacore), and even MSBUILD. Most of these tools work well, infact they work flawlessly. I am a web developer, and I work on a team of web developers. Most of our work is in JavaScript land, with tools like React, backbone, etc. We love ES6, and we want to use things like babel. This ultimately causes us to have 2 build engines. The first being a proprietary version of albacore, and the second being gulp.  
<!-- more -->
I love Gulp, I also love Grunt. They both have a place in the JavaScript community, and the tool itself doesn't matter, but what does is the fact that we **have** to use them. We already have multiple languages in our ecosystem, so drinking in ruby just for builds seems like a hard sell. Ideally we would want, and love to use JavaScript for everything. I started working on our builds in gulp, and I wrote a [gulp plugin](https://github.com/TerribleDev/gulp-nuget-restore) to do nuget restores. This plugin pairs well with the [msbuild](https://github.com/hoffi/gulp-msbuild) plugin.

 Feel free to try it out, and [tweet](http://twitter.com/terribledev) at me if you like it.

```csharp

var gulp = require('gulp');
var nugetRestore = require('gulp-nuget-restore');

gulp.task('default', function () {
    return gulp.src('./path/to/MySlnFile.sln')
        .pipe(nugetRestore());
});

```
