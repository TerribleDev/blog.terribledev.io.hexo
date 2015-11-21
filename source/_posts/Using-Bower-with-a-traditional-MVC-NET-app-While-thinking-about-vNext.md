title: Using Bower with a traditional MVC.NET app (While thinking about vNext).
tags:

  - grunt
  - bower
  - package management
  - msbuild
permalink: using-bower-and-grunt-with-a-net-app
id: 43
updated: '2015-09-12 18:05:13'
date: 2015-03-23 21:44:29
---

Where I work .NET rules supreme. Personally I really don't care that much about the technology so long as it supports really good workflows. One of my major issues with nuget is that is very opinionated. 

In nuget, js script files always end up dumping out to a `Scripts` folder, and while you can maintain your own scripts elsewhere, nuget just is not really great for client side JS as a whole.

## Why Bower?

One of the major reasons I do not like nuget for js, is because nuget was built for .net assemblies. This means the rest of the development community outside of .net has to either put their things in nuget, or just not worry about it. What usually ends up happening is someone in the .net community decides to maintain pushing a js package into nuget. This is clearly known at MSFT since the vNEXT templates ship with bower as default. Bower is a package management written on top of npm, that supports pushing script files into a directory. Simple right?

## Show me code.....

**The Goal:** Try to maintain the same folder structure as current vNEXT templates on current .net applications. Use bower instead of nuget.

```
wwwroot/
	-lib/
    	--jquery/
        	---css/
            ---js/
Controllers/
Models/



```


So the first thing we need to do is define our bower task. Now I literally ripped the following off the vNEXT template. Essentially how this works is we define a grunt task to use bower and define the output folder. I am dumping the output from bower in a wwwroot/lib folder, just as the vNEXT projects are going to go.

**Gruntfile.js**
```javascript

/// <binding BeforeBuild='bower' />
// This file in the main entry point for defining grunt tasks and using grunt plugins.
// Click here to learn more. http://go.microsoft.com/fwlink/?LinkID=513275&clcid=0x409

module.exports = function (grunt) {
    grunt.initConfig({
        bower: {
            install: {
                options: {
                    targetDir: "wwwroot/lib",
                    layout: "byComponent",
                    cleanTargetDir: false
                }
            }
        }
    });

    // This command registers the default task which will install bower packages into wwwroot/lib
    grunt.registerTask("default", ["bower:install"]);

    // The following line loads the grunt plugins.
    // This line needs to be at the end of this this file.
    grunt.loadNpmTasks("grunt-bower-task");
};


```


**bower.json**

```

{
    "name": "myProject",
    "private": true,
    "dependencies": {
        "bootstrap": "3.0.0",
        "jquery": "1.10.2"
    },
    "exportsOverride": {
        "bootstrap": {
            "js": "dist/js/*.*",
            "css": "dist/css/*.*",
            "fonts": "dist/fonts/*.*"
        }
        "jquery": {
            "": "jquery.{js,min.js,min.map}"
        }
    }
}
```

## What about msbuild?

Ok here comes the **tough** part. To work around msbuild I included the following xml in my csproj which should import the files in the wwwroot folder during build. I like to put this before the closing `</Project>` node.

```
  <Target Name="BeforeBuild">
      <ItemGroup>
      <Content Include="wwwroot\lib\**\*.css" />
      <Content Include="wwwroot\lib\**\*.js" />
  </ItemGroup>
  </Target>

```

You could also in theory get really silly (**Not Recommended**) and call grunt during build. Although I did the opposite and **called msbuild from grunt**, which in my opinion is better.

```
  <Target Name="BeforeBuild">
      <ItemGroup>
		<Exec Command="npm install"/>
		<Exec Command="node -e require('grunt').tasks()"/> 
  </ItemGroup>
  </Target>
```

### Custom Targets

So at my current employer we have a custom build engine, and for some reason the Content includes didn't work well with that. To mitigate this I included the following nodes as a child of the project node. I then called msbuild with the target of `CoreContent` which triggered the copy during the publishing. Now if a developer uses vs to publish, it will use the Content Include, and if our build system calls it, we will use the custom target.

```

<ItemGroup>
   <CoreContent Include="wwwroot\lib\**\*.css" />
   <CoreContent Include="wwwroot\lib\**\*.js" />
 </ItemGroup>
 <Target Name="CoreContent">
  <copy SourceFiles="@(CoreContent)" DestinationFolder="$(WebProjectOutputDir)\wwwroot\lib\%(RecursiveDir)%(Filename)%(Extension)" />
 </Target>

```