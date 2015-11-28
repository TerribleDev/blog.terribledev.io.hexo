title: 'Xamarin For Android The Bad: (Part 2 of 4)'
tags:

  - Development
  - Review
  - c#
  - Xamarin For Android
  - Xamarin
permalink: xamarin-for-android-the-bad-part-2-of-4
id: 7
updated: '2014-04-01 23:18:01'
date: 2014-02-18 02:54:43
---

* [Part One](/xamarin-the-good-the-bad-and-the-ugly/)
* Part Two
* [Part Three](/xamarin-for-android-the-ugly-part-3-of-4/)
* [Part Four](/xamarin-the-conclusion-part-4-of-4/)

[Xamarin](http://xamarin.com/) is a very good platform, but like everything it has parts that are not so great.

## Documentation

One thing that was really hard for me, was to find documentation that was newer than 2012. Android has made great strides with Ice Cream Sandwich, and Jelly Bean. New features such as [fragments](http://developer.android.com/guide/components/fragments.html) have breathed life into the platform.

The [Xamarin](http://xamarin.com/) documentation provides examples even with the newest features, but there is something about it that feels lacking. Almost like it was thrown together at the last minute. They have been doing webcasts to improve the knowledge out in the wild, but googling the answer to your problem just won't do. Part of the problem is that most developers write in Java, and only bigger companies can afford the [hefty license fees](https://store.xamarin.com/) that come with full support.

The user community was helpful at times, but I often found myself wandering though [GitHub](http://github.com) hoping my answer could be found in some mystical repo; Eventually having to study the full implementation to find the answer I needed.

## Finding help

Although [Xamarin](http://xamarin.com) has a forum where helpful users help each other, there are not nearly as many people coding on [Xamarin](http://xamarin.com) than regular Java. Figuring out how to get something complicated working, was a nightmare. I'd look at a Java implementation, and then try to translate it into its [Xamarin](http://xamarin.com) counterpart, which sometimes was far removed than the Java code. There are some examples of [Xamarin](http://xamarin.com) for android out there, but nothing that really delves deep into manipulating the inner workings of the phone. I saw this especially when trying to edit contacts programatically. [Xamarin](http://xamarin.com) support seemed helpful, but far too expensive for most freelance developers. This was a pretty huge put-off. If I went the Java route my questions would be answered with a simple search of [stack overflow](http://stackoverflow.com).

## Boilerplate

Like most things Java, Android requires a lot of boilerplate. For a developer like myself, whom avoids Java this was a problem. I would have thought that [Xamarin](http://xamarin.com/) would have abstracted out more of the boilerplate than they did. On the one had, having my code look somewhat familiar when I see Java examples was nice, but on the other hand because the API is still different often the Java versions would not be close enough to fully help. My main problem with this, is if I really wanted to write boilerplate I would have used the Java libraries myself. They did make a start for this by generating the manifest file automatically, but I feel it needs to go further to fully mature this platform as a viable alternative to Java.
