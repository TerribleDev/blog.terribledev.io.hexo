title: 'Drastically altering view behaviors using custom DisplayFor templates C# MVC'
tags:

  - asp.net
  - c#
  - MVC
permalink: custom-mvc-display-templates-2
id: 54
updated: '2015-09-15 10:52:56'
date: 2015-09-13 12:08:47
---

One feature that I think is highly under-documented in the C# MVC framework is custom `DisplayFor` and `EditorFor` Templates.

By simply making folders in your views folder called `DisplayTemplates` and `EditorTemplates` you can use the `DisplayFor(a=>a.TypeHere)` and `EditFor(a=>a.TypeHere)` with any custom types you so choose.

```
-Controllers
-Views
-- Home
---- DisplayTemplates
------ CustomTypeName.cshtml

```

So I thought to myself how this would be useful, and I have come up with a demo in [github](https://github.com/tparnell8/CSharp-MVC-Plugin-Views)

Essentially it goes like this. I have a bootstrap grid that we could fill with multiple tiles. This would be good if you were to show a gallery of images, and perhaps certain tiles would have different behavior. In my example I have 1 tile that displays an image, and another tile that displays some text.

I created an interface called `ITile` and had my ImageTile, and TextTile inherit from this interface.

```csharp

    public class ImageTile : ITile
    {
        public string src { get; set; }
    }

```

```csharp
    public class TextTile : ITile
    {
        public string Text { get; set; }
    }
```

```csharp
    public class ViewModel
    {
        public ICollection<ITile> Tiles { get; set; }
    }

``` 

So my controllers simply creates these tile objects. The main view loops over the tiles and calls a partial view that looks like this.

```csharp

@model DisplayTemplateExample.Web.Models.ITile
@Html.DisplayFor(a=>a)

```

Then I created 2 templates in `Views/Shared/DisplayTemplates` One named ImageTile.cshtml, and the other named TextTile.cshtml **note:** the razor file names have to line up with the type name.

Then in each of these views I have different html returned

```
@model DisplayTemplateExample.Web.Models.ImageTile

<a href="#" class="thumbnail">
    <img src="@Model.src" />
</a>

```

```
@model DisplayTemplateExample.Web.Models.TextTile
<div class="thumbnail">@Model.Text</div>
```

Ok so I'm sure you are now thinking whats the point? My point is that our entire view infrastructure, has no idea the items in the `ITile` collection will create different html. This allows the Controllers to add or change the downstream behavior based on SessionContext, or anything you wish. The ultimate thing this empowers is the ability to create a ***pluggable*** view infrastructure where the type inheritance control what occurs in the view layer. The huge downside is the debugging experience is not stellar.