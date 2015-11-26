title: 'Custom error pages in Nancyfx (C# Web Framework)'
tags:

  - c#
  - Tutorial
  - Nancyfx
  - Nancy
permalink: custom-error-pages-in-nancy
id: 26
updated: '2014-04-02 02:18:08'
date: 2014-03-31 20:40:54
---

To do custom error pages in Nancy you must implement an IStatusCodeHandler. This class must provide 2 methods. HandlesStatusCode is a bool that basically should tell Nancy if this class will handle the status code. If this returns true then this class will be responsible for handling the request.

<!-- more -->
```csharp

 public bool HandlesStatusCode(HttpStatusCode statusCode, NancyContext context)
 {
   return (int)statusCode == 404;
 }

 public void Handle(HttpStatusCode statusCode, NancyContext context)
 {
   var response = viewRenderer.RenderView(context, "Your404View");
 }


```

The only problem with the above code (which I have seen throughout the net) is you basically have to implement different IStatusCodeHandlers for each type (or types) of status codes.


What you can do is this *(or scroll to the end to see the final result)*....

First add the following properties... _checks will be where we store the list of http requests we will handle...This is a static class so it will be shared in memory with the other objects of the same class.

Checks will be the getter of this information, and viewRenderer will be the mechanism we will render the view.

```

private static IEnumerable<int> _checks = new List<int>();

        public static IEnumerable<int> Checks {  get { return _checks; } }

        private IViewRenderer viewRenderer;

```
Next add an **IViewRenderer** to your constructor this will be dynamically injected by Nancy.

```csharp

public CustomStatusCode(IViewRenderer viewRenderer)
            {
                this.viewRenderer = viewRenderer;
            }

```

Afterwards we should add some methods so that people can add, and remove status codes from this store.


```

 public static void AddCode(int code)
        {
            AddCode(new List<int>() {code});
        }
        public static void AddCode(IEnumerable<int> code)
        {
            _checks = _checks.Union(code);
        }

        public static void RemoveCode(int code)
        {
           RemoveCode(new List<int>() { code });
        }
        public static void RemoveCode(IEnumerable<int> code)
        {
            _checks = _checks.Except(code);
        }

```
Now we have to tell Nancy what we are checking for:


```csharp

public bool HandlesStatusCode(HttpStatusCode statusCode, NancyContext context)
        {
                return (_checks.Any(x => x == (int) statusCode));
        }


```

...and finally we should probably handle the status codes. Below will render a view that is located in Codes/{httprequestnumber}...So for a 404 this will render Codes/404.cshtml (**Note:** if you are not using razor you may wish to change the filename extension.

How this works is simple, try to render the view if it cannot (ie. it cannot find the file or it runs into a problem) remove the http request type from our list and return the status code, nancy will take it from there.



```csharp

public void Handle(HttpStatusCode statusCode, NancyContext context)
        {
            try
            {
                var response = viewRenderer.RenderView(context, "/Codes/" + (int)statusCode + ".cshtml");
                response.StatusCode = statusCode;
                context.Response = response;
            }
            catch (Exception)
            {

                RemoveCode((int)statusCode);
                context.Response.StatusCode = statusCode;
            }
        }


```

You will need to make the necessary view, and you will also need to give it the http codes you wish it to handle. In my case I add them from the web.config during start up. I also use a module to add/remove status codes at will (ill provide a sample of that module below)...


## Final Result

### IStatusCodeHandler Class:

```csharp

public class CustomStatusCode : IStatusCodeHandler
    {
        private static IEnumerable<int> _checks = new List<int>();

        public static IEnumerable<int> Checks {  get { return _checks; } }

        private IViewRenderer viewRenderer;

           public CustomStatusCode(IViewRenderer viewRenderer)
            {
                this.viewRenderer = viewRenderer;
            }

        public bool HandlesStatusCode(HttpStatusCode statusCode, NancyContext context)
        {
                return (_checks.Any(x => x == (int) statusCode));
        }

        public static void AddCode(int code)
        {
            AddCode(new List<int>() {code});
        }
        public static void AddCode(IEnumerable<int> code)
        {
            _checks = _checks.Union(code);
        }

        public static void RemoveCode(int code)
        {
           RemoveCode(new List<int>() { code });
        }
        public static void RemoveCode(IEnumerable<int> code)
        {
            _checks = _checks.Except(code);
        }

        public static void Disable()
        {
            _checks = new List<int>();
        }

        public void Handle(HttpStatusCode statusCode, NancyContext context)
        {
            try
            {
                var response = viewRenderer.RenderView(context, "/Codes/" + (int) statusCode + ".cshtml");
                response.StatusCode = statusCode;
                context.Response = response;
            }
            catch (Exception)
            {

                RemoveCode((int)statusCode);
                context.Response.StatusCode = statusCode;
            }
        }
    }


```

### Module that provides flexability:

`/error/add/404` will add 404's `/error/remove/404` will remove 404's

You could make a querystring accept an array if you wish, in my case this isn't needed.

```csharp

public class StatusCodesModule : NancyModule
    {
        public StatusCodesModule()
            : base("error")
        {
            Get["/add/{code}"] = x =>
            {
                CustomStatusCode.AddCode(x.code);
                return "done";
            };

            Get["/remove/{code}"] = x =>
            {
                CustomStatusCode.RemoveCode(x.code);
                return "done";
            };


        }
    }




```

### Bootstrapper startup

```csharp

public class Bootstrapper : DefaultNancyBootstrapper
    {


        protected override void ApplicationStartup(TinyIoCContainer container, IPipelines pipelines)
        {

            CustomStatusCode.AddCode(404);
            CustomStatusCode.AddCode(ConfigurationManager.AppSettings["HttpErrorCodes"].Split(',').Select(x => int.Parse(x)));


            base.ApplicationStartup(container, pipelines);
        }

    }


```
