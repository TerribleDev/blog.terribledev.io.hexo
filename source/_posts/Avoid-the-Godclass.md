title: Avoid the Godclass
tags:

  - Architecture
permalink: avoid-the-godclass
id: 50
updated: '2015-09-19 07:54:37'
date: 2015-09-05 09:28:12
---

I joined a team earlier this year, who own a core set of pages on our website. This part of the site makes us **buckets** of money, and was written by people whom are clearly smarter than me. However every platform is not without its quirks.

Most of the code is C# MVC but a lot of the problems with the platform are more historic architecture, and less `.NET` specific.
<!-- more -->
#### Dependency Management

The early creators of the platform had a model we will call WidgetModel. WidgetModel, initially was a basic representation of our view layer before templating.  Over the course of many short deadlines, poor management, and continuous growth, the model became more than a simple model.

To say the least, parts of the application state ends up being stored in this model, along with Session data. WidgetModel gets passed around everywhere, and way more than half of the codebase took a dependency on the model. Any changes to this model require major application refactors.

I even found SprocketFactory that took in a WidgetModel and added itself to WidgetModel, then called a function in WidgetModel that needed a dependency to SprocketFactory. Just take a moment to grok how terrible that is.



#### Contexts

So I'm sure you are thinking, well WidgetModel not great but atleast you can use it always right? **wrong**

Our application was originally a WebForms application, that was ~~transformed~~ pummeled into an MVC architecture. Our version of MVC still has weird ViewState crazyness, and was ultimately bolted on.

WidgetModel has very **deep** dependencies to certain session context objects. These objects are largely **unavailable** in an API request. So WidgetModel must not be used in an API.

#### DI, Not always your friend

Now when I first started I thought it would still be ok, because they must get their dependencies from somewhere. Most paradigms I see in .NET dependencies are given through constructors.

However this was not the case. I found the following in all classes that needed WidgetModel.

```csharp


    public WidgetModel GodModelRARRRR
    {
        get
        {
            return RandomDependencyContainer.Get<WidgetModel>();
        }
    }

```


Basically they got WidgetModel from a dependency injector in a property getter. So whenever someone writes code for our API 3/4 times while developing someone calls a class that calls a class that wants WidgetModel really badly, that causes our whole application to blow up.


#### Solving this Problem

We didn't have the scope to re-write everything. Rewriting most of the code was a year long project by itself. We also needed to keep parts of our app. Our attitude was simple,
>Rewrite as an SPA.

If we are entirely a JavaScript SPA, and we only call API's we won't be able to accidentally take a dependency on WidgetModel. This approach is leading us to delete WidgetModel all together. The 1/4 of the app that didn't have the dependency to WidgetModel was actually maintainable.

The great part about this was, we could burn down most of our code, while keeping a huge chunk that was actually quite maintainable.
