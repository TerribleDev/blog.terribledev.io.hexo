title: 'How .ToLookup() Saved me 4 hours a week, and got me some high praise from my boss'
tags:

  - c#
  - performance
permalink: how-tolookup-saved-me-4-hours-a-week-and-got-me-some-high-praise-from-my-boss
id: 55
updated: '2015-09-22 07:00:13'
date: 2015-09-14 09:36:08
---

I recently created a small utility that is ran in jenkins to create indicies in [ElasticSearch](https://www.elastic.co/webinars/get-started-with-elasticsearch?elektra=home&storm=banner).

The first versions took around 5 hours to index our massive data into elasticsearch. This was still better than the 9 hours, our old solution took, so no one was complaining.

One of the major slowdowns was a `.Where()` on a `List<T>`. When I wrote the tool this TODO was written

>//TODO: use some kind of key lookup here, but we need non-unique keys and Dictionaries are unique only
<!-- more -->
Basically I was doing `.Where(a=>a.Id == SomeVal)`, and from what I can tell in the [source](http://referencesource.microsoft.com/#System.Core/System/Linq/Enumerable.cs,141) `.NET` was doing this by looping over the whole collection. People smarter than me would point out that this is an `O(n)` operation.

What caused the bottleneck was this **huge** collection (I'm talking in the realm of 8000+ entities) we were looping over. I **knew** we wanted to do key lookups, but I cannot know every little thing in the BCL (Base Class Library). The only collection I knew of for key lookups (dictionary) was for **unique keys** only. This was a problem, as my keys were not unique.

One day while looking at some of the linq extensions I found the [ToLookup()](https://msdn.microsoft.com/en-us/library/system.linq.enumerable.tolookup(v=vs.90).aspx) extension which converted the current collection to an [Lookup](https://msdn.microsoft.com/en-us/library/bb460184(v=vs.90).aspx) class.

After reading the documentation I knew this was the perfect collection for me. Essentially it groups multiple entities by key, which means it returns a collection of your results grouped on the keys. This would transform my `O(n)` operation to an `O(1)` operation. Eventually I landed on something like this.

```csharp

var col = hugeCollection.ToLookup(a=>a.id, a);

var lookupResults = col[IdToLookup]

```

This ultimately lead to our application's run time going from 5 hours to 40 minutes. Now really this didn't save me 4 hours as much as it saved jenkins, but it did allow changes we made into elasticsearch faster which means we could make more changes, and tighten our feedback loops.
