title: The ultimate chaos monkey. When your cloud provider goes down!
date: 2017-03-13 15:20:14
tags:
- amazon
- aws
- cloud
- DevOps
---

A few weeks ago, the internet delt with the fallout that was [the aws outage](https://techcrunch.com/2017/02/28/amazon-aws-s3-outage-is-breaking-things-for-a-lot-of-websites-and-apps/). AWS, or Amazon Web Services is amazon's cloud platform, and the most popular one to use. There are other platforms similar in scope such as Microsoft's Azure. Amazon had an S3 outage, that ultimately caused other services to fail in the most popular, and oldest region they own. The region dubbed `us-east-1` which is in Virgina.

This was one of the largest cloud outages we have seen, and users of the cloud found out first hand that the cloud is imperfect. In short when you are using the cloud, you are using services, and infrastructure developed by human beings. However most people turn to tools such as cloud vendors, since the scope of their applications do not, and should not include management of large infrastructure. 

The Netflix, and amazon's of the world are large. Really large, and total avalibility is not just a prefered option, but a basic requirement. Companies that are huge users of the cloud, have started to think about region level depenencies. In short, for huge companies, being in one region is perilous, and frought with danger. 

Infact this isn't the first time we have heard such things. In 2013 Netflix published [an article](http://techblog.netflix.com/2013/05/denominating-multi-region-sites.html) describing how they run in multiple regions. There is an obvious cost in making something work multi-region. This is pretty much for the large companies, however if you are a multi billion dollar organization, working multi-region would probably be an awesome idea.