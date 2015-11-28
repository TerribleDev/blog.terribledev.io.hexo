title: Migrating Ghost blog to hexo
date: 2015-11-28 10:32:57
tags:
  - Ghost
  - Hexo
  - Blog
thumbnailImage: thumbnail.png
---
I recently ported my ghost blog to hexo, and it was pretty easy.
<!-- excerpt -->
Checkout my other hexo blogs:
* <i class="fa fa-cloud fa-6"></i> [Hosting hexo in Azure webapps](/Hosting-hexo-in-azure-webapps/)
* <i class="fa fa-user"></i> [Why I moved from Ghost to Hexo](/Why-I-moved-from-Ghost-to-Hexo/)

## Getting Started with hexo

To get started with hexo run the following commands:
* `npm install -g hexo-cli`
* `hexo init`
* `npm install`

This will drop many files, and folders. The primary one we are going to talk about is the `_config.yml`. You will want to start by filling out the `_config.yml` file. Name your blog, give a descripton, etc.


## Porting your blogs over

To get your data over you will need to go to this url: `http://yourblog.com/ghost/settings/labs/` and click the export button. Place the json file at the root of your hexo blog, then run.
* `npm install hexo-migrator-ghost --save`
* `hexo migrate ghost NameOfYourExportFile.json`

Your posts should drop in the posts folder, but the tags will need fixing. Open atom (or another editor that can do find replace in a directory) and replace `tags: |` with `tags:` in all the files.

Now that it is done we need to fix the paths to your images. Download your images (if you are using `azure` you can get them via ftp), and place the folder in the source directory.

Now run `hexo server`, browse to port 4000. Your blogs should appear.

## Backward compat. urls

We need to make some modifications to make sure the urls are backward compatible.

Set the tag_dir to tag, in ghost the path to tags is /tag.


if your post urls were just /Title then put `:title/` in the permalink setting. Otherwise adjust the urls for the proper date format.

#### RSS

You will want to have an rss feed. You will want to `npm install hexo-generator-feed --save`

You can then add the following to your config.yml

```yml
feed:
    type: rss2
    path: rss
    limit: 0
```


If you were like me you registered your ghost rss feed to `/rss `instead of `/rss.xml`. I have no perfect answer to fix this, but I used azure's Url redirect to redirect `/rss` to `/rss.xml`.

```xml
<configuration>
  <system.webServer>
    <rewrite>
          <rules>
              <rule name="SpecificRewrite" stopProcessing="true">
                  <match url="^rss$" />
                  <action type="Rewrite" url="public/rss.xml" />
              </rule>
          </rules>
  </system.webServer>
</configuration>
```

 If you are using github pages you can use the `jekyll-redirect-from` gem.
