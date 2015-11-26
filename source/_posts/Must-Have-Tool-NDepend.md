title: 'Must Have Tool: NDepend'
tags:

  - Review
  - c#
  - Must Have Tool
  - tools
permalink: must-have-tool-ndepend
id: 32
updated: '2015-08-10 09:31:41'
date: 2014-05-23 21:04:17
---

Code quality tooling has become a bigger, and bigger industry. Tools like [Resharper](http://www.jetbrains.com/resharper/), and [stylecop](http://stylecop.codeplex.com/releases/view/79972) have been telling us how bad us human beings are at developing code.

The one problem I have always had with these tools is they dont go above and beyond to help you understand your code at a higher level.

<!-- more -->
## So what is NDepend?

![NDepend Logo](/content/images/2014/May/ndep.PNG)

According to [their website](http://www.ndepend.com/Features.aspx) NDepend does everything from code rules, code querying, comparing builds, CI reporting, complexity diagramming, and the list goes on and on.

When I first heard of it, I assume it was more resharper, and less stylecop, but I was wrong.

## My Code Quality Beginnings...

Before I go on about NDepend I have to tell you my history with code quality tools.

### JS Lint == /sadface

I first learned of code quality tools, when I heard about [JSLint](http://www.jslint.com/). As JavaScript was my first programming language, I naturally thought I was amazing at it. However being a weakly type language, with horrible origins, it was easy to make bad code.

The first code I pumped into JS lint returned with thousands of changes I needed to make, and I wasn't sure where to start. JSLint did a good job of destroying my ego, and de-motivating me as a human being. I took personal offense to it, even though it was trying to help me. Furthermore because it didn't really integrate into my IDE, it was harder for me to track down issues.

### Stylecop

![](/content/images/2014/May/91wmm.jpg)

My next attempt at using code quality tools was stylecop. Stylecop is a simple C# visual studio plugin that tells you where your code does not follow best practices. The first time I ran my code though stylecop it threw back over 700 warnings. The fact that it found so much to change was great, but the fact that everything was a warning, and nothing was an error was very concerning. Especially since I knew some bad code was in that codebase.

Also with the overall lack of visualization stylecop was less than perfect. You would have to double click on every warning, and hope it brought you to the proper offending code.

### Mono.Gendarme

So recently I started using Gendarme to do code analyzation. I commit code, [jenkins](http://jenkins-ci.org/) builds it, gendarme analyzes it, and jenkins would host my gendarme graphs. This was great, because jenkins could show the code gendarme was complaining about. Gendarme does not make everything warnings, and it does a good job at analyzing code.

My major problem with this, is that I'd have to commit bad code to the code base, then go back and fix the problems. Instead of fixing them before they landed in jenkins lap.

### Resharper


Now before I go on I have to mention Resharper. Resharper is a developer productivity tool that uses a lot of coding standards/rules to make sure your code does not suck. However this is no replacement for a true code quality tool. Resharper is more about productivity (fixing lambdas, making sure your linq statements are readable, etc.). The big difference is that Resharper lacks in the reporting deparment, it does not capture trends, and does not enforce certain best practice rules.

Resharper only looks at source code, where as most other static analysis tools also look at compiled IL code as well.

## NDepend: First Impressions

>NDepend runs extremely fast, and it never gets in your way.

So I when first fired up Visual Studio, and started using NDepend I was blown away with the performance. NDepend Runs extremely fast, and never crashes visual studio.  I needed a few minutes to process what I was looking at, and before long I realized NDepend had summerized my whole code base into one very sweet dashboard. As I clicked around the fun started to really begin...


![](/content/images/2014/May/ndepdash.PNG)


![Sample NDepend Dasbboard](/content/images/2014/May/NDependDash.PNG)



## NDepend: Organized Code Quality

So the major feature I was blown away by with NDepend was how clean, and organized the code rules are. The tool really tells you which things you need to fix **now**, and which things can wait. You can easily turn rules on, and off with a click a checkbox. Everything is grouped together nicely.

![Code Quality dashboard](/content/images/2014/May/errorsOrganized.PNG)

>NDepend uses a code querying engine (basically `linqTo<YourCodeHere>`).

 The code quality rules, uses the NDepends querying engine to get your code. When you click on a rule the Linq query used will be displayed in a separate window. You can use this window to create your own rules, using the same querying engine. The following is a query to find code that should not be declared public.

<pre>
 //<Name>Avoid public methods not publicly visible</Name>
// Matched methods are declared public but are not publicly visible by assemblies consumers.
// Their visibility level must be decreased.

warnif count > 0
from m in JustMyCode.Methods where
   !m.IsPubliclyVisible && m.IsPublic &&

   // Eliminate virtual methods
   !m.IsVirtual &&
   // Eliminate interface and delegate types
   !m.ParentType.IsInterface &&
   !m.ParentType.IsDelegate &&
   // Eliminate default constructors
   !(m.IsConstructor && m.NbParameters == 0) &&
   // Eliminate operators that must be declared public
   !m.IsOperator &&
   // Eliminate methods generated by compiler
   !m.IsGeneratedByCompiler
select m

</pre>

## NDepend: Code Dependency Management

The other feature, and its probably more of a series of features is how NDepend manages code dependency. This does this with some awesome interactive graphs. The [documents](http://www.ndepend.com/Doc_VS_Arch.aspx#Dep) show pretty much all the graphs, and I wont get into it all, but from a high level they provide great visualizations of your code.

>Graphing everything from class inheritance, to dependency graphs NDepend brings a new level of graphing to code quality tools.

The tool allows you to find poor architectural decisions, and helps you correct them in the early days. Before the bad design decisions really bite you.

## But wait there's more!

If you thought this was a simple visual studio plugin, you would be wrong.

>Having code quality in the build system is a must. I have always made sure code quality was also being measured in my CI pipline, and you should to.

NDepend plugs into your build system to provide long term trend reporting. These reports can include LOC trends, which are compared against rule violation trends. NDepend reports can show your Test code coverage, code complexity, and code composition as your application matures.

With an optional separate GUI, command line tool, and pluggable rules engine, NDepend provides a new level of code quality management.


## tl;dr?

NDepend is a code quality tool that really shows your code smells in new ways. with long term trend reporting, heat maps, and more graphs than you will ever need. NDepend will help your team grow a codebase that is clean, and free from dodgy code.
