title: Exploring the dotnet cli
date: 2017-03-07 16:30:38
tags:
- csharp
- dotnet
- dotnet core
---

Now that dotnet has been released I thought it would be good to look into the dotnet cli. This is a new command line interface to build, manage, compile and run `dotnet core` based applications 

<!-- more -->

## Getting started

You will need to install the latest version of dotnet core. Simply install it at [dot.net](https://dot.net/). You can find installers for Mac, Windows, or Linux. You should be able to read the docs and get going.



## Now what?

Like most command lines you can call `dotnet --help` and get a list of main functions.

```
C:\projects\awesome> dotnet --help
.NET Command Line Tools (1.0.1)
Usage: dotnet [host-options] [command] [arguments] [common-options]

Arguments:
  [command]             The command to execute
  [arguments]           Arguments to pass to the command
  [host-options]        Options specific to dotnet (host)
  [common-options]      Options common to all commands

Common options:
  -v|--verbose          Enable verbose output
  -h|--help             Show help

Host options (passed before the command):
  -d|--diagnostics      Enable diagnostic output
  --version             Display .NET CLI Version Number
  --info                Display .NET CLI Info

Commands:
  new           Initialize .NET projects.
  restore       Restore dependencies specified in the .NET project.
  build         Builds a .NET project.
  publish       Publishes a .NET project for deployment (including the runtime).
  run           Compiles and immediately executes a .NET project.
  test          Runs unit tests using the test runner specified in the project.
  pack          Creates a NuGet package.
  migrate       Migrates a project.json based project to a msbuild based project.
  clean         Clean build output(s).
  sln           Modify solution (SLN) files.

Project modification commands:
  add           Add items to the project
  remove        Remove items from the project
  list          List items in the project

Advanced Commands:
  nuget         Provides additional NuGet commands.
  msbuild       Runs Microsoft Build Engine (MSBuild).
  vstest        Runs Microsoft Test Execution Command Line Tool.

```

Lets first make a new project. This is very simple, from the list of commands we clearly have a new command. Lets see what we have for options `dotnet new --help`

```
C:\projects\myproj> dotnet new --help
Template Instantiation Commands for .NET Core CLI.

Usage: dotnet new [arguments] [options]

Arguments:
  template  The template to instantiate.

Options:
  -l|--list         List templates containing the specified name.
  -lang|--language  Specifies the language of the template to create
  -n|--name         The name for the output being created. If no name is specified, the name of the current directory is used.
  -o|--output       Location to place the generated output.
  -h|--help         Displays help for this command.
  -all|--show-all   Shows all templates


Templates                 Short Name      Language      Tags
----------------------------------------------------------------------
Console Application       console         [C#], F#      Common/Console
Class library             classlib        [C#], F#      Common/Library
Unit Test Project         mstest          [C#], F#      Test/MSTest
xUnit Test Project        xunit           [C#], F#      Test/xUnit
ASP.NET Core Empty        web             [C#]          Web/Empty
ASP.NET Core Web App      mvc             [C#], F#      Web/MVC
ASP.NET Core Web API      webapi          [C#]          Web/WebAPI
Solution File             sln                           Solution

```

So it appears we can get a console app, class library, unit tests, aspnet core, webapp the list goes on and on. Lets do `dotnet new mvc --auth None --framework netcoreapp1.1`.

The results are a complete mvc application. Now lets restore the nuget packages with `dotnet restore`. Afterwards lets run the project with `dotnet run`. The results should be the app running on port 5000.

{% image "fancybox" mvc-project.PNG "a new mvc project" %}

Now I'd like to add my favorite statsd client [StatsN](https://github.com/TryStatsN/StatsN). This is as simple as running `dotnet add package StatsN`. To get a directory with our application ready to be ran we can run `dotnet publish` and one will be created in ./bin/Debug/netcoreapp1.1/publish/ If we want to compile in release mode we need to specify `dotnet publish -c Release`.

Finally we can even use the cli to create a solution file `dotnet new sln` and add we can add projects with `dotnet new sln add <MyProject>`

Overall the cli is simple and easy to use. The `--help` command works on all verbs no matter how deep, and can be very handy. The second major version of the CLI planned, includes the ability to globally install tools. This will allow any developer to extend the dotnet cli with their own code. Sometime soon you may be able to `dotnet tool install awesome` and then `dotnet awesome`.

Overall I'm both impressed, and speachless with how fast microsoft has moved its almost 20 year old platform into a very modern environment to work in. The new csproj files are easy to understand, and work 100% with my old csproj files. Backward compatibility means I can just move my stuff forward slowely, and don't have to port 10 years of work.

