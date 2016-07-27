title: "Bringin' turbolinks to .net"
date: 2016-03-13 14:46:48
tags:
- aspnet
- c#
- aspnet core
---


For a while now I have been playing with rails, and rack webapps. If you are not familiar with these, they are webservers created in ruby. One of the features I ran into during my journey into ruby land is [Turbolinks](https://github.com/turbolinks/turbolinks-classic). Incase you are not familiar, Turbolinks is basically a simplified pjax, with a lot of flexibility. When you click on a link in a page with turbolinks, the link action is hijacked and the target page is loaded via ajax. The result of the ajax call (which is presumed to be html) will replace the document of the body tag. At the end of the day its a technology to load your server side pages via ajax.
<!-- more -->

## Why load your pages via ajax?

Ok, so I know what you are thinking, why do this? This will prevent any use of `$(document).ready(()=>{})` and generally could cause some weird js behaviors. The answer is simple, page load times. We all know SPA's generally are slightly slower to load on first page, but subsequent pages are **super** fast. Part of what makes SPA's fast, is their lack of re-loading css, and boilerplate js for the page. That being said the SPA experience on older browsers, or older hardware leaves something to be desired.

Turbolinks hopes to provide a spa like experience, but with the control of a server side application. Basically rails authors drop the turbolinks.js file in with their other JavaScript files, and they install the server side middleware. There are haters, even in the rails community. Personally I think its a very interesting proposition, and I hate to see ruby be the only holders of this technology.

## In comes Turbolinks.Net

I was working on an aspnet core 1.0 application, which had a lot of css. This css provided a very rich client experience, but at the cost that it was not fast to download, or parse. This project was more or less browser based art. We needed server side controls over the digital assets. A prototype react app we made, but was ultimately abandoned as it didn't perform as we would hope on older hardware. We really didn't want to write a spa for fear of the art to be stolen, and we wanted to provide a rich experience even for older hardware. I recalled back to my rails tinkering, and quickly made a middleware called [Turbolinks.Net](https://github.com/TerribleDev/TurboLinks.Net). This middleware provides the basic server side functionality for aspnet core 1.0 websites to use the TurboLinks technology. This really helped us maintain a server based application, but with a client rich experience.

## Why Turbolinks over pjax?

Ok, so I have been asked this question a lot. I don't like getting into these debates, especially since I did not author either technology. In my experience pjax requires much more configuration. I like a `batteries included` model where it does things by default, but I can change the defaults. Pjax doesn't fit into that model, unlike turbolinks. Also, turbolinks has a huge community, and has companies behind it. The rewrite, known as [TurboLinks 5](https://github.com/turbolinks/turbolinks) looks awesome, and even more intriguing than previous versions. I'm not going to sit here and sell you on it, that is [what stack overflow is for](http://stackoverflow.com/a/14251289/3671357), I'm just going to say I <i class="fa fa-heart"></i> TurboLinks.
