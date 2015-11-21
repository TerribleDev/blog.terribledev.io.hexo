title: 'Mono, not just a sickness'
tags:

  - c#
  - linux
  - mono
permalink: mono-not-just-a-sickness
id: 39
updated: '2015-02-22 20:58:08'
date: 2014-11-04 02:25:47
---

In the old days, when programming in .NET you were signing yourself up to a lifetime of windows server, however things have changed.

## About me

I am an avid user of Linux. My laptop, Linux; my gaming computer, linux; this blog? Linux. Safe to say I love the NIX environment. 

I love C-like languages. My first language was JavaScript, then Java, eventually c#. I dislike ruby except for small scripts, and I would rather stab myself than use PHP. 

Over time I have really grown to love c#. 

>With Generics, Dynamic typing, async's, lamda expressions, nuget packages (c#-like npm modules), c# has a rich ecosystem of features.

The one thing that has killed me, until recently is I have not been able to run my c# code on Linux.

## Mono Runtime

For those of you whom do not know, [mono](http://www.mono-project.com/) is an open source implementation of the .NET stack that runs on Linux, and Windows. This means that people can host their code on both platforms, but other people whom prefer linux can actually contribute to the c# community.

### Working with Mono

Earlier this year a [colleague](http://blog.normmaclennan.com/), and I started working on a project at vistaprint that used mono. Here are some tips we learned.

* Mono might be missing some libraries. Use [mono-Gendarme](http://www.mono-project.com/docs/tools+libraries/tools/gendarme/) as part of your build process to detect any compatibility issues.
* Use [monodevelop](http://monodevelop.com/) as your IDE, trust me its on-par with Visual Studio.
 * Make sure you are on 5.0 or higher. 
 * Use [this PPA](https://launchpad.net/~ermshiperete/+archive/ubuntu/monodevelop) on Ubuntu, and install monodevelop-current
* Use frameworks, or that build against mono. 
 * We had great luck with [Nancyfx](http://nancyfx.org/)
* Build file paths using Path.Combine, never hardcode paths
 * This is because windows paths use `\` and Linux paths use `/` as the seperator
* [Fluent DB](https://www.nuget.org/packages/FluentMigrator/) can build your database regardless of SQL server type (MS, postgre, etc)


### Finding Help

We put more help on a [advocacy site](http://usemono.net). This is a NancyFx site, built on Travis CI, deployed to heroku. The sites' [github page, and wiki](https://github.com/maclennann/usemono-net) contain aditional knowledge. 

Also [Jabbr.net](jabbr.net) is a great source to find .NET dev's whom are always ready to answer a questions.

### Myths?

> MSFT is going to sue and or shutdown mono

* Control + F [this blog post](http://www.hanselman.com/blog/IntroducingASPNETVNext.aspx) for the word mono

> Mono does not support *Insert current version of .NET*

Compatibility can be found [here](http://www.mono-project.com/docs/about-mono/compatibility/) Although I'm betting that it supports pretty much everything current at the time of *you* reading this.

> Mono has poor GC performance

I have seen this with the Generational collector, I suggest you switch to using the SGEN collector.

## Mono Successes?

I wanted to come into this blog with a huge list of success stories for mono. However I didn't have the time, and I didn't want to seem like I was being paid by said people. 

I guess the one huge success story I will point to is [Xamarin](http://xamarin.com/). Xamarin runs your mobile apps on all phones using c#, and guess what? Mono. Actually the Xamarin people are the ones working on mono, and (one could assume) funding it through the xamarin platform. I'd love to say I was being paid by xamarin to say this, but I am not. Heck my Xamarin license just expired.



## tl;dr 

Give mono a shot, and start hosting on linux. Mono has great support for the various .NET Versions. I recommend using [NancyFx](http://nancyfx.org/) web framework, and not MVC.