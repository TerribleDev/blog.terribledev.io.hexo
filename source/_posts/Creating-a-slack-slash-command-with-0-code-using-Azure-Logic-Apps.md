title: Creating a slack slash command with 0 code using Azure Logic Apps
date: 2018-09-19 17:14:41
tags:
- azure
- slack
---

Ok so recently I was on a slack sharing cat pictures, when I realized the CarGurus slack did not have a `/cat` command. I know immediately, this had to change!
<!-- more -->


So my vision was simple, write `/cat` in slack and a random cat appears! Slack has native functionality to extend the slash commands. You can find the custom integrations by clicking on your slack workspace name, and clicking `customize slack`. Then you can do a search for `slash commands`.

![a screen shot of the slack UI for adding a slash command](slack1.png)

So anyway, slash commands will call an http endpoint with either a POST or get. For mine I chose post. They expect a response within `300ms`, so not a lot of time! However in the post data slack provides a URL you can post back to with your response. That URL can be used for `3 seconds` tons of time for an api.

So I found [this api](http://aws.random.cat/meow) which returns you a url of a random cat photo. Obviously my first reaction was to just call it and paste the response in slack. Unfortunately slack expects messages to come back in a [specific json format](https://api.slack.com/docs/messages).

My first reaction was to make a azure function, when called from http will call the [random.cat](http://aws.random.cat/meow) api, and then shape the data correctly for slack. Even though that is not much code, its certainly more work than I was willing to put in on a `lunch break` project.

Then I remembered `azure logic apps` poor choice of name, but the demo I saw a year ago looked interesting. Ok, so this is basically like if-this-then-that but more for developers. You can do all kinds of cool stuff with it, like trigger when a file is written to storage, and call a workflow of other serverless functions. 

In my case I started out with the http trigger. I made a parallel branch. The first branch returns an `200` status code back to the caller. This is because slack requires a response within `300ms`. The second branch I added a http call to the random cat api, a parse json function to parse the results, and then another http call back to slack with the proper data. The Url to the slack api is a function call to `triggerFormDataValue('response_url')` which will parse out the response url from the posted data to our function's trigger.


![a screen shot of a logic app workflow in azure](azure1.png)

The code view of my logic app looks like the following. The whole thing was pretty easy, and I did it over my lunch break!

```json

{
    "definition": {
        "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
        "actions": {
            "HTTP": {
                "inputs": {
                    "method": "GET",
                    "uri": "http://aws.random.cat/meow"
                },
                "limit": {
                    "timeout": "PT1S"
                },
                "runAfter": {},
                "type": "Http"
            },
            "HTTP_2": {
                "inputs": {
                    "body": {
                        "parse": "full",
                        "response_type": "in_channel",
                        "text": "@body('Parse_JSON')?['file']",
                        "unfurl_links": true,
                        "unfurl_media": true
                    },
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "method": "POST",
                    "uri": "@{triggerFormDataValue('response_url')}"
                },
                "runAfter": {
                    "Parse_JSON": [
                        "Succeeded"
                    ]
                },
                "type": "Http"
            },
            "Parse_JSON": {
                "inputs": {
                    "content": "@body('HTTP')",
                    "schema": {
                        "properties": {
                            "file": {
                                "type": "string"
                            }
                        },
                        "type": "object"
                    }
                },
                "runAfter": {
                    "HTTP": [
                        "Succeeded"
                    ]
                },
                "type": "ParseJson"
            },
            "Response": {
                "inputs": {
                    "statusCode": 200
                },
                "kind": "Http",
                "runAfter": {},
                "type": "Response"
            }
        },
        "contentVersion": "1.0.0.0",
        "outputs": {},
        "parameters": {},
        "triggers": {
            "manual": {
                "inputs": {
                    "schema": {}
                },
                "kind": "Http",
                "type": "Request"
            }
        }
    }
}

```



