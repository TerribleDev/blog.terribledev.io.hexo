title: Tip Badges in ghost
tags:

  - ghost
  - gratipay
permalink: tip-badges-in-ghost
id: 44
updated: '2015-04-04 16:04:44'
date: 2015-04-04 15:31:04
---

So I am a huge fan of ghost, and I love providing my content free of charge. That being said server hosting costs money.

 I added a tips badge to the bottom of my blog posts (see below) to try to offset the costs.
<!-- more -->
How I did this was simple. I signed up for a [gratipay](https://gratipay.com) account. Once signed in I went to the widgets section of my profile and found my badge.

![](/content/images/2015/04/Capture.PNG)

I took the image tag and wrapped it around an `a` tag that will link to my profile.

```xml
<a href="https://gratipay.com/TommyParnell">
<img src="https://img.shields.io/gratipay/TommyParnell.svg">
</a>


```

I then went into my themes folder at `content/themes/ghostium` where I found a file called `post.hbs`

I scrolled to where I found the part that the author website url is injected. I then added in the badge from gratify

**Before**
```xml

   <p class="post-author-website">
   <a href="author.website" rel="nofollow">author.website</a>
   </p>

```

**After**

```xml
   <p class="post-author-website">
   <a href="author.website" rel="nofollow">author.website</a>
   </p>
 <p>
 <a href="https://gratipay.com/TommyParnell"><img src="https://img.shields.io/gratipay/TommyParnell.svg"></a>
</p>


```

## Badge at the top of the page

if you want the badge at the top of the page you can add the code explained above before the `post` handelbars tag in the post.hbs file
