title: Writing an animated flyout hamburger menu
date: 2018-06-08 15:17:26
tags:
- javascript
---

So I'm currently sitting on a plane at the moment. A recent project I started on was a [travel guide where I live](https://nashua.fun). Being on a plane without wifi for a long time is a quick wakeup to me how much I rely on the internet to code.
<!-- more -->


My page itself uses the minimalist Jekyll theme. I really like this theme's typography, and clean look. However its missing a key element for my page, and that is a menu. Without the ability to google I set off writing my own menu. No libraries, and that includes jquery! The only thing I relied on was a local copy of font awesome I had recently downloaded. So the first place I started was to make the flyout menu. Here is a screen shot of the results.

![screen shot showing expanded menu](menu.png) 


Seeing as I didn't have a button to toggle right away, I just called a few functions I wired up into the window for development purposes. I added the following html in the body tags. Notice a few things. First, I've used font-awesome 5 to get a circle with an `x` in it. This will be used to close the menu, if you don't want to make a selection. Then we have each link, and in my use-case I made these hash links.

```html

<nav class="hamNav">
        <a type="button" onclick="hideNav()" >
            <i class="closeNav fas fa-times-circle" ></i>
        </a>
        <ul>
            <li><a href="#item1">Item 1</a></li>
            <li><a href="#item2">Item 2</a></li>
          </ul>
      </nav>

```

So here is the css I generally used. Now I'm using `scss` so I can nest some variables. There are a few things worth mentioning. First off the navbar I called hamNav, because it was a hamburger style menu nav. The second is that the navbar's position is fixed, and it defaults to a width of 0, which means it won't really render any pixels on the screen. Finally, I've added a css transition of .5s This will cause the menu to animate out from the left side.

```scss
.hamNav{
  position: fixed;
  height: 0;
  width: 0;
  overflow-y: auto;
  overflow-x: visible;
  transition: 0.5s,
  box-shadow 0.3s ease;
  background: #222;
  top: 0;
  left: 0;
  z-index: 9999999;
  padding-top: 8%;
  height: 100%;
  text-align: center;
  p,h1,h2,h3,h4,span,div,ul,li{
    color: white;
  }
  ul { 
    padding-left: 0;
    li {
      list-style-type: none;
      font-size: 1.5em;
      padding-bottom: 4%;
      margin-left: 0;
      a, a:visited {
        color: white
      }
    }
  }
  @media screen and (max-width: 720px){
    &.show{
      width: 100%;
    }
  }
  @media screen and (min-width: 721px){
    &.show{
      width: 40%;
    }
  }
  .closeNav{
    position: absolute;
    right: 10%;
    top: 2%;
    color: white;
    font-size: 1.5em;
  }
}

```

Now then I added a file with some JavaScript functions. these functions simply will add the `show` class to our menu bar. Once we add that class, we'll give the menu a width and thus cause it to animate out. You would be able to see this by running `toggle()` in the JavaScript console.

```js
function showNav(){
    var elem = document.getElementsByClassName("hamNav")[0];
    elem.classList.add("show");
}

function hideNav(){
    var elem = document.getElementsByClassName("hamNav")[0];
    elem.classList.remove("show");
}

function toggle(){
    var elem = document.getElementsByClassName("hamNav")[0];
    if(elem.classList.contains("show")){
        elem.classList.remove("show");
    }
    else{
        elem.classList.add("show");
    }
}
```

Ok, so I needed a button to open the menu. These days most websites have a small circular button on the right side, with the hamburger menu icon in it. Back to font awesome where I got a sweet hamburger icon, and I wrote the following html in the body.

```html
      <header>
          <a role="button" href="#hamMenu" class="navBtn" onclick="trigger()"><i class="fas fa-bars"></i></a>
      </header>
```

Ok this will give us an a link with a hamburger icon inside. Now we have to style the a link so it looks like a round button. Back to css!

```scss
.navBtn{
    position: fixed;
    background-color: #222;
    overflow: hidden;
    bottom: 15%;
    right: 8%;
    width: 50px;
    height: 50px;
    z-index: 100;
    border-radius: 50%;
    vertical-align: middle;
    text-align: center;
    font-size: 1.3em;
    color: white;
    box-shadow: 1px 1px 4px black;
    &:active, &:visited { 
      color: white;
    } 
    i {
      margin-top: 31%;
    }
}
```

Ok, so whats going on here. Well we're using border-radius to make our class round. We're giving it a width and height of `50px`. We're setting its position to fixed percentages off the bottom right. This will help make it scale better for different screen sizes. Finally we adjust the margin for the hamburger icon, and make the icon white.

This works great, except that the menu does not support the back button in the browser. I added the following snippet of javascript which made sure we cover that case.

```js
    if(window.location.hash.includes("hamMenu")){
            showNav();
        } else{
            hideNav();
        }
}

```

So thats basically it. Honestly, I'm happy with the way it came out. I'm sure there could be better way's to do this. With the overall lack of googling ability this is what I came up with, and I like it!