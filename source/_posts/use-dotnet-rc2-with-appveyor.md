title: Use dotnet rc2 with appveyor
date: 2016-05-21 19:13:47
tags:
  - appveyor
  - dotnet
---

dotnet CLI is currently in RC2, and while the train is fast approaching RTM, most tools are still catching up. [dotnet](dot.net) seems to have a documented cli based install for every platform except the good ol windows. That being said getting a windows based install/build is possible.
<!-- more -->

Place the following powershell as the before build step in appveyor. In short, download the installer, run it, and then restore your nuget packages. I got the flags by running the installer with /?

```powershell
    (new-object net.webclient).DownloadFile('https://download.microsoft.com/download/4/6/1/46116DFF-29F9-4FF8-94BF-F9BE05BE263B/packages/DotNetCore.1.0.0.RC2-SDK.Preview1-x64.exe','core.exe')

    core.exe /install /quiet /norestart
    
    dotnet restore


```

if you have solution files, and a project system them appveyor should build the project automatically. If you don't then set the build command to be `dotnet build .\path\to\your\proj`

Since aspnet core builds to not emit dependent dll's appveyor's auto detect and run for tests doesn't work. Make sure you have added the test runner to your project.json and just run `dotnet test .\path\to\your\tests`

You can find a working example [here](https://github.com/tparnell8/shodan.net) 

tl;dr appveyor.yml:

```yml
version: 1.0.{build}
configuration: Release
before_build:
- ps: >-
    (new-object net.webclient).DownloadFile('https://download.microsoft.com/download/4/6/1/46116DFF-29F9-4FF8-94BF-F9BE05BE263B/packages/DotNetCore.1.0.0.RC2-SDK.Preview1-x64.exe','core.exe')

    core.exe /install /quiet /norestart

    dotnet restore
build:
  verbosity: minimal
test_script:
- cmd: dotnet test .\path\to\mytests

```