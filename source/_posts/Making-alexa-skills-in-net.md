title: Making alexa skills in .net
date: 2017-3-13 11:32:56
tags:
- csharp
- dotnet
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


First lets install the alexa sdk. `Install-Package AlexaSkillsKit.NET`


The sdk requires us to make a class that inherits from speechlet. Speechlet, the base class gives us everything we need to make a skill. The base class has a bunch of methods we can override. We usually have to return a SpeechletResponse which is simply an object that describes to alexa what to say back. Usually this is just some simple text to read back to the user.

```csharp

	public class AlexaResponse : Speechlet

	{

		



		public override SpeechletResponse OnIntent(IntentRequest intentRequest, Session session)

		{
			//this will fire when your users pick an intent for example if your bot is named tommy and you say alexa ask tommy whats the weather today this will fire the weather intent
		}



		public override SpeechletResponse OnLaunch(LaunchRequest launchRequest, Session session)

		{

			//this will fire on the root of your alexa skill
			//for example if your skill is named tommy, and you just say alexa ask tommy, alexa open tommy, alexa tommy. This will fire with no commands

		}



		public override void OnSessionEnded(SessionEndedRequest sessionEndedRequest, Session session)

		{

		}



		public override void OnSessionStarted(SessionStartedRequest sessionStartedRequest, Session session)

		{
			//there are mechanisms to handle sessions in the sdk if you need it.
		}
```

```csharp

			return new SpeechletResponse()

			{

				//a sample response
				OutputSpeech = new PlainTextOutputSpeech() { Text = "Hi, my name is tommy" },

				ShouldEndSession = true

			};
```

Ok now we need to add an endpoint to take traffic from amazon on. Amazon will do a post with a json document to `/` so we need to allow that. We should also make a livecheck interface for get's and head requests.

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
		
		[Route("")]
		[HttpPost]
		public HttpResponseMessage Post()

		{
			return new AlexaResponse().GetResponse(this.Request);

		}
	}
```

That is basically it. the SDK will handle verifying the requests from amazon, and will call the overriden methods to deal with your alexa skill. Now you can deploy this to something like azure app services, and register yours skill in [the developer console](https://developer.amazon.com). Once registered, the skill should be avalible to you assuming you signed into your alexa device with the same account. You can see [a working sample here](https://github.com/TerribleDev/alexa-excuse.net).