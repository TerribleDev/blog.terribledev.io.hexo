title: Parsing cli arguments in dotnet core Console App
date: 2016-10-24 16:31:06
tags:
  - c#
  - dotnet
  - console
---

**tl;dr** view [this gist](https://gist.github.com/TerribleDev/06abb67350745a58f9fab080bee74be1)

So its 2016, and we are still making console apps/cli's. In fact I would say there has been a surge in popularity of these types of tools. I think we have come to the realization that buttons on forms are not automatable, and that the command line doesn't have to be scary. 

I recently started writing an app in dotnet core, which is the new runtime for dotnet. In the past I have often used [command line parser](https://www.nuget.org/packages/CommandLineParser), but as of this writing it does not support core.

> I was really lost trying to find an arguments parsing library when I realized the dotnet cli was open sourced.

After much struggle, failing to bingle. I started ripping through the ef, and dotnet cli's code hoping to find a gem. Thats when I stumbled across a [diamond](microsoft.extensions.commandlineutils). You see many dotnet projects use [Microsft.Extension.CommandLineUtils](https://www.nuget.org/packages/Microsoft.Extensions.CommandLineUtils/) to do cli parsing.

<!-- more -->

## A quick primer on the command line

Console apps are just essentially apps that use the console as the UI. The primary way developers interact with CLI tools is through the console. Lets take the azure cli and break down how commands work as an interface.


```
info:             _    _____   _ ___ ___
info:            /_\  |_  / | | | _ \ __|
info:      _ ___/ _ \__/ /| |_| |   / _|___ _ _
info:    (___  /_/ \_\/___|\___/|_|_\___| _____)
info:       (_______ _ _)         _ ______ _)_ _
info:              (______________ _ )   (___ _ _)
info:
info:    Microsoft Azure: Microsoft's Cloud Platform
info:
info:    Tool version 0.10.6
help:
help:    Display help for a given command
help:      help [options] [command]
help:
help:    Log in to an Azure subscription using Active Directory or a Microsoft account identity.
help:      login [options]
help:
help:    Log out from Azure subscription using Active Directory. Currently, the user can log out only via Microsoft organizational account
help:      logout [options] [username]
help:
help:    Open the portal in a browser
help:      portal [options]
help:
help:    Manages the data collection preference.
help:      telemetry [options]
help:
help:    Commands:
help:      account          Commands to manage your account information and publish settings
help:      acs              Commands to manage your container service.
help:      ad               Commands to display Active Directory objects
help:      appserviceplan   Commands to manage your Azure appserviceplans
help:      availset         Commands to manage your availability sets.
help:      batch            Commands to manage your Batch objects
help:      cdn              Commands to manage Azure Content Delivery Network (CDN)

```

The azure cli has what many consider a noun verb syntax. For example if I run `azure webapp` I will have a list of actions to take on the webapp noun. I could run `azure webapp list` or `azure webapp start [appname]`. These are what we call Commands.

```

C:\Users\parne>azure webapp
help:    Commands to manage your Azure webapps
help:
help:    create a web app
help:      webapp create [options] <resource-group> <name> <location> <plan>
help:
help:    Stop a web app
help:      webapp stop [options] <resource-group> <name>
help:
help:    Start a web app
help:      webapp start [options] <resource-group> <name>
help:
help:    Stop and then start a web app
help:      webapp restart [options] <resource-group> <name>

```
Now there are also optional things we can pass. These are usually called Parameters. Typically there are 3 kinds of parameters `SingleValue`, `NoValue`, `MultipleValue`. 

For example if we were to create a webapp we could pass `--location <locationhere>` which would be a single value parameter. If location could take more than one parameter, it would be considered a MultipleValue Parameter. Now I know what you are thinking, how can anything have no value? Well these types of parameters are often boolean values. For example if we wanted `azure webapp create` to output in json we could pass the `-- json` flag but we wouln't pass anything with it. Instead the presence of the flag would turn on the feature. 

Now last note, apps return exit codes. Basically an integer representing either a success `0` or an error `>0` just be aware that command line tools should return a status code 0 if everything is ok.

## Ok I get it, now how to I parse things in dotnet

Great, so circling back to the beginnings of my story. I needed a **solid** cli parser. One that can do commands n levels deep, auto parsing properties, and has a clean api. The cli parser for ef, and dotnet seems to fit that bill.

Create a console app (if you don't have one already) `dotnet new -t console`

You should have something like this:

```csharp

    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }

```

Add the nuget package to your project `Install-Package Microsoft.Extensions.CommandLineUtils`.

Ok, now lets say we want to make a console that can create `snowballs`, and `catapults`. Then I guess we will let a `catapult` throw a snowball.

So in this instance we have 2 nouns; `catapult`, `snowball`. First we need to add these as "commands".

```csharp
        public static void Main(string[] args)
        {
            var app = new Microsoft.Extensions.CommandLineUtils.CommandLineApplication();
            app.Command("catapult", config => {});
            app.Command("snowball", config => { });
            //give people help with --help
            app.HelpOption("-? | -h | --help");
            app.Execute(args);
        }
```

So there is two things going on here. 1) we have added `--help` so a user can get some generated docs for this app, and the other is we have added catapult and snowball. You should be able to run `dotnet build && dotnet .\bin\Debug\netcoreapp1.0\YourApp.dll --help` and it should display the help menu

Now currently these are top level commands, but we want to give them subcommands. Starting with catapult lets add a command to `list` and a command to `add` a catapult.

```csharp
public static void Main(string[] args)
        {
            var app = new Microsoft.Extensions.CommandLineUtils.CommandLineApplication();
            var catapult = app.Command("catapult", config => { 

             });
             catapult.Command("list", config => {
                    config.OnExecute(()=>{ 
                        
                        config.Description = "list catapults";
                        Console.WriteLine("a");
                        Console.WriteLine("b");
                        return 0;
                     });   
                });
            catapult.Command("add", config => {
                    config.Description = "Add a catapult";
                    var arg = config.Argument("name", "name of the catapult", false);
                    config.OnExecute(()=>{ 
                        if(!string.IsNullOrWhiteSpace(arg.Value))
                        {
                            //add snowballs somehow (not showing persistence here)
                            Console.WriteLine($"added {arg.Value}");
                            return 0;
                        }
                        return 1;
                        
                        
                     });   
                });
            app.Command("snowball", config => { });
            //give people help with --help
            app.HelpOption("-? | -h | --help");
            app.Execute(args);
        }
    }
```

Ok great so when we run `app catapult list` we get a list back of catapult a, and b. We can add a new one. However when we run `app catapult` nothing happens. We should support `app catapult help`, `app catapult --help` or just `app catapult` so that users can get to help menus easily. So lets fix that.

Make your catapult declaration look like this:

```csharp
            var catapult = app.Command("catapult", config => { 
                config.OnExecute(()=>{
                    config.ShowHelp(); //show help for catapult
                    return 1; //return error since we didn't do anything
                });
                config.HelpOption("-? | -h | --help"); //show help on --help
             });
            catapult.Command("help", config => { 
                 config.Description = "get help!";
                 config.OnExecute(()=>{
                    catapult.ShowHelp("catapult");
                     return 1;
                 });
              });

```

So what we have here is, if we match catapult with no params, show the help and return a status code of 1 (since we didn't do anything). Also allow `--help, -? -h` and `help`. Now anyone using this subcommand will be able to get help.


Ok so now lets add `add` and `list` to snowballs.


```csharp

            var snowball = app.Command("snowball", config => { 
                    config.OnExecute(()=>{
                    config.ShowHelp(); //show help for catapult
                    return 1; //return error since we didn't do anything
                });
                config.HelpOption("-? | -h | --help"); //show help on --help
             });
             snowball.Command("help", config => { 
                 config.Description = "get help!";
                 config.OnExecute(()=>{
                    catapult.ShowHelp("snowball");
                     return 1;
                 });
              });
             snowball.Command("list", config => {
                    config.Description = "list snowballs";
                    config.OnExecute(()=>{ 

                        Console.WriteLine("1");
                        Console.WriteLine("2");
                        return 0;
                     });   
                });
            snowball.Command("add", config => {
                    config.Description = "Add a snowball";
                    var arg = config.Argument("name", "name of the snowball", false);
                    config.OnExecute(()=>{ 
                        if(!string.IsNullOrWhiteSpace(arg.Value))
                        {
                            //add snowballs somehow
                            Console.WriteLine($"added {arg.Value}");
                            return 0;
                        }
                        return 1;
                        
                        
                     });   
                });

```

Now all that is left is to be able to let catapults throw snow.


```csharp

            catapult.Command("fling", config =>{ 
                config.Description = "fling snow";
                var ball = config.Argument("snowballId", "snowball id", false);
                var cata = config.Argument("catapultId", "id of catapult to use", false);
                config.OnExecute(()=>{

                    //actually do something
                    Console.WriteLine($"threw snowball: {ball.Value} with {cata.Value}");
                    return 1;
                });
             });


```

ok now lets throw some snow!


```console
C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult --help

Usage:  catapult [options] [command]

Options:
  -? | -h | --help  Show help information

Commands:
  add    Add a catapult
  fling  fling snow
  help   get help!
  list   list catapults

Use "catapult [command] --help" for more information about a command.

C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult add --help

Usage:  catapult add [arguments] [options]

Arguments:
  name  name of the catapult

C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult add a
added a
C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult list
a
b
C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll snowball add 1
added 1
C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult fling --help

Usage:  catapult fling [arguments] [options]

Arguments:
  snowballId  snowball id
  catapultId  id of catapult to use
C:\projects\CommandLineParsing> dotnet .\bin\Debug\netcoreapp1.0\k.dll catapult fling a 1
threw snowball: a with 1


```


Here is the full source as a [gist](https://gist.github.com/TerribleDev/06abb67350745a58f9fab080bee74be1#file-program-cs):

<script src="https://gist.github.com/TerribleDev/06abb67350745a58f9fab080bee74be1.js"></script>
