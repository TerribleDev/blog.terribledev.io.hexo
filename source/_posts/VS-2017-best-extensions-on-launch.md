layout: blog
title: 'VS 2017, best extensions on launch'
date: 2017-03-24 14:35:13
tags:
- dotnet
- csharp
- visual studio
---

When Visual studio 2015 launched, I wrote a blog post titled [Resharper without Resharper](/vs-2015-getting-resharper-experiance-without-resharper/). This was clearly aimed at giving people the ability in 2015 to divorce themselves from the very expensive product. In writing the post however, I didn't realize people would just want a low down on cool vs2015 extensions.

<!-- more -->

Since the launch of 2017, I decided to put together my favorite extensions again. 

## Recap

Here were my mentioned plugins of 2015:

* [Refactoring Essentials](http://vsrefactoringessentials.com/) - Still valid in 2017, great set of refactors
* [Code Cracker](http://code-cracker.github.io/) - Another one still valid in 2017, great package to do code analysis, and improvements
* [Code Maid](http://www.codemaid.net/) - Great for cleaning up source code, I'd use this still
* [Continuous Formatting](https://vlasovstudio.com/continuous-formatting/) - I wouldn't use this as much, stick with code maid. This is a paid product, and code maid is free.
* [Web Essentials](http://vswebessentials.com/) - Still a top tool for any webdev's


## Razor tooling extension

Ok so, incase you didn't hear. The AspNet team was unable to get all the razor tooling done in time to ship with VS 2017! Don't fret though, they have published an extension called the [Razor tooling extension](https://marketplace.visualstudio.com/items?itemName=ms-madsk.RazorLanguageServices). This provides a very rich experience with razor, and will ultimately let you refactor multiple razor files with ease! The biggest feature of this, is the TagHelper tools. This extension understands what TagHelpers you have in scope, and appropriately highlights, them and auto-completes the properties.

## Project file tools

Ok so this ones name is a little ambiguous. The [project file tools](https://marketplace.visualstudio.com/items?itemName=ms-madsk.ProjectFileTools) extension allows your nuget packages to auto complete when editing the new csproj files, akin to what we had with project.json. In the new world, your nuget packages are declared inside the csproj, and this just provides intellisense on what packages, and version are available. This is an awesome experience, to keep me inside VS, and not in [nuget.org](https://nuget.org)


## Roslynator

Ok, here is a cool one, both in name, and functionality. [Roslynator](https://marketplace.visualstudio.com/items?itemName=josefpihrt.Roslynator2017) is another refactoring/code analysis plugin that uses roslyn under the hood. This provides over 170 different analyzers, and over 180 refactorings, all for c#. I've been using this extension for a little while, and I've been blown away! Both by refactoring features, and the overall performance. Extensions such as this one, usually are less performant. I never noticed any slowdowns, or had this plugin ever crash. You can turn on and off features, through an options dialog. Great [documentation on github](https://github.com/JosefPihrt/Roslynator), lots of options, and a cool name all add up to a sweat experience.

## Productivity Power Tools!

Ok so I know I'm late to the game on this one. I'll be honest, I used this before, but didn't blog about it. [Productivity Power Tools](https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.ProductivityPowerPack2017) is a cool extension and in this release, it just installs a bunch of separate extensions. They broke apart the 1 extension, and made this extension a meta extension. This is so the team could rev each individual component.

Some of my favorites are the [match margin](https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.MatchMargin) which when text is highlighted, shows all lines in the margin where the same text occurs. [Copy as HTML](https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.CopyAsHtml) is a pretty cool extension that lets you copy in html, with proper formatting. Finally [Align Assignments](https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.AlignAssignments) is my all time favorite in this bundle. This aligns multiple declarations so they are all formatted the same.

## Roaming extensions!

The biggest new feature in vs 2017 is that your extensions can now "sync" between instances of VS. Under `tools -> Extensions and updates -> Roaming Extensions Manager` you can now pick extensions to "roam". This is an awesome tool, because you can now have the same development experience even under a brand new install! Your extensions finally go with you.

![roaming extension manager](extmgr.PNG)

## Summary

There are a ton of new extensions, go use them. Let me know in the comments below what your favorite extension is!!!!