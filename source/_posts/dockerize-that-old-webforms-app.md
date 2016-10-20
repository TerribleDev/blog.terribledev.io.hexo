title: Dockerize that old webforms app
date: 2016-10-18 20:20:49
tags:
 - docker
 - dotnet
---

So now that Windows server 2016 is [generally avalible](https://blogs.technet.microsoft.com/hybridcloud/2016/10/12/another-big-step-in-hybrid-cloud-windows-server-2016-general-availability/) for the first time ever windows users can now use containers. Ok, so what exactly are containers? Well more or less they are virtual operating systems that **share** the same kernel as the host OS. In regular VM's the hardware is shared between machines, but containers go a step further and share the kernel of the OS. Why does this matter? Well because you are sharing an existing kernel that is already running, your startup times are instantanious. To put this in perspective, this is virtualization at the OS level.

On Linux, containers have been a thing for a long time. This technology is called LXC. Docker itself is a layer ontop of various container platforms embedded in operating systems. 

<!-- more -->

## Getting started

So I have put an example project [together on github](https://github.com/TerribleDev/docker-webforms) which may help you understand what is going on. Docker images are first compiled which essentially involves taking an existing image, maybe running some commands (like installing windows features), and pushing your files into the container. After the imate is built we can run the container, and beyond that we can publish the image for deployment.

We define how the container is built with a `Dockerfile`. Take an existing webforms app, and in the web project add a file called `Dockerfile` with the following content

Dockerfile:

```
FROM microsoft/aspnet
ARG site_root=.
ADD ${site_root} /inetpub/wwwroot

```

In this case the `Dockerfile` is pulling down the aspnet image from Dockerhub. This is a servercore image, with iis/aspnet installed. it is adding the content in the current directory to /inetpub/wwwroot which is where the app is ran from in the container.

Now compile your code and run the following

```powershell
docker build -t mywebforms:0.0.1 .
```

You should now have an docker image created! We can list the docker images with `docker images`. We can run the image with `docker run -d mywebforms:0.0.1`

To see the website running in the container we need to find its ip address and then open a browser to the ip. You can use this powershell script to list running docker procs and their ip's

```powershell
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $(docker ps -qa)
```

## Plumbing in a CI system!


Even legacy applications can be improved with some kind of build automation. Starting to automate msbuild/nuget and docker is a great start to really improving legacy projects. I am a web developer, so javascript is my bread and butter. that being said, its not for everyone. In [my sample project](https://github.com/TerribleDev/docker-webforms) I used gulp to compose a build together. There are many tools including cake (c#), albacore (ruby), grunt (javascript). Honestly they all work about the same. I chose gulp, because I am using gulp in many of my projects currently.


In my sample I created a gulp file that takes in a version number (which could be passed by our CI system). Patches the AssemblyInfo.cs files, restores nuget packages, and compiles down a docker image to be used later. All with the simple command of `gulp build --version 1.0.0`

The created docker image could easily be uploaded to some kind of storage. 