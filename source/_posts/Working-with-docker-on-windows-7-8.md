title: 'Working with docker on windows 7, 8'
tags:
  - docker
date: 2018-02-22 02:59:07
---


So its no secret I'm a docker fan. In-fact, I've been a fan of docker since the early betas. I work in an office, with a high amount of people running some form of windows, and I hear this quote quite a lot.

> Docker for windows only supports windows 10, you can't use docker on windows 7, 8, etc.
<!-- more -->

Now people in the docker community know you can run docker on many operating systems. The docker toolkits for windows and mac provide GUI abstractions over the docker services. However, we can use the actual tools these GUI wrappers use to work with docker containers. In the early days of docker, a tool existed called `boot2docker`. This was replaced with a newer tool called `docker-machine`. These are the actual tools the docker toolkits use to provision linux virtual machines to help you work with containers. 

## Setting up your environment 

You will need `docker`, `docker-machine`, and `docker-compose` in your path. These are simple executables, the easiest way to get them is to use [chocolatey](https://chocolatey.org) a package manager for windows (think brew, apt-get, etc.). You will also need a hypervisor (tool that can run virtual machines). In this case I'm using Virtualbox, but you may use Hyper-V, etc. [Virtual box](https://www.virtualbox.org/) is a lightweight hypervisor (it can run vm's) created by oracle. 


```powershell
choco install -y docker docker-machine  docker-compose
choco install -y virtualbox
```

Ok, next you will need to use docker-machine to create you a virtual machine running Linux. We'll give it the name mydock, you can name it however you like.

```
docker-machine create --driver virtualbox mydock
```

Now when we open a new terminal every time we'll need `docker-machine` to configure our shell with some environmental variables. The env command will spit out a script to set the variables for your shell. You can pipe this to `invoke-expression` in powershell, or copy and execute the output in `cmd.exe`


powershell:
```powershell
docker-machine env mydock | invoke-expression
```

Now you have done that, you should be up and running. Since you are running a virtual machine, its likely it will stop when you reboot your computer. You can start it with `docker-machine start mydock`.