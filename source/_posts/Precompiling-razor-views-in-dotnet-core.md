title: Precompiling razor views in dotnet core
date: 2017-04-04 05:28:26
tags:
---

Recently I had heard [live.asp.net](https://github.com/aspnet/live.asp.net/blob/dev/src/live.asp.net/live.asp.net.csproj#L8) had started to precompile the razor views. I figured I'd dig in and quickly figure out how to do it.
<!-- more -->

Honestly its quite simple. Add the `Microsoft.AspNetCore.Mvc.Razor.ViewCompilation` package to your project. You can do this through the dotnet cli `dotnet add package Microsoft.AspNetCore.Mvc.Razor.ViewCompilation` or through the visual studio package explorer `install-package Microsoft.AspNetCore.Mvc.Razor.ViewCompilation`. 

Then simply add `<MvcRazorCompileOnPublish>true</MvcRazorCompileOnPublish>` and `<PreserveCompilationContext>true</PreserveCompilationContext>` to your csproj file's property group. Thats it. You will now precompile your razor views on publish. You should end up with something like the following.

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>netcoreapp1.1</TargetFramework>
    <PreserveCompilationContext>true</PreserveCompilationContext>
    <MvcRazorCompileOnPublish Condition="'$(Configuration)' == 'Release'">true</MvcRazorCompileOnPublish>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore" Version="1.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc" Version="1.1.2" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.Razor.ViewCompilation" Version="1.1.0" />
    <PackageReference Include="Microsoft.AspNetCore.StaticFiles" Version="1.1.1" />
    <PackageReference Include="Microsoft.Extensions.Logging.Debug" Version="1.1.1" />
    <PackageReference Include="Microsoft.VisualStudio.Web.BrowserLink" Version="1.1.0" />
  </ItemGroup>
</Project>
```

## A small step further

Ok, so I usually compile my app in debug mode for my dev environment. This is for a few reasons, but mostly for debugging purposes. However I often build in release mode for my staging/release environments. We can add a condition to our Razor compilation to only compile in Release mode. This will give us the added benefit of only baking compiled razor for environments built outside of debug. `<MvcRazorCompileOnPublish Condition="'$(Configuration)' == 'Release'">true</MvcRazorCompileOnPublish>`. Thats it! Since MSBuild's xml is well thought out, we can alter its behaviors quite easily.