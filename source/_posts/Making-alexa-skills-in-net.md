title: Making alexa skills in .net
date: 2016-12-10 11:32:56
tags:
- c#
- .net
- alexa
---

Ok so I've been in the alexa skills market recently, and obviously amazon wants you to use AWS Lambda for your skills. If you are like me, you have a ton of stuff in azure app service (the PaaS of azure). Azure app service supports nodejs, java, python, and of course .net. The two sdk's amazon ships (node, java) do not tie in with a web stack, and are obviously thought of as being used with Lambda. 
<!-- more -->
When you don't host your code in aws, or use the alexa sdk's you must use crypto magic to authenticate the requests from amazon, are actually from amazon. I was going to use the ruby sdk's the community has put out, but I didnt see any code that verified requests. I noticed the [alexa .net sdk](https://github.com/AreYouFreeBusy/AlexaSkillsKit.NET) supports verifying requests from amazon, and since its .net I know it will work great in azure.


Getting Started:

Ok, so the alexa .net sdk is for the full framework only, and its built for webapi. The best way to get going is in visual studio `file -> new project -> ASP.NET Web Application .net framework` A dialog comes up, and I picked `Azure API App`.

![dialog picker](dialog.png)

Now you have an empty webapi project. We don't need swashbuckle/swagger so lets get rid of that

In the package manager console `Tools -> NuGet Package Manager -> Package Manager Console`

run `uninstall-package Swashbuckle` 
run `uninstall-package Swashbuckle.Core` 

delete `App_Start/SwaggerConfig.cs`

now go to  `WebApiConfig.cs` and delete this block of code, we'll stick with attribute routing only.


```csharp 

			config.Routes.MapHttpRoute(
				name: "DefaultApi",
				routeTemplate: "api/{controller}/{id}",
				defaults: new { id = RouteParameter.Optional }
			);
```

Now Rename the `ValuesController` to `AlexaController` and delete all the methods in the file.


Your AlexaController should look like this:


```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApplication6.Controllers
{
	public class AlexaController : ApiController
	{

	}
}


```

Ok now we need to add an endpoint to take traffic from amazon on. Amazon will do a post with a json document to `/` so we need to allow that. We should also make a livecheck interface for get's and head requests.

First lets install the alexa sdk. `Install-Package AlexaSkillsKit.NET`

Ok now we need to add a livecheck endpoint.

```csharp

	public class AlexaController : ApiController
	{
		[Route("")]
		[HttpGet]
		[HttpHead]
		public IHttpActionResult root()
		{
			return this.Ok("Im Alive");
		}
	
	}

```

Now lets start using the sdk. The sdk requires