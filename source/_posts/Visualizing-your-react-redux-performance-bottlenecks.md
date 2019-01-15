title: 'Measuring, Visualizing and Debugging your React Redux Reselect performance bottlenecks'
date: 2019-01-14 22:04:56
tags:
- battle of the bulge
- javascript
- performance
---

In the battle of performance one tool constantly rains supreme, the all powerful profiler! In javascript land chrome has a pretty awesome profiler, but every-time I looked into our react perf issues I was always hit by a slow function called `anonymous function`

<!-- more -->

## Using the chrome profiler

So if you open the chrome devtools, you will see a tab called `performance`. Click on that tab. If you are looking into CPU bound workloads click the CPU dropdown and set yourself to 6x slowdown, which will emulate a device that is much slower.

![An image showing the chrome devtools](1.png)

Press the record button, click around on your page, then click the record button again. You are now hit with a timeline of your app, and what scripts were ran during this time.

So what I personally like to do is find orange bars that often make up the bulk of the time. However I've often noticed the bulk of bigger redux apps are taken up by `anonymous functions` or functions that essentially have no name. They often look like this `() => {}`. This is largely because they are inside of [reselect selectors](https://github.com/reduxjs/reselect). Incase you are unfamiliar selectors are functions that cache computations off the redux store.  Back to the chrome profiler. One thing you can do it use the `window.performance` namespace to measure and record performance metrics into the browser. If you expand the `user timings section` in the chrome profiler you may find that react in dev mode has included some visualizations for how long components take to render.

![react user timings in chrome](3.png)

## Adding your own visualizations

So digging into other blog posts, I found posts showing how to [visualize your redux actions](https://medium.com/@vcarl/performance-profiling-a-redux-app-c85e67bf84ae) using the same performance API mechanisms react uses. That blog post uses redux middleware to add timings to actions.  This narrowed down on our performance problems, but did not point out the exact selector that was slow. Clearly we had an action that was triggering an expensive state update, but the time was still spent in `anonymous function`. Thats when I had the idea to wrap reselect selector functions in a function that can append the timings. [This gist is what I came up with](https://gist.github.com/TerribleDev/db48b2c8e143f9364292161346877f93)

So how does this work exactly? Well its a library that wraps the function you pass to reselect that adds markers to the window to tell you how fast reselect selectors take to run. Combined with the previously mentioned blog post, you can now get timings in chrome's performance tool with selectors! You can also combine this with the [redux middleware](https://medium.com/@vcarl/performance-profiling-a-redux-app-c85e67bf84ae) I previously mentioned to get a deeper insight into how your app is performing

![a preview of selectors reporting their performance](2.png)

## So how do I use your gist?

You can copy the code into a file of your own. If you use reselect you probably have code that looks like the following.

```js
export const computeSomething = createSelector([getState], (state) => { /* compute projection */ });
```

You just need to replace the above with the following

```js
export const computeSomething =  createMarkedSelector('computeSomething', [getState], (state) => { /* compute projection */ });
```

its pretty simple, it just requires you to pass a string in the first argument slot to write to the performance API. Inside vscode you can even do a regex find and replace to add this string.


```
find: const(\s?)(\w*)(\s?)=(\s)createSelector\(

replace: const$1$2$3=$4createMarkedSelector('$2',
```
