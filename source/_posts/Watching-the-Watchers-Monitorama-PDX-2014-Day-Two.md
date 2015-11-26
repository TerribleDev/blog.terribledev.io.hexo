title: 'Watching the Watchers: Monitorama PDX 2014 Day Two'
tags:

  - Culture
  - Monitorama
  - Conference
permalink: watching-the-watchers-monitorama-pdx-2014-day-two
id: 31
updated: '2014-05-07 11:08:19'
date: 2014-05-07 10:48:55
---

* [Day One](https://blog.tommyparnell.com/watching-the-watchers-monitorama-day-one/)

Day 2 was full of math based paranoia, math, and puppet(s)....

<!-- more -->
## Auditing all the things": The future of smarter monitoring and detection

Jen Andre started off with a talk about auditd, and how to audit everything in your frinastructure. Using custom logging tools you can watch the command flow for every logged in session, even when the session su's to a different user.

## Is There An Echo In Here?: Applying Audio DSP algorithms to monitoring

DSP (Digital Signal Processing) applied to monitoring data, could convert a very noisey graph, into a very readable one as Noah Kantrowitz pointed out in the second talk of the day.

## A Melange of Methods for Manipulating Monitored Data

Dr Neil J. Gunther talked about how he is applying maths (yes plural :P) to gathered data metrics. He points out that you should never trust your data (even if it was gathered acuratly), and always trust in your instincts.

## The Final Crontab

Crontabber is a jobs engine produced at Mozzilla. Selena Deckelmann talks about how it works, and why it is better than regular cron. The huge advantage to use it, is the jobs can have dependancies to each other.

## This One Weird Time-Series Math Trick

Baron Schwartz delivered a very math centric talk about using math (like sliding averages, holt-winters, etc.) to properly analize your data.

## The Lifecycle of an Outage

Scott Sanders talks was about how hipchat, and hubot are coming together to help dealing with a problem. He noted at github the bots can embed graph data into hip chat that others can see as they hop online. He also talked about analyzing your processes after an outage, to improve the handling of future issues.

## A whirlwind tour of Etsy's monitoring stack

Etsy is able to deploy their application at any moment in time. Doing this requires both great CI tools, but also even better monitoring tools. Having power tools like ganglia, graphite, splunk, logstash. They are able to gain great insight into their application.

## Wiff: The Wayfair Network Sniffer

Wireshark as a Service, wiff is a network traffic logging tool developed at wayfair. Able to log traffic throughout the network layer, wiff is able to help you understand your network traffic.

According to the presenter Dan Rowe, wiff helped wayfair detect a bug in their cookie generating algorithm.

## Web performance observability

[Web Rockit](http://webrockit.io/) is a simple tool that detects web loading performace. The tool uses Phantom.js (headless webkit browser) to load the page and gather statistics during the load. These statistics can help you determine what is going on when your webpage loads.

## Lightning Talks

The one talk that stood out to me at the lightning talks is never manage your software like a [17th century ship](http://pete.io/Jra5).

## Puppet Afterparty

While the line for the beer was long, and the food was in short supply the puppet party was amazing. Ping pong filled the air, whilst tech nerds played board games. The people that work at puppet were very friendly and eager to talk about programming.
