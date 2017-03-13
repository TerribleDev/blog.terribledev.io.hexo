title: Moving from beta 7 to beta 8 in ASP.NET 5 (MVC 6)
tags:

  - csharp
  - aspnet
  - aspnet 5
permalink: moving-from-beta-7-to-beta-8-in-asp-net-5-mvc-6
id: 59
updated: '2015-10-23 21:11:48'
date: 2015-10-18 10:16:59
---

So Beta 8 was recently [announced](http://blogs.msdn.com/b/webdev/archive/2015/10/15/announcing-availability-of-asp-net-5-beta8.aspx), and I thought I'd update [DotNetMashups](http://dotnetmashup.azurewebsites.net) to beta 8.

In case you havn't been paying attention, recently it was announced that [helios](https://github.com/aspnet/Announcements/issues/69) was no longer a thing. Helios was the loader for ASP.NET 5 in IIS. Instead they are using the [http Platform Handler](https://azure.microsoft.com/en-us/blog/announcing-the-release-of-the-httpplatformhandler-module-for-iis-8/) to proxy the connections to [kestrel](https://github.com/aspnet/KestrelHttpServer).

So I thought that this was going to be a difficult update. I loaded the [announcements repo](https://github.com/aspnet/Announcements/milestones/1.0.0-beta8) in my browser and got to work. You can view the [Pull request here](https://github.com/TerribleDev/DotNetMashup/pull/8/files).
<!-- more -->
The first thing I did was update my visual studio tools, do a `dnvm update`, then update my packages to use beta8. I then ran into was 2 build errors in my startup.cs It seemed that `app.UseErrorPage();` was renamed to `app.UseDeveloperExceptionPage();` which seems like a sensible rename. The second thing was that `app.UseErrorHandler("/Home/Error");` became `app.UseExceptionHandler("/Home/Error");` again 100% sensible.

I deleted my hosting.ini, I changed my web command from using `"web": "Microsoft.AspNet.Hosting --config hosting.ini"` to `"web": "Microsoft.AspNet.Server.Kestrel"` and I set my web.config to look like the following. That was basically it. Overall really simple!

```xml
<configuration>
  <system.webServer>
    <handlers>
      <add name="httpPlatformHandler" path="*" verb="*" modules="httpPlatformHandler" resourceType="Unspecified" />
    </handlers>
    <httpPlatform processPath="%DNX_PATH%" arguments="%DNX_ARGS%" stdoutLogEnabled="false" startupTimeLimit="3600" />
  </system.webServer>
</configuration>

```
