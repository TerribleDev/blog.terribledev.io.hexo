title: 'Wiring up client side logs into c#/node.js logging frameworks'
tags:

  - csharp
  - logging
  - library
permalink: wiring-up-client-side-logs-into-c-sharp-logging-frameworks
id: 60
updated: '2015-11-01 08:53:04'
date: 2015-11-01 08:22:07
---

Around a year ago I joined a new team where I work, and this team was starting to undertake a full rewrite of their code. We were going from a full c#/mvc app to a tiny c# api, and a very big SPA.

Early one one of the **huge** things to do was to make sure that our JavaScript error logs could land in our Log4Net infrastructure. I started to write something to do just that, and as I was coding I quickly realized this was less trivial that it sounded. We had something internal we could use, but it was tied to a lot of other code that we didn't want to pull in.

I started Bingling around and I stumbled across [jsnlog](http://jsnlog.com/). JSN log lets you quickly wire up your client side logs to your server. I have been able to get PR's into the [code base](https://github.com/mperdeck/jsnlog) and the guy behind it has been very friendly to me when I have had questions.
<!-- more -->
When you install the nuget package it drops this into your app_start.

```csharp

using System;
using System.Web.Routing;
using System.Web.Mvc;

[assembly: WebActivatorEx.PostApplicationStartMethod(
    typeof(EmptyLog4Net.App_Start.JSNLogConfig), "PostStart")]

namespace EmptyLog4Net.App_Start {
    public static class JSNLogConfig {
        public static void PostStart() {
            // Insert a route that ignores the jsnlog.logger route. That way,
			// requests for jsnlog.logger will get through to the handler defined
            // in web.config.
			//
			// The route must take this particular form, including the constraint,
			// otherwise ActionLink will be confused by this route and generate the wrong URLs.

            var jsnlogRoute = new Route("{*jsnloglogger}", new StopRoutingHandler());
            jsnlogRoute.Constraints = new RouteValueDictionary {{ "jsnloglogger", @"jsnlog\.logger(/.*)?" }};
            RouteTable.Routes.Insert(0, jsnlogRoute);
        }
    }
}
```

The whole thing is a html handler, so this code just simply makes sure the handler gets the first route.

When you are going to render a page you have to inject this razor:

`@Html.Raw(JSNLog.JavascriptLogging.Configure())` and the jsnlog javascript file.

Then whenever you want to log anything client side you can do the following.

```javascript
JL("jsLogger").fatal("client log message");
```

You can also set jsnlog as the global js error handler.

```javascript
window.onerror = function (errorMsg, url, lineNumber, column, errorObj) {
    // Send object with all data to server side log, using severity fatal,
    // from logger "onerrorLogger"
    JL("onerrorLogger").fatalException({
        "msg": "Exception!",
        "errorMsg": errorMsg, "url": url,
        "line number": lineNumber, "column": column
    }, errorObj);

    // Tell browser to run its own error handler as well   
    return false;
}

```

The docs are quite good, and it seems to work fine as a commonjs module (since we browserify things). The tool is super configurable through the web.config, and you can change the url it logs to.


```xml

<configuration>
    ...

    <!-- Example of web.config based configuration -->
    <jsnlog maxMessages="5">
        <logger name="mylogger" level="INFO" />

        <ajaxAppender name="myappender" batchSize="2" />
        <logger name="mylogger2" appenders="myappender"/>
    </jsnlog>
</configuration>

```


JSNLog is a great way to get your client side logs into your server infrastructure fast. The library has fantastic support for node, and every major [.NET logging framework](https://www.nuget.org/packages?q=jsnlog). Someone in the community even made a php plugin! The [examples](https://github.com/mperdeck/jsnlogSimpleWorkingDemos) are endless

Overall I am really pleased with JSNLog, it filled a need that I needed, and it meant I was able to focus on what I did best, not figure out how logging worked.
