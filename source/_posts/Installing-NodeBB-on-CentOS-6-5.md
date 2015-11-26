title: Installing NodeBB on CentOS 6.5
tags:

  - node.js
  - Tutorial
  - nodeBB
  - CentOS
  - JavaScript
permalink: installing-nodebb-on-centos-6-5
id: 18
updated: '2014-03-28 13:48:03'
date: 2014-03-01 14:14:42
---


[NodeBB](https://nodebb.org/) is forum software written on [Node.js](http://nodejs.org/)

The official installation instructions are on [github](https://github.com/designcreateplay/NodeBB), but the documentation is for [Ubuntu](http://www.ubuntu.com/).

To install on CentOS follow these instructions.
<!-- more -->
Install the base software stack.

```
sudo yum update
sudo yum groupinstall "Development Tools" -y
sudo yum install nodejs git redis ImageMagick npm

```

Next, clone the repository.

```
 cd /path/to/nodebb/install/location
 git clone git://github.com/designcreateplay/NodeBB.git nodebb

```

Obtain npm Dependencies.

```
cd nodebb
sudo npm install -g npm
sudo npm install

```
Start Redis

```
sudo service redis start

```
Then run through the setup (it will prompt you for things like listening on port numbers and host-names).

```
./nodebb setup

```

After start it up.

```
./nodebb start

```

Now you should be able to access it in the web browser (using the config you setup earlier).
