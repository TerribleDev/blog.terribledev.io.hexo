title: 'c++,  when should I use the stack or heap?'
tags:

  - c++
  - performance
permalink: c-strings
id: 57
updated: '2015-10-18 11:00:24'
date: 2015-10-04 11:58:18
---

So I have started learning c++ recently, and as a .NET/Java developer I always want to write the following code.

`var s = new myClass()`.

In c++ you have to manage memory yourself, there is no garbage collector.

If you do not use the new keyword `var s = myClass()` you will create that class and assign it to s on the `stack`.

Any stack variables will be cleaned at the end of the block, so in this case s will be cleaned. However if you use `var s = new myClass()` s will be allocated onto the **heap** and must be deleted, otherwise memory leaks will occur.

To clean the variable you must call `delete s` when you are done with the variable, this will cause the memory in the heap to be cleaned.
<!-- more -->
Now this comes back to *what is a stack and heap* I wrote a [blog post](/value-types-vs-reference-types-in-c-and-why-it-matters/) about value and reference types in c# and this talk touches on a lot of the same subject. Basically a stack in c++ is a 1mb scratch pad of memory, that is really fast to access. The heap is a larger pool of memory for dynamic allocation, but can be slower to access.

So I was thinking to myself, well when should I allocate on the stack vs heap. The stack is limited in size, and if you go over that size you will cause a stack overflow. Also I want my c++ app to be fast, so I would like to allocate on the stack often, and I don't have to worry about cleaning up stack objects. That being said the heap is still quite fast so I shouldn't avoid the heap.

Consider any or all of the following rules to put objects into the stack. **Note:** You don't need to meet all of them.

#### Stack Allocate:
* Immutable
* Under 32 bytes (Ideally around 16 bytes)
* It won't require being put into heap often
* Short Lived
* Embedded in other objects
