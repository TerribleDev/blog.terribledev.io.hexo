title: Capturing Client Side JavaScript Errors
tags:

  - javascript
  - client side
  - error handling
permalink: capturing-client-side-javascript-errors
id: 24
updated: '2014-03-19 20:05:33'
date: 2014-03-19 19:57:16
---

Capturing client side errors in my opinion is really good. For starters you can troubleshoot your client side implementation, but you can also make sure a js change did not break certain pages.

Below is a really simple, yet effective way to capture errors. Eventually you may want to implement something more advanced, but this will get you out of the gate.
<!-- more -->
```javascript
window.onerror = function (errorMsg, url, lineNumber, column, error) {
    $.ajax('/api/Error', {
        type: "POST",
        data: {
            Message: errorMsg,
            ScriptUrl: url,
            Line: lineNumber,
            PageUrl: window.location.protocol + "//" + window.location.host + "/" + window.location.pathname,
            StackTrace: function (){return error ? error.stack: '';}

        }
    });
};
```
You will need Jquery, and a server side API to accept the data. Not all browsers are currently including a Stack Trace, so you will only get stacks from certain browsers.
