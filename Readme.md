Build: [![Build Status](https://travis-ci.org/tparnell8/blog.tparnell.io.svg?branch=master)](https://travis-ci.org/tparnell8/blog.tparnell.io)

This is the source of my blog post.

The posts in `source/_posts` are built into html files at build time. Azure listens to git commits and then runs `deploy.sh` which installs hexo and generates html into `./public` with [hexo](https://hexo.io/). the web.config (which is what Azure uses as a .htaccess file) rewrites all urls to the public directory. Any 404's will be redirected to 404/ which will actually be public/404/index.html in the filesystem

Don't worry the key pair in the repo is just generated so I can serve ssl locally.