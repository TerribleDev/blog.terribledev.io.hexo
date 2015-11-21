title: "Fixing: Could not load file or assembly 'Microsoft.Dnx.Host.Clr'"
permalink: fixing-could-not-load-file-or-assembly-microsoft-dnx-host-clr-2
id: 53
updated: '2015-09-09 17:34:41'
date: 2015-09-09 10:08:18
tags:
---

So I recently ran into this error where the latest bits could not load Microsoft.Dnx.Host.Clr here is what I did to fix it.


* Followed the instructions from the [beta7 announcements](https://github.com/aspnet/Announcements/issues/51)
 * Installed the [latest web tools](http://www.microsoft.com/en-us/download/details.aspx?id=48222) **warning**: there are multiple MSI's in that link. Install the WebToolsExtensions
* Updated my runtime `dnvm upgrade -u -r clr`
* Made sure my project was set to use the latest runtime
* Updated my nuget packages `dnu restore`

Afterwards everything seemed to work.