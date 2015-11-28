title: 'Parsing, and Nesting Models in backbone.js'
tags:

  - Development
  - backbone.js
  - Javascript
  - Tutorial
permalink: nested-models-in-backbone-js
id: 13
updated: '2014-03-02 20:28:44'
date: 2014-02-24 02:18:51
---


## The Parse Function
The parse function allows you to do some pre-processing of the data sent from the server before the model is created. Parse should return an object containing the values that will make up this models attribues. This is called after the fetch command has recieved the data, but before the response is put into the model. The example below parses dates to local time before adding them to the model using  [moment](http://momentjs.com/).
<!-- more -->
```javascript

namespace.Model = Backbone.Model.extend({
    urlRoot: '/api/',
    parse: function(response, options){
    	var attr = {};
        attr.date = moment().utc(response.date).local()  
        attr.OtherData = response.OtherData
        return attr;
    }
});
```

## Nesting Models (aka model within a model)

We will use the same parse function as above to create models within this model from data retrieved by the server. You could even loop through an array's keys and values to convert them to a model if need be.


```javascript

namespace.Model = Backbone.Model.extend({
    urlRoot: '/api/',
    parse: function(response, options){
    	var attr = {};
        var submodel = new namespace.otherModel({value1: response.subModelArray.value1, value2: response.subModelArray.value2 });
        attr.SubModel = submodel;
        return attr;
    }
});
```
