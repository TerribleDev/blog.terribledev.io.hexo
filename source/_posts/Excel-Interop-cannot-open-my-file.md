title: 'Excel Interop cannot open my file!'
tags:

  - Tutorial
  - wtf
  - Excel
  - Office Interop
permalink: excel-interop-cannot-open-my-file
id: 34
updated: '2014-06-28 19:34:27'
date: 2014-06-28 19:26:00
---

So a while back I made a website that uses the Excel interop (long story). Since I made it a while ago, the IIS configuration is not automated, and must be done artisanally.

Recently I have been working on moving it to a new server. I installed Excel, and the website. 

**Everything seemed ok until sysprep happend!**

![](/content/images/2014/Jun/jackie.PNG)

So I immediately was not pleased. First I started ripping apart everything profile related with IIS, and nothing.

Eventually I stumbled across [something on stack overflow](http://stackoverflow.com/a/7386967/3671357) to summarize make sure `C:\Windows\SysWOW64\config\systemprofile` contains a folder called `Desktop`. If you are on 32 bit you need `c:\Windows\System32\config\systemprofile` to contain the `Desktop` folder.


![](/content/images/2014/Jun/Capture3.PNG)

Pretty much desperate, and out of options I gave it a shot. Somehow it was the fix, although it pains me to say this.

![](/content/images/2014/Jun/really-seriously-truly.png)
