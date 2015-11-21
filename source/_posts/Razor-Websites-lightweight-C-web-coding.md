title: 'Razor Websites, lightweight C# web coding'
tags:

  - c#
  - asp.net
permalink: razor-websites-super-lightweight-c-webdev
id: 49
updated: '2015-10-02 17:00:33'
date: 2015-09-03 17:56:34
---

I was exploring around github, and I stumbled upon an interesting project called [Miniblog](https://github.com/madskristensen/miniblog) which was a lightweight blog engine written in c#. The thing that immediately stood out to me was the lack of a `.csproj` file. 

>As I dug around the code I realized this was not a Web App, which most of us were familiar with, but a websites project. I then suddenly realized that the whole thing only used razor!

I am a huge fan of [Nancyfx](http://nancyfx.org/) because its much more lightweight than the MVC framework created at Microsoft. To say the least I am a massive fan of small tools, and micro frameworks. So when I realized this whole thing was powered by razor only I was immediately impressed.

I decided to dig around on the internet to see if anyone else was talking about this. I found out quickly that it has been possible for [some time](http://www.hanselman.com/blog/ExploringASPNETWebPagesAFullyfeaturedMiniBlogUsingJustRazor.aspx), but I didn't find many references about it.

The one thing that bummed me out about the Miniblog example was that it was not a web app. You can use nuget packages will websites, but you cannot make references to other projects in the solution. This was a problem for me, and unlike websites, web app's are precompiled which reduces application startup time.

## Why use Razor Websites?

The biggest reason to use razor websites, is the speed. Razor websites have almost no routing code, and are much more lightweight than a full framework. They are good for small projects, but for complex data access applications a more robust framework should be used.

## Creating a razor website as a web app project

To create a razor website as a web app project, first create an empty web project, and then just add the following nuget packages.

```xml
Microsoft.AspNet.Razor
Microsoft.AspNet.WebPages
Microsoft.Web.Infrastructure

```

Now you can drop razor files anywhere. Your routes will be the location of your razor pages, so for instance your home page should be `Index.cshtml` and it should be at the root of your web project. If you had a file called about.cshtml on the root, the route would be `/about` if it were in a subfolder it would be `/subfolder/about`.

I even did some tricks where I put razor files in a folder called `api` and had logic in those views to deserialize the request body to models, and place them in a datastore. This gave the illusion that my ajax calls were somehow hitting some complex API.


## Things to note

The `@model` will not work in razor. You can pass an object to another view during a render, and that file can get the object with `this.Model`

If you return something other than text remember to set the content type, and don't hesitate to write directly to the output stream.

```csharp
    this.Response.ContentType = "application/json";
    this.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(Database.Data));

```