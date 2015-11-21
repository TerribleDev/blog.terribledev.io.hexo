title: Anti-Forgery Tokens in NancyFX with Razor
permalink: anti-forgery-tokens-in-nancyfx-with-razor
id: 33
updated: '2014-06-11 20:00:34'
date: 2014-06-11 19:34:13
tags:
---

Getting started with anti-forgery tokens in NancyFX with razor views is pretty simple.

To start you need to enable csrf in application startup. 

```csharp

 protected override void ApplicationStartup(TinyIoCContainer container, IPipelines pipelines)
 {
  	Csrf.Enable(pipelines);
    base.ApplicationStartup(container, pipelines);
 }

```

Now you need to create a token on the get request that returns the form


```csharp


 Get["/"] = x =>
            {
                this.CreateNewCsrfToken();
                return View["Index"];
            };


```

Now in your view you need to render the token


```csharp

<form method="POST">
    Username <input type="text" name="Username" />
    <br />
    Password <input name="Password" type="password" />
    <br />
    <input type="submit" value="Login" />
    @Html.AntiForgeryToken()
</form>

```

Finally you need to authenticate the token on the post request


```csharp
Post["/"] = x =>
{
	try
	{
		this.ValidateCsrfToken();
	}
	catch (CsrfValidationException)
	{
		return Response.AsText("Csrf Token not valid.").WithStatusCode(403);
	}
    //do something
};



```