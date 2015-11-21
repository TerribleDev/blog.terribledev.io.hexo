title: 'New Series: Windows myths debunked!'
tags:

  - DevOps
  - Development
  - .net
  - windows
permalink: windows-net-myths-debunked
id: 38
updated: '2015-02-22 20:57:52'
date: 2014-11-04 01:39:59
---

Over the last 8 years the demand to scale has ever increased. 

>We have gone from curating machines like your favorite pets, and started spinning up, and destroying VM's at an ever increasing pace.

As engineers the Unix like platforms, have always been easier to work with. Personally I enjoy linux, I love package managers, I love ssh, and configurations are much easier. That being said, lately I have been interacting a lot with Windows servers. 

2014 was my first year really attending a lot of conferences. One thing I have seen a lot at these conferences are misconceptions about Windows itself, and the .NET environment. Granted, I still love Linux a ton, but I also believe Windows is a viable platform to run on. 

This blog post starts a **series** of posts to convince people that Windows can be a viable platform. I'll also use this series to talk about things I like about .NET. Personally, I believe azure has proven the viability of using windows on a large scale.

## Package Management

> When I want to install xyz program on my linux box, I just type apt-get package name, like to see you do that on windows! ~ SomeRandomDude

This is the most common thing I have heard. I would like to direct **everyone's** attention to an amazing open source project called [Chocolatey](https://chocolatey.org/)

Chocolatey is a package manager for windows. Much like apt-get, chocolatey can download and install packages from the chocolatey website, or a locally hosted store.

The cool part about chocolatey? Completely open sourced, and driven by the community! Chocolatey was not developed at microsoft, but some engineers whom simply wanted apt-get like functionality in windows. 

Microsoft is now embracing this effort, in the next version of [Windows Management Framework](http://blogs.technet.com/b/windowsserver/archive/2014/04/03/windows-management-framework-v5-preview.aspx) Microsoft will release OneGet, a repository manager for windows. Under the bonnet driving OneGet by default, Chocolatey! Much like apt, to simply install puppet I can type `choco install puppet`.

