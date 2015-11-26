title: 'Value types vs Reference Types in C#'
tags:

  - c#
  - Tutorial
  - dotnet
permalink: value-types-vs-reference-types-in-c-and-why-it-matters
id: 27
updated: '2015-07-26 01:08:11'
date: 2014-04-09 22:21:19
---

In C# there are two kinds of types...Value and reference...

## What are Reference Types?

Reference types in C# are mostly objects and strings. These are types when placed on a stack refer to a memory address in the heap.

## What are Value Types?

Value types make up the bulk of types in c#. These include int, float, double, long, bool, etc. These types values are only stored in the stack.

## Stack? Heap? What's the difference?

To put it short, the **stack** is a series of memory blocks (like a scratch pad) that is used for the current thread. The stack is used for basic property data access. Accessing the stack is very rapid, as its only used for trivial data. The heap is an area of memory for dynamic memory allocation. The heap is used to store things in data that are not value types, usually objects and strings. The heap is slower to access, but larger in size.

## Reference type tripping points

Reference types are basically pointers. These pointers can trip you up in interesting ways. For example suppose you have an object called MyObjectName:

```
var MyObjectName = new SomeClass();

```

and you decide to make someone else's object name the same as you're name 

```

var OtherObjectName = MyName;

```

When you change MyName to be something else, you will also change OtherName.

This is because objects are a reference type. On the stack the object is a pointer reference to the heap. When you make OtherName equal you are pointing it to the same memory address as MyName. You can see this in action [here](https://dotnetfiddle.net/pGh3fT)

```
var MyName = new SomeClass();
var OtherName = MyName;
MyName = MyName.Name = "Joe";
//OtherName will now equal Joe

```

This is also the same for array's if you make 1 array equal another, you will not have 2 array's with the same value. You will have 2 variables that point to the same array.

### So the same must work for value types right?

**No**

If you have 2 ints and assign one int to equal the other. The value on the stack will be copied to that int, and since the stack value is the actual value they will be independent of each other.


## Boxing and Un-Boxing

When you have a value type and you want it on the heap you must convert it to an object. This is called boxing

```
var val = 3;
var x = (object)val;

```

However once you do this, the two variables will be independent from each other. So if you change x you won't change val and vice-versa.

To get the object back on the stack you must cast it back into an int. This is called un-boxing

```

var y = (int)x;

```

