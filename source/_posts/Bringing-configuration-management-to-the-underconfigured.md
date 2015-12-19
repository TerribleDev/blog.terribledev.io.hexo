title: Bringing configuration management to the underconfigured
date: 2015-12-19 08:24:47
tags:
  - Culture
  - DevOps
  - Configuration Management
---

I spend much of my time at Vistaprint just being a normal developer. In fact its over 75% of what I do. I am a Web Developer, however with my background in ops I have spent more and more time at Vistaprint doing configuration management, and coaching other teams how to approach the subject.

<!-- more -->


Over the last year I have been hired at a few different startups to be a consultant, providing this knowledge to others. I have worked on both Linux, and Windows environments, and I have noticed **especially** windows shops are **not** doing configuration management. To say the least either sets of developers forget about the many dependencies their apps have. Programs are dependent on many things, DNS gateways, LDAP servers (maybe), certain native libraries, runtimes, etc. Declaring these dependencies inside of a configuration management tool like Chef, Puppet, Salt, etc. really provides better insight, and increased flexibility.

I worked for a ruby shop recently, and the first thing I said was "what version of ruby do you have installed on your servers" I got back "well I have ruby 2.1.4 on my machine". We did some quick checking and 1.9.3 was running in prod (a version that is **out of support**). I asked if they could use containers, but due to reasons I won't get into, they were unable to use them.  I spent a week at the mentioned startup, and by the end of the week I had a very flexible set of puppet modules, and manifests that built out their whole environment. Dependencies declared, and developer machines provisioned in the same way. The impact of this change didn't hit them right away, but several weeks later I got a slack notification saying the following.

>Hey man we just created new database servers with puppet and it took less than a few hours to wire everything up! We also updated ruby in prod and it was a snap. Puppet R0x0rs  

Now I don't put this quote in just to brag about how amazing I am (I mean we all know I am right?). I put it here to show that if you start declaring dependencies in ways developers can consume, the rate of change that will occur is tremendous. Git provides a fantastic change management system, and amazing continuous deployment from a mainline trunk. Changes to puppet files, and thus changes to production can be easily tracked though Source Control Management. Bugs arisen from installations of said packages can be found quickly, and reverting these changes are a snap.

Bringing traditionally ops things to developers by using tooling developers will be able to use, will ultimately bridge the ops-dev gap we all have.
