title: Saying goodbye to my VPS (..and my opinions of cloud providers)
tags:

  - cloud providers
  - linode
  - azure
  - aws
permalink: saying-goodbye-to-my-vps
id: 47
updated: '2015-08-10 18:53:19'
date: 2015-08-10 18:05:18
---

I have used [Linode](http://linode.com) for quite a long time now. My blog was hosted on linode, as was my StarBound server. My linode was the CentOS Pet I always wanted. Full of manual Fail2Ban configs, I make sure I fed my VPS every day. I even used cowsay to give me a cool message from my pet every login.


The major reason I moved my things away from Linode, was not the devops story itself. I could have stuck with linode, and used chef or something to manage my former friend. I decided to host everything in [Azure Web apps](http://azure.com). Now before I give you my long ramblings why I like azure; I must tell you. I put everything in azure, because my MSDN gave me free credits. There was no huge scientific analysis behind this. The simple fact that I got free money in Azure was the **only** reason why I started using it.
<!-- more -->
## PaaS: Enabling Small Services

I really like Platform as a Service solutions. They don't work for everything, but I have hosted countless apps in [Heroku](http://heroku.com), [ElasticBeanstalk](https://aws.amazon.com/), [Azure Web apps](http://azure.com), and even [Github Pages](https://pages.github.com/). This blog is hosted on PaaS, my hubot is hosted on PaaS, and even the things I do at work are on a PaaS Solution.

I don't think PaaS is new. I recall going to ~~freewebs~~ [webs.com](http://webs.com) in the mid 2000's and uploading my html pages. They took care of the hosting. What I do believe is new, is the pivot on this idea to use SCM, and automatic build tools to constantly push these changes. These types of solutions really empower the [unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy) of making small tools, by simplifying the deployment process.

We really need to move toward a new agile world, and that includes tools that enable fast development, and deployment.

## Why I was on Linode

I love linode, and when I signed up, Digital Ocean was just getting popular. There are other competitors like RamNode, and you could consider Azure/AWS a competitor as well. The price on Linode is cheaper than AWS, and Azure. The VM's are **really** fast. I am not going to give you metrics, just take my word for it. I ran an Insurgency server with 64 players on a 2 core linode, and the same machine in AWS could not keep up.

I tried Digital Ocean, and they were good. Actually for $5, they were very good. I end up sticking with Linode, because their support is fantastic. I recall filing tickets at 2am and getting a reply within 10 minutes. I also recall the reply being 1000% better than anything I got at AWS, or Azure.

>My Linode never went down in the 600 days I had it, except for the 1 day where they turned it off to double my hardware for free (and I knew about it).

## Why I left Linode

So my over-arching reason I left Linode was because I wanted to push out changes to my blog really fast. I wanted the ability to make small changes to the html quickly. However, to do this on Linode I would have to construct my own deployment tier, even with [Circle CI](https://circleci.com/) backing me up I knew it wouldn't be trivial.

> I wanted to Focus on what made me special, and not deal with yak shaving a deployment system.

## AWS vs Azure

I see a lot of these blog posts. I'll leave the metrics to [other people](http://www.infoworld.com/article/2610403/cloud-computing/ultimate-cloud-speed-tests--amazon-vs--google-vs--windows-azure.html). I am a huge azure fan, and honestly this is probably going to be a biased review. That being said we use AWS where I work, and it is a **very** robust platform.

### AWS

So I actually quite like AWS. OpsWork has recently made me want to use AWS more, and ElasticBeanstalk is overall ok. My huge gripe with AWS is that I find getting started quite difficult. AWS requires you create lots of security groups, instance groups, VPS configs, etc. to get started, and to be honest its annoying.

The UI is quite clunky, in fact I use the CLI to avoid the abysmal UI, and good luck finding all the dependent objects of a parent. P.S. the permissions in AWS are terrible, unless you work at a company where everyone has full access.

On the plus side the instances spin up quite quick, they are well priced, and you can get what feels like unlimited compute. The storage system (S3) is quite user friendly, and well priced.

ElasticBeanstalk is alright, but AWS doesn't really have a good Github -> ElasticBeanstalk story. Also some of the features are only available in US data centres.


### Azure

Azure is my favorite. Web Apps are really good at hosting web applications in PHP, Java, Nodejs and .NET. I've had some problems hosting node in azure, but every few weeks it seems to get easier, and easier. The UI is great, except sometimes I feel its not responsive enough (some slow load times). Also Azure only has DNS management through the CLI, which is annoying so most people use Simple DNS.

The actual VM's are quite good, but without picking up the phone you cannot ask for an absurd amount of compute. Blob storage is quite good, and azure has a very cheap no-SQL PaaS that has the [fastest query times ever](http://www.troyhunt.com/2013/12/working-with-154-million-records-on.html).

Also Microsoft is surprisingly open with how Azure runs under the hood. They say its all IIS, with ISAPI modules, and Hyper-V. They have the [azure friday](http://azure.microsoft.com/en-us/documentation/videos/azure-friday/) podcast where they de-mystify the whole platform, and the [kudu deployment system](https://github.com/projectkudu/kudu) is open source.

### Overall

Overall I love azure more, but AWS is still very good. I feel like AWS has more granular controls, but Azure tends to get in your way less. Pick your poison, because its all the same. That being said use what you **like** not what everyone is using.
