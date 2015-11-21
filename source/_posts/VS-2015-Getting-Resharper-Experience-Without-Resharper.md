title: 'VS 2015, Getting Resharper Experience Without Resharper'
tags:

  - c#
  - visual studio
  - productivity
permalink: vs-2015-getting-resharper-experiance-without-resharper
id: 46
updated: '2015-09-14 10:55:00'
date: 2015-08-09 10:25:49
---

Resharper has long dominated the c# landscape as the tool of tools. Roslyn shipping with VS 2015, the quick actions light bulb, and the community analyzers, all combine to produce a resharper-like experience.

## Showing Overloads/Param Info

Automatically showing documentation for parameters, and overloads for some reason is always off for me. To get the parameters information you must turn it in in `Text Editor -> Lanuage -> General -> Parameter Info` The parameter info should show auto-magically, but you can also type <kbd>Control</kbd> +<kbd>Shift</kbd>+<kbd>Space</kbd> to invoke the dialog.

![](/content/images/2015/08/paramInfoExample.png)

![](/content/images/2015/08/paramInfoSetting.PNG)

## Refactoring


Refactoring is a **huge** part of Resharper. I recently stumbled across a [fantastic] refactoring extension called [Refactoring Essentials](http://vsrefactoringessentials.com/)

You can install this into your project as a nuget package or install it as a visual studio extension. 

Refactoring Essentials does not just include refactors, but it also includes a bunch of code quality analyzers, and adjustments.

## Code Analysis

There are 2 fantastic code analyzers I really enjoy. The first is [Code Cracker](http://code-cracker.github.io/) Code cracker has lots of refactorizations to produce higher quality, more readable code. 

The second one I like is the [FxCop](https://www.nuget.org/packages/Microsoft.CodeAnalysis.FxCopAnalyzers/) analyzer produced by the Roslyn team. This one uses rules from FxCop to produce refactors to suit best practices in the CLR.

## Auto Format

I have had good luck with the [Continuous Formatting](https://vlasovstudio.com/continuous-formatting/), but its a paid product. If you don't want to pay for code formatting, I'd suggest using the [Code Maid](http://www.codemaid.net/) Extension. Both extensions are fantastic, and I think Code Maid does a really good job at reorganizing code. To say the least I have both extensions installed. 

## Working without resharper


The first thing that I realized is that intellisense does not auto complete as many classes as resharper. I notice that resharper auto completes classes even without any `using` statement in the current file. However the new Roslyn quick actions will suggest using things from different namespaces if the names are close enough. 

![](/content/images/2015/08/usingStatementExample.png)

### Invoking the Light bulb

I find the best way to invoke the light bulb is by hitting <kbd>Control</kbd>+<kbd>.</kbd> you can then hit <kbd>Enter</kbd> to select the action in the list.

## Other Extensions I cannot live without

This is an additional list of VS extensions that make me happy.

* [NDepend](http://www.ndepend.com/) Paid product, totally worth it. view my [blog post about it](/must-have-tool-ndepend/)
* [Sando Code Search](https://visualstudiogallery.msdn.microsoft.com/06f39a31-20ce-408c-afee-8a02b484db1c) Great little code search tool
* [Web Essentials](http://vswebessentials.com/) Great web tools for vs
* [Web Compiler](https://visualstudiogallery.msdn.microsoft.com/3b329021-cd7a-4a01-86fc-714c2d05bb6c) auto web compiler (less, js, etc.)
* [C# Methods code snippets](https://visualstudiogallery.msdn.microsoft.com/d4e9939d-baac-43d4-bece-960eb57e02c1) method code snippets


Let me know what your favourite VS tools are below.
