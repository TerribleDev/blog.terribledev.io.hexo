title: Why I avoid switch statements in c++
tags:

  - c++
  - things I avoid
permalink: why-i-avoid-cplusplus-switch-statements
id: 58
updated: '2015-10-15 17:34:39'
date: 2015-10-04 12:26:38
---

So one thing that kills me a lot in c++ is the switch statement. As you all know switch statements look like the following.

```cpp
auto s = 0;

switch(s)
{
   case 0:
      doSomething();
      break;
   case 1: 
     doSomething1();
     break;

}

```

Now the first thing that bothers me about C++ switch statements is that, you can fall through a case. What I mean by that is that if `case 0` did not have a `break;` statement, you will go directly into the next case (and execute `doSomething1()`)

This often bites me in particular, becase I forget to add the `break;`

### Switching on strings

In c++ strings are not supported as a type. Strings in c++ are actually char Arrays, which means that the switch statement cannot infer switching on strings like Java or C#.

So ultimately switching on strings cannot be done, and if/else if is what has to be used for strings.

So I can't use `switch` except for the other common types, and I can shoot myself in the foot with the behavior of the switch. So I avoid it completely.