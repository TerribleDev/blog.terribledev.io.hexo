title: Why I moved from Ghost to Hexo
tags:
  - Ghost
  - Blog
date: 2015-11-25 20:36:56
---


Blogging right? I can't believe I somehow stuck with it all this time. Even when I took a long break I still kinda blogged. I got started after being ~~convinced~~ inspired by a [coworkers](http://blog.normmaclennan.com) passion to start blogging. To say the least he, and I have very similar tastes, and he turned me on to ghost, and the ghostium theme. After a year and a half of Ghost blogging I have left Ghost.

## Why I still love Ghost

I was a huge supporter of Ghost from the start. Especially, since at the time my options were Jekyll, Wordpress, or Ghost. I hopped on when it was very new (I think I was on the second release of ghost). Ghost was the engine to really popularize the minimalist blog editor experience. The editor panel is just a editor on the left and a preview pane on the right. When compared to something like wordpress, Ghost really shines as the minimalist approach.

Ghost has plenty of customization options, fantastic themes, and a great community. I want **everyone** to know that I still like ghost, and I would still recommend it.

## Why I left Ghost

So I run all my applications in Azure. Now that I really understand how continuous deployments work I really want to make it easier to host things.

#### Lack of updating

One of my major problems with Ghost over the last 1.5+ years is the overall lack of releases. We have hardly seen many new features, and promised analytics dashboards have become a thing we don't talk about. I remember seeing a screen cap of ghost with pie charts and traffic graphs outlining a possible, but still not delivered future. The platform has gotten better, but no new major features have really come out.

#### Server runtime with no server features

Some things I were really hoping for with ghost were dynamic features. Blog's are basically a static website, once the html has been generated, so the only reason to incur a server runtime is when you are going to have advanced server features (auto translations, scheduled publishes, etc). Since static site generators like hexo are just ran off the CLI, I can easily setup scheduled publishing with a basic bash script, and CircleCI.

## Why Hexo?

In today's open source, modern world there are **many** static site generators spanning the ecosystem. I'd like to say that I just asked my [coworker](https://blog.normmaclennan.com), and I'd be lying if I said I hadn't.

I was looking at Octopress (aka Jekyll), Hugo, and a few others. I found some awesome themes for Jekyll, but I landed on Hexo. Ruby gems really bother me. You can have 5 different versions of a gem installed on your machine and unless you prefix your commands with `bundle exec` any random one could be used. I'm a fan of golang, but JavaScript just lends itself for easily plug-ability (as do most dynamic languages). Also Hexo has great documentation, a pretty cool community, and is straightforward to use.

## Why I would still recommend Ghost

I would say ghost is still an incredible to use blog engine. For people intimidated by CLI tools, or who don't understand how SCM works, ghost is for you. Ghost is a very minimal, easy to use blog engine. I never felt held back by ghost, and I always felt inspired to write when using it. Ghost performs well and the community is awesome. 
