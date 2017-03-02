title: Making a minimal webapp with dotnet core
date: 2017-03-01 20:11:18
tags:
  - csharp
  - c#
  - aspnet core
  - dotnet core
---


Recently I wanted to make myself a short url host. Really, I made this not to make short urls, but to make memorable urls for myself.

<!-- more -->

> I wanted to say goto [aka.terribledev.io/docker101](https://aka.terribledev.io/docker101) for my docker101 class


This is clearly a very simple webapp. Basically a dictionary of path's to 301's. Probably the simplest WebApplication anyone can make. [So I made it](https://github.com/terribledev/aka.terribledev.io).

So, I'm sure you are wondering. Well why am I reading this blog? Well, my app does not use mvc, or any web framework. My app uses the mvc core 1.0 router as middleware. This was talked about a while back on an episode of [live.asp.net](https://live.asp.net).

I first just used the [aspnet yeoman generator](https://www.npmjs.com/package/generator-aspnet), asking for webapi. I then deleted the only controller I was given, and got rid of most of the mvc packages with the exception of `Microsoft.AspNetCore.Routing`. I then just modified my `Startup.cs` file to look like below.

Essentially I add the routing package to the container, and then have have the app use the router mapping `docker101` to the proper url. Easy right?



```csharp


        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)

            services.AddRouting();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            loggerFactory.AddDebug();
            app.UseRouter(a=>{
                foreach(var route in Routes.RoutesDictionary)
                {
                    a.MapGet("docker101", handler: async b=>{
                        b.Response.Redirect("https://blog.terribledev.io/Getting-started-with-docker-containers/", true);
                    });
                }
            });
        }

```

Ok, so what is the result? Well, extremely fast url parsing thanks to the mvc router, and a really lightweight application. Since we have no session, or even convention based action resolution. Our app is extremely thin, and fast.


So, thank Microsoft for really making the components mvc modular. This provides a very small, and lightweight service!