title: StatsN A modern statsd client for dotnet core
tags:
- csharp
- c#
- dotnet
- .net
- aspnet core
- aspnet
- dotnet core
- statsd
- monitoring
---

When we talk about running applications in production, and we want to capture metrics. One server/service that constantly is in all conversations monitoring, is [statsd](https://github.com/etsy/statsd). Incase you have never heard of it, statsd is a udp/tcp server that you send your in-code metrics to. These metrics get aggregated by statsd, and are forwarded to various backends. Some backends are services like [librato](https://www.librato.com/) or [sumologic](https://www.sumologic.com/). Other times you are sending metrics to time series databases such as [graphite](https://graphiteapp.org/) or god forbid [influxdb](https://graphiteapp.org/).

This boils down to in code you can say "log whenever this block of code is hit" or say "measure how long this function takes to execute". These stories come together to form pretty graphs, and rich alerts. All of this enabled by statsd.

In .net we have had 2 major statsd clients. There is [StatsdClient](https://github.com/Pereingo/statsd-csharp-client), which I have not used much in production, and then there is [StatsdCsharpClient](https://github.com/lukevenediger/statsd-csharp-client). Obviously the .Net community has followed in Microsofts footsteps to name everything very literally.

I have used, and like [StatsdCsharpClient](https://github.com/lukevenediger/statsd-csharp-client). With no core support, and a lack of movement to [publish features that were pulled in 2 years ago](https://github.com/lukevenediger/statsd-csharp-client/issues/17). I have generally given up on the project. This is not to say I don't like it. Honestly I build some amazing apps, because of it. However its became the past for me.

I was really interested in the [StatsdClient](https://github.com/Pereingo/statsd-csharp-client), but unfortunately it doesn't provide an API I can really enjoy. That project uses static classes/functions which are very hard to unit test as an outsider. Also this project stores configuration inside of 1 static class, making multi-tenancy virtually impossible.

Most stastd clients often catch all exceptions. The general attitude is that statsd clients should not blow up apps, no matter what. I agree with this approach, but I still wanted a way to get at those caught errors.

>I wanted a statsd client that was fast. That used Interfaces, and that didn't slow my code down. I wanted something that worked with .net core. What I wanted didn't exist.

I really tried [working with the community](https://github.com/Pereingo/statsd-csharp-client/issues/64), and the StatsdClient people were into what I was selling. I however relized I would be breaking their app, and their customers for my own selfish desires. 

So I spend most of my last few weekends building a new Client. A client that is built with Dependency Injection in mind. A client that exposes its logs. A client that tries to be as fast as possible. This client is called [StatsN](https://github.com/TryStatsN/StatsN).

## Gathering metrics with StatsN

StatsN at its heart is has a simple api.

We can construct a new stastd client with something like the following:

```csharp

IStatsd statsd = StatsN.Statsd.New<Udp>(a=>a.HostOrIp = "10.22.2.1", Port = 8125);

```

Then we can log metrics.

```csharp

statsd.TimerAsync("MyFunction.Timer", ()=>{

    /* code that will be timed */
})


```

Now Statsd clients should be used as singletons in applications. These objects create eitehr a Udp, or Tcp client witch can be reused.

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

I hope to create additional instrumented things around StatsN. I have already started working on an [actionfilter attribute](https://github.com/TryStatsN/StatsN.MvcCore.ActionInstrumentation). I'm hoping the following would time your mvc/webapi actions and results


```csharp

        [Instrument("homepage.load")]
        public IActionResult Index()
        {
            return View();
        }

``` 

I also plan on making a class that extends HttpClient so you can automatically instrument your http calls, how long it takes for your bytes to leave the wire, and how long it takes to download responses. These kinds of efforts really improve how developers instrument their applications for the future.