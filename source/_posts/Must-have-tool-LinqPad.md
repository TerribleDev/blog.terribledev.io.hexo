title: 'Must have tool: LinqPad'
tags:

  - c#
  - Must Have Tool
  - tools
  - review
permalink: must-have-tool-linqpad
id: 28
updated: '2014-04-16 06:22:43'
date: 2014-04-14 22:59:46
---

[LinqPad](http://linqpad.net) is an interactive C#/F#/VB.NET scratchpad that lets you run arbitrary C#/F#/VB.NET code, and also lets you query databases with linq.

## What did that method do again?

We have all been there....its way past your bedtime, and you cannot for the life of you remember what happens when string.Concat is called. You could try to just run something quick in your project to find out, but that would take time to build. You could google the result, and hope you can find the answer quickly....Or you can open linqpad and run the method!

![query result from linqpad ](/content/images/2014/Apr/linqpad.PNG)

Ok of course you would never forget about string.Concat, but what about a method in a .dll? Well it can do that too!

## Quickly, I can't figure out the SQL Codez!

Ok so if you are like myself you probably suck at SQL...I was once good until I saw the Linq light...only dynamically creating linq queries is never as good as having real stored procedures. The [Linq Website](https://www.linqpad.net/WhyLINQBeatsSQL.aspx) has more examples of using SQL with linqpad than I could ever come up with.

To put it simply writing in linq is far more expressive than SQL. If I need to write a complex SQL query I usually Figure out the linq query, and when I am happy with the results, I click the SQL button. Magically linqpad returns the SQL code for the linq query!

## Can I debug my dll's ran in LinqPad using Visual Studio?

Believe it or not...you can...Linqpad will easily import and run dll's. Once you have pointed linqpad to dll files, and imported the namespaces, you will be good to go. To attach visual studio as a debugger simply click debug, attach to process, and click on the linqpad process, with the proper project for debugging open. Once you start running your dll's in linqpad, the debugger will pickup what you are doing and stop the process at any linebreaks. The great part about this, is you can debug class libraries with linqpad without having to fire up a secondary project to run the code in.

## TL;DR?
Linqpad converts linq to sql, and runs your .NET code from a simple scratchpad...If you suck at sql, or you want to quickly test something LinqPad rocks!