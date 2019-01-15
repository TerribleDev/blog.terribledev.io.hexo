title: How I minify images for my blog
tags:
- javascript
- tools
---

Ok so I'm really lazy, and I honestly think that has helped me a lot in this industry. I always try to work smarter, not harder. I take many screen shots for this blog, and I need to optimize them. Incase you didn't know many images are often larger than they need to be slowing the download time. However, I don't ever want to load them into photoshop. Too much time and effort!


<!-- more -->

At first I tried to compress images locally, but it took to long to run through all the images I had. So recently I started using a service called [tiny png](https://tinypng.com/) to compress images. Now the website seems to indicate that you upload images, and you will get back optimized versions. However to me this takes too much time. I don't want the hassle of zipping my images uploading them, downloading the results. Again, lazy!

So I figured out they have a cli in npm. Easy to install, just use npm to globally install it. `npm install -g tinypng-cli`.

Now you have to call the cli, this is the flags I use `tinypng . -r -k YourKeyHere`. The period tells tinypng to look in the current directory for images, `-r` tells it to look recursively, or essentially to look through child directories as well, and the `-k YourKeyHere` is the key you get by logging in. On the free plan you get 500 compressions a month. Hopefully you will fall into the pit of success like I did!

![an image showing the tiny png results](1.png)