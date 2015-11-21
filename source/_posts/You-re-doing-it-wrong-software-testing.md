title: "You're doing it wrong (software testing)"
tags:

  - You're doing it wrong
  - culture
  - Testing
  - non-prod
  - Continuous Improvement
permalink: softwaretesting
id: 11
updated: '2014-02-22 08:38:47'
date: 2014-02-20 05:00:57
---

One of the major systems that will stop you from losing money is your testing environment. The ability to properly test patches before they are put into production is a must. 


## Hardware Symmetry

> Our test environment does not have nearly the same CPU/Memory that production servers have

The discrepancy between test and and prod adds unnecessary variables to your testing. Your testing environment needs to be a mirror hardware-wise as your production environment. The ability to accurately test the memory increases, and CPU impact is critical to the success of your code in production.

For instance if you have multiple worker processes in production, that each hold a cache of data and that cache is increased by 2GBb. This may be seen in a non-prod environment as a small increase. However, if your production environment is running 4 times the worker processes as your non prod the small 2GB rise becomes 8GB very quickly. 

This large increase in memory usage could destabilize your platform (or not), but the unpredictability of this fact is scary. Tests should be [scientific](http://en.wikipedia.org/wiki/Scientific_method), and a radical difference between the two environments causes unnecessary variables.

## Testing in prod as a last resort

>We can't test this in test, because our *(insert discrepancy of the day)* in test is not good enough

If you suspect that a patch is causing performance problems, but you are unable to fully test it in a non-prod environment. Try to get the right hardware provisioned, or see what can be done for effective testing. The cost of serious performance degradation in production can be far worse than getting the right hardware, or pushing back at other developers.

If you have to test in prod try to patch a few servers and see what happens. Going all the way can also be more costly, then applying something on a few machines and rolling back. Make sure that potentially destructive tests are performed when all teams are in the office. Provide communication, and get everyone involved. If testing in prod requires a pow-wow of 10+ people you will quickly see those kinds of tests end fast.

{<1>}![](/content/images/2014/Feb/9689481.jpg)



## Learn from your mistakes

>Continuous Improvement is not only an improvement of code, but also an evolution of philosophies. ~[Norm Maclennan](https://blog.normmaclennan.com)

When problems occur in prod, you sometimes hear why did QA not catch this? When really the question should be, why was this not caught in test. One of the huge differences between these two statements is the first tries to blame a person, while the other constructively finds ways to improve and evolve.

>Everyone in the organization should take ownership of testing, and testing environments. ~ [Tommy Parnell](http://blog.tommyparnell.com)

This is a huge key to success. Realize that if you write code, you probably write test cases. You should make sure you understand the release process, how code is tested, and how QA performs tests. Making sure QA can accurately test your code will ultimately prove beneficial to both you, your team, and your organization.

##Inconsistent Releases

Releases to test should be performed in the same manor as releases to prod. Any deviation from the documented process should be addressed immediately. Code changes should be managed properly, and scientifically for formal testing to be effective. 

Patches should also follow a consistent pattern from one software upgrade to the next. Hearing *this patch is going to be weird* from a Release Engineer is basically a red flag for *this is going to go wrong, but we don't want to take the blame for it*






