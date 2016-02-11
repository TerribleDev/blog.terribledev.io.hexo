title: The wix toolset tl;dr
date: 2016-02-10 23:14:34
tags:
- c#
- wix
---

So recently I have had the (some would say unfortuate) time learning wix. Specifically I am trying to better understand windows installers, mostly to install webapps into IIS with MSI's. This is mostly due to the unfortunate situation where I constantly do work for windows things.

Windows Installer Xml toolset or Wix for short, has been around since the early 2000's. The toolset is one of the great mechanisms to create MSI's. Until recently when I fit the tools together in my head, I couldn't figure out how they work. So here is the tl;dr

## tools

#### Heat
Harvester

#### Candle
Compiler

#### Light
linker


## command line tools vs msbuild
