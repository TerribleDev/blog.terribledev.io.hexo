title: Rebuilding this blog for performance
tags:
- performance
- battle of the bulge
- javascript
- dotnet
---

So many people know me as a very performance focused engineer, and as someone that cares about perf I've always been a bit embarrassed about this blog. In actual fact this blog as it sits now is **fast** by most people's standards. I got a new job in July, and well I work with an [absolute mad lad](https://twitter.com/markuskobler) that is making me feel pretty embarrassed with his 900ms page load times. So I've decided to build my own blog engine, and compete against him.

<!-- more -->

## Approach

Ok, so I want a really fast blog, but one that does not sacrifice design. I plan to pre-compute the HTML into memory, but I am not going to serve static files. In this case, I'll need an application server. I'm going to have my own CSS styles, but I'm hoping to be in the (almost) no-JS camp. Not that I dislike JS, but I want to do as much pre-computing as possible, and I don't want to slow the page down with compute in the client.

## Features

So this blog has a view to read a post. A home page with links to the last 10 blog posts and a pager to go back further in time. A page listing blogs by tags and links for each tag to posts.

## Picking Technologies

So in the past my big philosophy has been that most programming languages and technologies really don't matter for most applications. In fact this use-case *could* and probably should be one of them, but when you go to extremes that I go, you want to look at benchmarks. [Tech empower](https://www.techempower.com/benchmarks/) does benchmarks of top programming languages and frameworks. For my blog since it will be mostly be bytes in bytes out, precomputed, we should look at the plain text benchmark. The top 10 webservers include go, java, rust, c++, and C#. Now I know rust, go and C# pretty well. Since the rust, and go webservers listed in the benchmark were mostly things no one really uses, I decided to use dotnet. This is also for a bit of a laugh, because my competition hates dotnet, and I also have deep dotnet expertise I can leverage.


## Server-side approach

So as previously mentioned we'll be precomputing blog posts. I plan to compute the posts and hand them down to the views. If we use completely immutable data structures we'll prevent any locking that could slow down our app.

## ASPNET/Dotnet Gotchas

So dotnet is a managed language with a runtime. Microsoft has some [performance best practices](https://docs.microsoft.com/en-us/aspnet/core/performance/performance-best-practices?view=aspnetcore-2.2), but here are some of my thoughts.

* There is a tool called [cross gen](https://github.com/dotnet/coreclr/blob/master/Documentation/building/crossgen.md) which compiles dll's to native code. 
* Dotnet's garbage collector is really good, but it struggles to collect long living objects. Our objects will need to either be ephemeral, or pinned in memory forever.
* The garbage collector struggles with large objects, especially large strings. We'll have to avoid large string allocations when possible.
* dotnet has reference types such as objects, classes, strings, and most other things are value types. [Value types are allocated](https://blog.terribledev.io/c-strings/) on the stack which is far cheaper than the heap
* Exceptions are expensive when thrown in dotnet. I'm going to always avoid hitting them.
* Cache all the things!

 In the past we had to pre-compile razor views, but in 2.x of dotnet core, that is now built in. So one thing I don't have to worry about 


## Client side page architecture and design

So here are my thoughts on the client side of things.

* Minify all the content
* Deliver everything with brotli compression
* Always use `Woff2` for fonts
* Avoid expensive css selectors
  * 


## Tools 


