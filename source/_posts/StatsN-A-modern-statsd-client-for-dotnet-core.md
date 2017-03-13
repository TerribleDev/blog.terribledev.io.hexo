title: StatsN a modern statsd client for dotnet core, and dotnet 4.5
tags:
  - csharp
  - 'c#'
  - dotnet
  - dotnet
  - aspnet core
  - aspnet
  - dotnet core
  - statsd
  - monitoring
thumbnailImage: StatsNthumbnail.png
thumbnail_image: true
thumbnail_image_position: right
date: 2016-11-28 06:21:06
---

*tl;dr [click here](https://github.com/TryStatsN/StatsN)*

When we talk about capturing metrics in applications. One server/service that constantly is in all conversations monitoring, is [statsd](https://github.com/etsy/statsd). Incase you have never heard of it, statsd is a udp/tcp server that you send your in-code metrics to. These metrics get aggregated by statsd, and are forwarded to various backends. Some backends are services like [librato](https://www.librato.com/) or [sumologic](https://www.sumologic.com/). Other times you are sending metrics to time series databases such as [graphite](https://graphiteapp.org/) or god forbid [influxdb](https://graphiteapp.org/).

This boils down to in code you can say "log whenever this block of code is hit" or say "measure how long this function takes to execute". These stories come together to form pretty graphs, and rich alerts. All of this enabled by statsd.
<!-- more -->
In .net we have had 2 major statsd clients. There is [StatsdClient](https://github.com/Pereingo/statsd-csharp-client), which I have not used much in production, and then there is [StatsdCsharpClient](https://github.com/lukevenediger/statsd-csharp-client). Obviously the .Net community has followed in Microsoft's footsteps to name everything very literally.

I have used, and liked [StatsdCsharpClient](https://github.com/lukevenediger/statsd-csharp-client) in the past. However with no core support, and a lack of movement to [publish features that were pulled in 2 years ago](https://github.com/lukevenediger/statsd-csharp-client/issues/17#issuecomment-261921909). I have generally given up on the project. This is not to say I don't like it. Honestly, I built some amazing apps, because of it. I was really interested in the [StatsdClient](https://github.com/Pereingo/statsd-csharp-client), but unfortunately it doesn't provide an API I can really enjoy. That project uses static classes/functions which are very hard to unit test as an outsider. This project stores configuration inside of 1 static class, making multi-tenancy virtually impossible. Even though the client didn't suit my needs, I still [ported it to core](https://github.com/Pereingo/statsd-csharp-client/pull/65).

Most stastd clients often catch all exceptions. The general attitude is that statsd clients should not blow up apps, no matter what. I agree with this approach, but I still wanted a way to get at those caught errors.

>I wanted a statsd client that was fast. That used Interfaces, and that didn't slow my code down. I wanted something that worked with .net core. What I wanted didn't exist.

I really tried [working with the community](https://github.com/Pereingo/statsd-csharp-client/issues/64#issuecomment-261114334). The StatsdClient maintainers were into what I was selling. I however relized I would be breaking their library, and their customers for my own selfish desires.  So I spend most of my last few weekends building a new Statsd Client. A client that is built with Dependency Injection in mind. A client that exposes its logs. A client that tries to be **as fast as possible**. This client is called [StatsN](https://github.com/TryStatsN/StatsN). 

## Statsd clients, not as simple as you think


Ok so I know what you are thinking. This can't be that complicated right? Well statsd has no rest endpoint. Statsd does not talk http, this is either a Udp, or Tcp connection. These are simple connections, with bytes being pumped over the wire. There are many gotchas in the land of socket reuse, and capturing them effectively is not simple. Building the metrics up, and pumping them over the wire in a manor that does not hinder the calling application is not as simple as one might believe. I spent quite some time in Linqpad making sure I was making the right decision. I always picked the decision that was faster, even if the code was/is uglier.

Writing a library that prevents throwing exceptions is no trivial matter. Infact this requires [lots of unit tests](https://coveralls.io/github/TryStatsN/StatsN), and I know I didn't hit all the lines of code in my testing. Getting everything right is tricky for sure!

## Gathering metrics with StatsN

StatsN at its heart is has a simple api. Now to start you have to be running statsd somewhere (or you can use the NullChannel). In the past I used a [docker container](https://github.com/hopsoft/docker-graphite-statsd) to run statsd + graphite. At the very least you can clone the statsd code, and run it local. Printing to The console is a backend for statsd.

We can construct a new stastd client with something like the following:

`Install-Package StatsN`

```csharp

IStatsd statsd = StatsN.Statsd.New<Udp>(a=>a.HostOrIp = "10.22.2.1", Port = 8125);
IStatsd statsd = StatsN.Statsd.New<NullChannel>(a=>a.HostOrIp = "10.22.2.1", Port = 8125); // NullChannel pipes your metrics to nowhere...which can scale infinately btw

```

Then we can log metrics.

```csharp

statsd.TimerAsync("MyFunction.Timer", ()=>{

    /* code that will be timed */
});

statsd.CountAsync("MyCounter");


```

Now Statsd clients should be used as singletons in applications. These objects create either a Udp, or Tcp client which can be reused.

So in your `startup.cs` file of your aspnet core app remember to register it appropriately.

```csharp

            services.AddSingleton<StatsN.IStatsd>(provider => new StatsN.Statsd(new StatsN.StatsdOptions(){
                 HostOrIp = "127.0.0.1",
                 Port = 8125
            }));


```

You can then access it through the aspnet core DI container


```csharp

        public IActionResult Index(StatsN.IStatsd statsd)
        {
            statsd.CountAsync("HomePage.Accessed");
            return View();
        }


```

## The future of StatsN

I hope to create additional instrumented things around StatsN. I have already started working on an [MVC ActionFilter attribute](https://github.com/TryStatsN/StatsN.MvcCore.ActionInstrumentation). I'm hoping the following would time your mvc/webapi actions and results

```csharp

        [Instrument("homepage.load")]
        public IActionResult Index()
        {
            return View();
        }


```

I also plan on making a class that extends HttpClient so you can automatically instrument your http calls, how long it takes for your bytes to leave the wire, and how long it takes to download responses. These kinds of efforts really improve how developers instrument their applications for the future.

I hope you enjoy StatsN!