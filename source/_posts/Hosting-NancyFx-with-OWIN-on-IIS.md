title: Hosting NancyFx with OWIN on IIS
tags:

  - Nancyfx
  - Nancy
  - IIS
  - OWIN
permalink: nancyfx-owin-iis
id: 41
updated: '2015-03-15 20:39:17'
date: 2015-02-24 11:07:01
---

So I was quite confused about hosting Nancyfx on OWIN under IIS. [Parts](https://github.com/NancyFx/Nancy/wiki/Managing-static-content#extra-steps-required-when-using-microsoftowinhostsystemweb) of the Nancy wiki led me slightly astray.

Here is the simple guide.

Make sure you Install the following nuget packages (if you havn't already).

```
Nancy.Owin
Microsoft.Owin.Host.SystemWeb

```


Owin uses a class called Startup.cs to do basic configuration. We need to add nancy to the app, and then add additional StageMarkers used by the ASP pipeline. 

Startup.cs

```csharp

using Microsoft.Owin.Extensions;
using Owin;

public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        app.UseNancy();
        app.UseStageMarker(PipelineStage.MapHandler);
    }
}


```

## Static Files

Here you need to make a choice, do you want to have IIS manage the static files, or use the OWIN module. Personally I go for IIS. I don't have any data on this, but I have a feeling IIS might be faster to serve static content.

#### IIS Static Hosting

runAllManagedModulesForAllRequests when set to true does not allow **Native** IIS modules to run like the static files module. So we will want to turn that off if we want IIS to handle static files.

web.config

```

<system.webServer>
    <modules runAllManagedModulesForAllRequests="false" />
</system.webServer>

```

#### OWIN Static Hosting

Nuget Package

`Install-Package Microsoft.Owin.StaticFiles`


Web.config

```

<system.webServer>
    <modules runAllManagedModulesForAllRequests="true" />
</system.webServer>

```

Startup.cs

```csharp

public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        app.UseFileServer(new FileServerOptions()
        {
        RequestPath = new PathString("/foo"),
        FileSystem = new PhysicalFileSystem(@".\web"),
        });
        app.UseNancy();
        app.UseStageMarker(PipelineStage.MapHandler);
    }
}



```

### Put, Head, Delete

if you need Put, Head or Delete requests add the following to your webconfig


```

<system.webServer>
<handlers>
      <remove name="ExtensionlessUrlHandler-Integrated-4.0" />
      <remove name="OPTIONSVerbHandler" />
      <remove name="TRACEVerbHandler" />
      <add name="ExtensionlessUrlHandler-Integrated-4.0" path="*." verb="*" type="System.Web.Handlers.TransferRequestHandler" preCondition="integratedMode,runtimeVersionv4.0" />
</handlers>
</system.webServer>


```


## Windows Authentication

To use Windows authentication you need to have the authentication type in your web.config


```
	<system.web>
  <authentication mode="Windows"/>
  	</system.web>

```

To actually be able to get the username of the user in code, you can use the following (assume .net 45).

```csharp

public class User : IUserIdentity
{
    private readonly ClaimsPrincipal claimsPrincipal;

    public User(ClaimsPrincipal claimsPrincipal)
    {
        this.claimsPrincipal = claimsPrincipal;
    }

    public string UserName { get { return claimsPrincipal.Identity.Name; } }
    public IEnumerable<string> Claims { get { return claimsPrincipal.Claims.Select(c => c.ToString()); } }
}
public class Bootstrapper : DefaultNancyBootstrapper
{
    protected override void RequestStartup(TinyIoCContainer container, IPipelines pipelines, NancyContext context)
    {
        pipelines.BeforeRequest += ctx =>
        {
            ctx.CurrentUser = new User(Thread.CurrentPrincipal as ClaimsPrincipal);
            return null;
        };
    }

}

```

