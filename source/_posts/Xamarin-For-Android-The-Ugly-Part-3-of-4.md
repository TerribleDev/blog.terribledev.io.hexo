title: 'Xamarin For Android The Ugly: (Part 3 of 4)'
tags:

  - Xamarin
  - Development
  - Review
  - c#
  - Xamarin For Android
permalink: xamarin-for-android-the-ugly-part-3-of-4
id: 8
updated: '2014-02-20 13:15:28'
date: 2014-02-18 03:16:17
---

* [Part One](/xamarin-the-good-the-bad-and-the-ugly/)
* [Part Two](/xamarin-for-android-the-bad-part-2-of-4/)
* Part Three
* [Part Four](/xamarin-the-conclusion-part-4-of-4/)

I had some problems with Xamarin. Somethings are ugly, but with plastic surgery almost anything can become beautiful.

## Components

Xamarin has its own software packages available for download. I tried a lot of them out, some were good others not so much. One of my biggest gripes was that Google Play Services currently has a [bug](http://stackoverflow.com/questions/20125720/xamarin-android-builds-deployments-are-very-slow-how-to-speed-them-up) that makes builds **really** slow. Other packages were either genius, or were simply unimpressive. The components have their own package manager, and it does do a decent job of keeping them in order. I have to admit though Xamarin has its own set of componants that do [in-app billing](http://components.xamarin.com/gettingstarted/xamarin.inappbilling), and [access phone data](http://components.xamarin.com/view/xamarin.mobile) without having to lift much of a finger.

![Moving at the build speed of Play Services](/content/images/2014/Feb/turtle_Alan_Rees.jpg)

### Component Documentation

A real put down is that only some of the components have adequate documentation. For instance for me to get [admob](http://www.google.com/ads/admob/) working with play services; I had to look at the Java documentation, and try to figure out how its supposed to be done on Xamarin. This wasn't to difficult, but admob is well used. I would have assumed the documentation would have covered it, but couldn't find anything.

## Visual Studio Designer

The Visual studio designer for Android at first seemed like the best thing since sliced bread! I was able to get a UI up and running in no time. Making my app work for tablets, and mobile phones alike was simple. However, once in a while it would be stubborn, and stop working. I'm not sure if it was something I was doing, but I felt like it would bomb out and I would have to restore the XAML file to continue. 

The editor really isn't great for designing ListViews, working with fragments, or making something that will scale easily. Often it made things exact pixel widths instead of using dots per inch. To keep it short, I still had to do plenty of editing of the source manually (which was not too bad). Making the theme stick on the default view was a pain, until I realized that I could ignore the editor, and decorate my MainActivity with the theme I wanted to use.

<pre>[Activity(Label = "Label", MainLauncher = true, Icon = "@drawable/Icon", Theme = "@android:style/Theme.Holo.Light")]</pre>