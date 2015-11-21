title: Setting up robots.txt for your ghost powered blog
tags:

  - ghost
  - node.js
  - linux
  - robots.txt
  - sitemap
  - googlebot
  - webmaster tools
  - Tutorial
permalink: setting-up-robots-txt-for-your-ghost-powered-blog
id: 16
updated: '2014-03-01 19:49:04'
date: 2014-02-25 16:23:06
---

Setting up your robots.txt file for your blog is easy, by adding a file called robots.txt in the root of your current themes directory.

`~/blogFolder/content/theme/Casper`

If you are unfamiliar with linux, to do this simply cd to the directory and run the command `sudo vi robots.txt` Press i (for insert mode), type your entry (example farther down in this blog), press esc, then type `:wq` (w stands for write, q stands for quit). Then hit enter

You should probably point sitemap to your rss feed. Most bots (including googlebot) can use the rss feed as a sitemap

```

Sitemap: http://yourdomain/rss
User-agent: *

```

As a side note, in the robots.txt file you must specify the full URL to your sitemap file.