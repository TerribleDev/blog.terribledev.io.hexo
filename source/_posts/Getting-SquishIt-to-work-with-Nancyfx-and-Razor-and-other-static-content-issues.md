title: Getting SquishIt to work with Nancyfx and Razor (...and other static content issues)
tags:

  - c#
  - Tutorial
  - JavaScript
  - Nancyfx
  - SquishIt
  - css
  - Nancy
permalink: getting-squishit-to-work-with-nancyfx-and-razor
id: 25
updated: '2014-03-31 21:23:47'
date: 2014-03-23 02:04:20
---

SquishIt is a content bundler and minification tool. The [github](https://github.com/NancyFx/Nancy/wiki/SquishIt-with-Nancy) documentation contains exaples how to install and use it, and a [sample application](https://github.com/jetheredge/SquishIt) is provided. However I had some issues getting it to work with razor so I figured I would share these pain points with you.
<!-- more -->
## Razor cannot find Assemblies

To start my project is a Nancyfx application with razor view engine installed. I initially ran `Install-Package SquishIt`. Once installed I [ran through another tutorial](http://blogs.lessthandot.com/index.php/webdev/serverprogramming/aspnet/squishit-and-nancy/) that requires some editing of the webconfig. However my webconfig has been altered a lot already, and it did not look like the sample application. I am also not a guru in the web.config so I was kind of confused where to place the sample XML provided. I ignored the webconfig, I fired up nancy and tried to use SquishIt, only to get the following razor compile error.


`The type or namespace name 'SquishIt' could not be found (are you missing a using directive or an assembly reference?) `

It seems you **must** tell razor about squishIt's assemblies. Well It turns out there are basically 2 blocks of entries you need to add to your web.config. First you need to place `<section name="razor" type="Nancy.ViewEngines.Razor.RazorConfigurationSection, Nancy.ViewEngines.Razor"/>` inside `<configSections>` but outside of `<sectionGroup>`.

You should end up with a section config that looks like the following:

```XML
<configSections>
    <sectionGroup name="system.web.webPages.razor" type="System.Web.WebPages.Razor.Configuration.RazorWebSectionGroup, System.Web.WebPages.Razor, Version=2.0.0.0, Culture=neutral>
      <section name="pages" type="System.Web.WebPages.Razor.Configuration.RazorPagesSection, System.Web.WebPages.Razor, Version=2.0.0.0, Culture=neutral requirePermission="false" />
    </sectionGroup>
  <section name="razor" type="Nancy.ViewEngines.Razor.RazorConfigurationSection, Nancy.ViewEngines.Razor"/>
  </configSections>


```

Next paste the following XML **after** `</configSections>`

```xml
<razor disableAutoIncludeModelNamespace="false">
    <assemblies>
      <add assembly="SquishIt.Framework"/>
    </assemblies>
    <namespaces>
      <add namespace="SquishIt.Framework"/>
    </namespaces>
  </razor>
```

Once I did this the razor views could compile, and it seemed to work, but not quite...

## SquishIt cannot resolve file paths

Once I got it up and running, things did not seem right. So I started combing through google. I stumbled across a [thread](https://groups.google.com/forum/#!msg/squishit/YBsUiL9v1Ow/7lBJmMIHGMoJ) where the creator of SquishIt noted SquishIt was having issues with resolving file paths. This was caused by a change to Nancy.

He notes a [commit](https://github.com/AlexCuse/SquishIt.NancySample/commit/7338026d4d425960151978171596749066b460bc) to the sample application that fixes the problem. In nuget I updated SquishIt with the `-pre` flag so I could get the latest release. Once I did I implemented the following class (from the gitcommit):

```c-like

using Nancy;
using SquishIt.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Class.Web
{
    public class NancyPathTranslator : IPathTranslator
    {
        private readonly IRootPathProvider _rootPathProvider;

        public NancyPathTranslator(IRootPathProvider rootPathProvider)
        {
            _rootPathProvider = rootPathProvider;
        }

        public string ResolveAppRelativePathToFileSystem(string file)
        {
            // Remove query string
            if (file.IndexOf('?') != -1)
            {
                file = file.Substring(0, file.IndexOf('?'));
            }

            return _rootPathProvider.GetRootPath() + "/" + file.TrimStart('~').TrimStart('/');
        }

        public string ResolveFileSystemPathToAppRelative(string file)
        {
            var root = new Uri(_rootPathProvider.GetRootPath());
            return root.MakeRelativeUri(new Uri(file, UriKind.RelativeOrAbsolute)).ToString();
        }
    }
}



```
And then added

```c-like

Bundle.ConfigureDefaults().UsePathTranslator(new NancyPathTranslator(new AspNetRootSourceProvider()));



```



Which seemed to work. I believe if you have your file paths be the same as the paths called by the HTML, it will probably work fine without the above fix.

## Scripts/ folder doesn't work

This isn't actually a SquishIt problem, but I didn't notice this until I installed SquishIt. Files in a Scripts/ folder will not be served up by Nancy.

Back to Google I went, and I found my answer on [stack overflow](http://stackoverflow.com/a/13517803). Apparently Nancy only uses Content/ as the content directory, for static content.  I ended up adding the following to my ConfigureConventions override.

```c-like

 protected override void ConfigureConventions(Nancy.Conventions.NancyConventions nancyConventions)
        {
            nancyConventions.StaticContentsConventions.AddDirectory("Scripts","Scripts/");
            base.ConfigureConventions(nancyConventions);
        }


```

The AddDirectory requires 2 strings, the first being the route to expect, the second is the directory it needs. This will enable the scripts folder to work in its entirety. You can use this to add other content directories. For me this worked fine.


## Serving content

Now that it all worked I added `Bundle.Css().Add("~/Content/bootstrap.css").AsCached("bootstrap", "~/assets/css/bootstrap");` to my ApplicationStartup override. Created a module to serve up the static content (stolen from [github](https://github.com/NancyFx/Nancy/wiki/SquishIt-with-Nancy)) .


```c-like


public class ServeAsset : NancyModule
    {
        public ServeAsset():base("/assets")
        {
            Get["/js/{name}"] = parameters => CreateResponse(Bundle.JavaScript().RenderCached((string)parameters.name), Configuration.Instance.JavascriptMimeType);

            Get["/css/{name}"] = parameters => CreateResponse(Bundle.Css().RenderCached((string)parameters.name), Configuration.Instance.CssMimeType);
        }

        Response CreateResponse(string content, string contentType)
        {
            return Response
                .FromStream(() => new MemoryStream(Encoding.UTF8.GetBytes(content)), contentType)
                .WithHeader("Cache-Control", "max-age=45");
        }
    }


```


Then added ` @Html.Raw(Bundle.Css().RenderCachedAssetTag("bootstrap"))` to my razor view, and by magic it works.

As a side note, it will only minify if you're not in debug mode. So if you're application's webconfig has `<compilation debug="true" targetFramework="4.5">` you may want flip it to false to see the minified files.

This behavior can be overridden with the `.ForceRelease()` as part of your bundle. ex. `Bundle.Css().Add("~/Content/bootstrap.css").ForceRelease().AsCached("bootstrap", "~/assets/css/bootstrap");`

## Conclusion

Well after the work above I was finally generating minified files. SquishIt's ability to minify quickly is very nice. The way it manages files reminds me of the [MVC4 Bundling](http://www.asp.net/mvc/tutorials/mvc-4/bundling-and-minification), but SquishIt allows for much greater control over the process.
