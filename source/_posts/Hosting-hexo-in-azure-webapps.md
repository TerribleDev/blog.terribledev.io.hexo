title: Hosting hexo in azure webapps
tags:
  - Azure
  - IIS
  - Hexo
date: 2015-11-26 11:20:42
---


If you have read this blog for any length of time, you know I am a fan of Azure. I thought about using github pages with hexo, but github pages only supports 1 doman name. I could start 301 redirecting my other domains, but I really didn't want to do that.
<!-- more -->
## Building in azure

In case you didn't know Azure Webapps have their own build engine called kudu. To get started install the cross plat azure cli. `npm install azure-cli -g`

Generate your deploy.cmd (or sh if you prefer)
`azure site deploymentscript`

Do not configure anything in the deployment section of your config.yml, this will cause it to publish to the public folder.

The only command you should have to do is hexo generate. Add one of the following to your deploy.cmd or deploy.sh depending on which language you generated (you will want to do this after the script npm installs).

deploy.sh:
`eval ./node_modules/.bin/hexo generate`

deploy.cmd
`.\node_modules\.bin\hexo.cmd generate`

We just need to configure IIS. Drop a file called web.config at the root of your blog. Add the following markup.

```xml

<configuration>
  <system.webServer>
    <staticContent>
     <mimeMap fileExtension=".mp4" mimeType="video/mp4" />
     <mimeMap fileExtension=".m4v" mimeType="video/m4v" />
     <mimeMap fileExtension=".ogg" mimeType="video/ogg" />
     <mimeMap fileExtension=".ogv" mimeType="video/ogg" />
     <mimeMap fileExtension=".webm" mimeType="video/webm" />
     <mimeMap fileExtension=".oga" mimeType="audio/ogg" />
     <mimeMap fileExtension=".spx" mimeType="audio/ogg" />
     <mimeMap fileExtension=".svg" mimeType="image/svg+xml" />
     <mimeMap fileExtension=".svgz" mimeType="image/svg+xml" />
     <remove fileExtension=".eot" />
     <mimeMap fileExtension=".eot" mimeType="application/vnd.ms-fontobject" />
     <mimeMap fileExtension=".otf" mimeType="font/otf" />
     <mimeMap fileExtension=".woff" mimeType="font/x-woff" />
     <mimeMap fileExtension=".woff2" mimeType="font/x-woff" />
 </staticContent>
      <rewrite>
          <rules>
              <rule name="Add trailing slash" stopProcessing="true">
              <match url="(.*[^/])$" />
              <conditions>
                <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
                <add input="{REQUEST_FILENAME}" pattern="(.*?)\.[a-zA-z1-9]+$" negate="true" />

              </conditions>
              <action type="Redirect" redirectType="Permanent" url="{R:1}/" />
            </rule>
            <rule name="RouteToPublicDirectory">
              <action type="Rewrite" url="public{REQUEST_URI}"/>
            </rule>
          </rules>
      </rewrite>
  </system.webServer>
</configuration>

```

This markup will redirect all requests to the public folder, and it will enable newer fonts (like woff). This will also force a trailing slash. Now git commit the project and have azure pick up the files from github/bitbucket/git, etc.

If you need to see a complete example of this, grab the [code for this blog](https://github.com/TerribleDev/blog.tparnell.io).
