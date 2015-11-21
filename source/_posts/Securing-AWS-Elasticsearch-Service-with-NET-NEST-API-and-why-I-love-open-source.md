title: Securing AWS Elasticsearch Service with .NET NEST API (and why I love open source)
tags:

  - elasticsearch
  - .net
  - nuget
  - open source
permalink: securing-aws-elasticsearch-service-and-nest-api
id: 61
updated: '2015-11-07 11:04:10'
date: 2015-11-06 20:41:18
---

Around 6 months ago I started a project, and part of that project was to move us away from an old search tool to use elasticsearch.

For those of you whom are unfamiliar [elasticsearch](https://www.elastic.co/) is a web service over [Lucene](https://lucene.apache.org/core/) which provides a document database that can perform complex transforms on text specifically designed for search. Elasticsearch does things like stop word removal and [stemming](https://www.elastic.co/guide/en/elasticsearch/guide/current/controlling-stemming.html) to provide a fantasic way to perform searches.

I was browsing my twitter feed one day and I saw this thread.

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/jdcooke0117">@jdcooke0117</a> Like off the bottom of the charts? Because you couldn&#39;t even run ES before but now you can?</p>&mdash; Norm MacLennan (@nromdotcom) <a href="https://twitter.com/nromdotcom/status/649723904563396608">October 1, 2015</a></blockquote>


I got curious as ES usually stands for Elasticsearch, and I quickly found out that AWS [announced](https://aws.amazon.com/blogs/aws/new-amazon-elasticsearch-service/) Elasticsearch as service. 

This was pretty huge for me since a few months before I struggled to string together some code that someone else at my company wrote to get elasticsearch working in AWS, and to be honest it was not fun. Managing elasticsearch in AWS is far from great.


We started out with a basic 'domain' (which is AWS' term for an elasticsearch cluster) and we got up and running pretty fast. The 'domains' seemed to have almost all the API's we needed, and it worked with the [NEST client](http://nest.azurewebsites.net/).

When we were just trying it out we didn't bother securing it, but when we needed to secure the instance, we realized things were not so fun. AWS lets you block access by ip which doesn't help because EC2 instances have different ip addresses as the time, or you can use IAM roles, except you can't just target existing machines you have to sign the requests. 

Eventually we bit the bullet and decided to sign our requests to the cluster. Unfortunatly the SDK doesn't provide a utility to sign any ol' http requests. I started digging through the AWS docs to figure out how to sign requests, and I was getting worried, as the docs do not make it seem easy to pull off. As an act of desperation I dived into nuget and just typed aws elasticsearch, which I then stumbled across a [project that was published only days before](https://github.com/bcuff/elasticsearch-net-aws).

This project totally saved my bacon. Brandon's library plugged right into the .NET sdk, and auth'd our requests to aws without us having to figure out all that crypo. Within moments of finding it I filed an [issue](https://github.com/bcuff/elasticsearch-net-aws/issues/1) thanking Brandon as it really helped me out. 

The Elasticsearch service offering by Amazon is pretty awesome. Like any platform its less flexible then hosting the instances yourself. You have to live with the plugins they ship, but on the plus side you get a full cluster, with monitoring, and a knob to turn up instances, or storage space without having to worry about the details.

<script src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>