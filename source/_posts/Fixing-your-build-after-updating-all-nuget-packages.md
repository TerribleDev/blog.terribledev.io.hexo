title: Fixing your build after updating all nuget packages
date: 2016-02-12 12:21:05
tags:
- nuget
- msbuild
- c#
---


So if you are like one of my co-wokers whom are newer to `.net` land you probably thought

> "hey it would be good just to update all my nuget packages".

Then you quickly ran into issues.
<!-- more -->
The issue we saw was that in the references all the nuget packages were appearing as if they were not installed. We checked the path to them in the csproj and they looked good. One thing that took us a while to hunt down is that the .net compilers do not update very well.

`Microsoft.Net.Compilers` and `Microsoft.CodeDom.Providers.DotNetCompilerPlatform` both have a lot of custom markup that gets injected in the csproj. This presumably is so that roslyn can be used instead of the traditional c# compiler.

We found many of the following with the old version that was since updated during the global update

```xml

<Import Project="..\..\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.0\build\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.props" Condition="Exists('..\..\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.0\build\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.props')" />

```

To get around the issue we opened the csproj in notepad++ Controled + H the old package name in this case `Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.0` and replaced it with the updated package we were using (found in the packages.conf) `Microsoft.CodeDom.Providers.DotNetCompilerPlatform.1.0.1`

We made sure we did this to both of the previously mentioned packages. Once complete everything seemed to compile again.
