title: Dockerize that old webforms app
date: 2016-10-18 20:20:49
tags:
 - docker
 - dotnet
---


Take a webforms app

add this file 

Dockerfile:

```
FROM microsoft/aspnet
ARG site_root=.
ADD ${site_root} /inetpub/wwwroot

```

```powershell

docker build -t tparnell/mywebforms:0.0.1 .
docker run -d tparnell/mywebforms:0.0.1
docker ps
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $(docker ps -qa)

```

```xml
<Project ToolsVersion="$(VisualStudioVersion)" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <WebPublishMethod>FileSystem</WebPublishMethod>
    <ExcludeApp_Data>False</ExcludeApp_Data>
    <publishUrl>.\output</publishUrl>
    <DeleteExistingFiles>False</DeleteExistingFiles>
  </PropertyGroup>
</Project>

```