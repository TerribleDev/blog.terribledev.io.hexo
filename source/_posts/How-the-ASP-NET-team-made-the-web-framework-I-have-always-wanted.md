title: How the ASP.NET team made the web framework I have always wanted
tags:
  - c#
  - aspnet 5
  - aspnet
  - nuget
  - open source
  - JavaScript
permalink: how-the-asp-net-team-dived-into-my-head-and-made-the-webframework-i-have-always-wanted
id: 62
updated: '2015-11-14 20:30:28'
date: 2015-11-14 07:42:42
---

So I know I do a lot of blogging about C#, or JavaScript, but I actually do a lot of nodejs apps as well as other languages. For a very long time I have not found the stack of my dreams. .NET has always been very close but there were multiple things about the app model that I was not a fan of. I think NancyFX has been the closest framework to my dreams in .NET land.
<!-- more -->

## .NET 4x and my gripes

.NET 4x is the current generation of the application model. Made over 15 years ago, it makes a lot of assumptions about development that are not true today. No builtin dependency injection, and the ASP.NET pipeline being baked into IIS, it is less than fun to work with.

#### JS frameworks


So the first huge gripe for me in asp 4.x land is when I go file->New I get a project that has bootstrap from nuget. The first time I saw this I was fine with it, however as bower got more mature I really started to hate it. You can't delete the js file and restore it at build time so you have to add toxicity to your git repo by holding onto the file.


#### CS proj (and javascript)

I really enjoy using Atom, or Webstorm for Javscript. Visual studio is not in my mind when working on JavaScript applications. However when I work on SPA's for ol' .NET the files would have to have a csproj reference if I wanted to make a web deploy package that contained the file. The only other [route I found](https://blog.tommyparnell.com/using-bower-and-grunt-with-a-net-app/) was to make some special MSBUILD tasks that included adding a whole folder as content at build time. This was fine until I'd work with someone whom really liked using VS for programming and none of my files were in the csproj.

#### Webapi vs MVC

I'm not going to go into too much detail on this, but if you have worked in .net at all you know the pains of webapi and MVC.  Webapi was a separate framework that looked really similar as MVC to host rest APIs. They had similar functionality with action filters, but when you would try to use a webapi actionfilter for MVC you wouldn't be able to without your class inheriting from both interfaces and thus requiring additional work. They had very similar models but ultimately different implementations and namespaces making working with them both a pain.

#### Windows

I am a long time Linux guy. I love having tail, grep, awk, sed, and the various other tools that come by default in the bourne shell. I often enjoy using zsh. I really wanted to love .NET, because I really do enjoy writing C#, but not supporting linux was a huge bummer for a long time. My [coworker ](normmaclennan.com) and I had a site about mono and how to [get started](https://github.com/maclennann/usemono-net/wiki/Getting-Started-with-Mono). We were self hosting Nancy in Nginx and it was awesome, but we couldn't use anything that didn't have great support at work. When containers started to get big, all my colleagues writing Java were showing me their ECS clusters while I was (and still am) over here hoping that IIS would install under 2 minutes in EC2. I have many problems with windows, beyond those gripes, but I won't go into them here. To say the least I will be keeping ubuntu on my machine from now on.


## The future and .NET 5x

.NET 5 is a huge reboot over the existing application model. Self hosting on a web server called [Kestrel](https://github.com/aspnet/KestrelHttpServer) This application model has **many** distinctions which I always wanted.

#### Choices

The whole thing is built on one simple philosophy, and this philosophy I LOVE. This is that if you want something you can include it, if you don't want something you can exclude it. For example if you really want static files then include the static files package, if you don't then don't include it. This approach allows people to really juice the performance of their application, and was the basis for NodeJS development. Also with MacOS and Linux support, your choice has now extended past Windows.

#### Dependency Injection

The Application Model has a built in dependency injector that works very well. If you need something get it from the DI container. If you controllers need things just have a constructor that requires those types, the DI container will take care of it for you. No more downloading Autofac and messing around trying to set that kind of thing up.

#### Modern Javascript support

All of your client side javascript (bower packages, etc) can go into a folder called wwwroot. This folder takes on the root path at runtime, and everything is always included which means using bower to get deps is 100% possible. You need minification? Use what the JS community has.

#### No more csproj

So its 5pm on a friday. I have just added a file to my project, git committed, and the build failed. I go and realize that I forgot to save my csproj file and thus the build is missing a file. This happens to me more than I dare to admit. In the future everything works off the local disk, no more csproj xml, thus no more failed builds for ceremonious xml files.


Overall the future looks really bright for .NET I really hope they can escape the mentality of .NET == windows and hopefully get some more traditional Linux people on the stack.
