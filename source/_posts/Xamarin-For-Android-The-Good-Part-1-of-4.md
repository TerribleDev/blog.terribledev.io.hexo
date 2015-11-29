title: 'Xamarin For Android The Good: (Part 1 of 4)'
tags:

  - Android
  - Xamarin
  - Development
  - Review
  - c#
  - Xamarin For Android
permalink: xamarin-the-good-the-bad-and-the-ugly
id: 6
updated: '2014-02-25 00:49:59'
date: 2014-02-18 01:58:36
---

## Introduction

* Part One
* [Part Two](/xamarin-for-android-the-bad-part-2-of-4/)
* [Part Three](/xamarin-for-android-the-ugly-part-3-of-4/)
* [Part Four](/xamarin-the-conclusion-part-4-of-4/)

This will be a series of blog entries where I discuss the Xamarin platform for Android.

I really enjoy C# programming language *(JavaScript second)*....Linq, Generics, anonymous methods, and Visual Studio are just some of the reasons I like it. [Xamarin](http://xamarin.com/) is a platform that gives you the ability you to write Android applications in c#.

When I heard about [Xamarin](http://xamarin.com/) I naturally, wanted to give it a shot. Having tried Eclipse, and Android Studio for android development I was no idiot when it came to the platform. So I got a license, and did nothing with it for six months, until a few weeks ago. After only 3 days I created [Ultimate Gravatar Sync](https://play.google.com/store/apps/details?id=ultimategravatarsync.ultimategravatarsyncfree). An app that sync's your contacts gravatar images to their picture in your phone.

## C# with no compromise
The [Xamarin](http://xamarin.com/) platform uses mono, and some kind of voodoo bindings to the Java libraries to make it work. I wont go in depth, but the native features of the C# language are there to use. I never felt like my hands had been tied, that all of a sudden I couldn't use a library that is normally part of the [GAC](http://msdn.microsoft.com/en-us/library/yf1d93sz(v=vs.110).aspx) (Global Assembly Cache). When I needed multi-threading, System.Threading was there, and when I needed to use C# Generics I had no issues implementing them.

![Xamarin execution](/content/images/2014/Feb/architecture1.png)

## Manage Android Manifest files
One of the things that blew me away about the platform, was that I never had to add anything to my manifest file. For those of you whom don't know, Android requires an XML config detailing the permissions you require, and the classes you have in your application.

Simple decoration such as:



```csharp
[Activity(Label = "Label", MainLauncher = true, Icon = "@drawable/Icon")]
```

Will Generate in your manifest file as:
```xml
<pre>
<activity
android:label="Label"
             android:name=".logoActivity" >
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </pre>
```
Adding permissions is also easy:

```csharp
[assembly: UsesPermission(Android.Manifest.Permission.Internet)]
```


## Using Java Libraries
[Xamarin](http://xamarin.com/) provides some kind of crazy visual studio project, that will essentially provide c# bindings to Java libraries you require. To bind Simply create a Java Binding project, adding the .Jar files, and then build. Watch the magic happen. They do [note](http://docs.xamarin.com/guides/android/advanced_topics/java_integration_overview/binding_a_java_library_(.jar)/) that you sometimes need to do some configuration for certain libraries, however I had no issues with the one I tried. On top of that if you really needed to, you could access the [Java Native Interface](http://docs.xamarin.com/guides/android/advanced_topics/java_integration_overview/working_with_jni/) for even more power.
