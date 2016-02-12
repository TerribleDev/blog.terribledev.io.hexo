title: The wix toolset tl;dr
date: 2016-02-11 20:00:00
tags:
- windows
- wix
- DevOps
---

So recently I have had the (some would say unfortuate) time learning wix. Specifically I am trying to better understand windows installers, mostly to install webapps into IIS with MSI's. This is mostly due to the unfortunate situation where I constantly do work for windows things. I would recommend reading the docs on the [wixtoolset](http://wixtoolset.org) website, but if you are still having a trouble understanding how the tools come together, you can read this.

Windows Installer Xml toolset or Wix for short, has been around since the early 2000's. The toolset is one of the great mechanisms to create MSI's. A while back I [blogged](/binding-ssl-certs-on-windows-installer-xml-wix-deployed-web-applications/) about how to use them to install ssl certs in IIS. Until recently when I fit the tools together in my head, I couldn't figure out how they work. So here is the tl;dr
<!-- more -->
## tools

The wix tools are command line tools, but they do have good integrations with msbuild. That being said you can invoke them right from gulp, or rake if you want.

#### Heat
Heat is known as the "Harvester" tool. In a wsx file you will reference components, and files. Often instead of baking paths to specific files, you will use heat to grab whole directories.
When you call heat.exe you can include some parameters, which are well covered [in the docs](http://wixtoolset.org/documentation/manual/v3/overview/heat.html). Ultimately this will export wixobj files which will be used in the generation of your MSI.

#### Candle
Candle, also known as the compiler. Candle is a tool that converts your wxs files into wixobj files. This will "compile" the xml. This is the place where you can include wix extensions such as the IIS extension.

#### Light
Light is the "Linker" tool. You can think of the "Linker" as the thing that gathers everything outputted by heat, and candle into an MSI database. If you include a cabnet in your wix file it should place your heat files inside the MSI directly. This tool "Links" the wixobj metadata to ultimately produce an MSI.

## Combining the tools

Essentially you have to combine the tools. Heat will harvest directories, candle will compile your wxs file, and light will pull it all together. You call them in that order.  In a future sequel to this blog post I will provide some recipes how you can integrate this into a CI build with tools such as jenkins.
