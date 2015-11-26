title: Binding SSL Certs on Windows Installer XML (WiX) deployed Web Applications
tags:

  - Development
  - c#
  - Tutorial
permalink: binding-ssl-certs-on-windows-installer-xml-wix-deployed-web-applications
id: 37
updated: '2014-07-22 21:58:35'
date: 2014-07-22 01:37:50
---

This tutorial is about using SSL certs with WiX for IIS websites. For those of you whom didn't know, WiX is an MSI generator. You can even deploy IIS applications with WiX's MSI's.
<!-- more -->
## Warning: I suck at wix

Now I am going to start of by saying, I am far from an expert on wix.

>If someone knows a better way please comment below. Tell me I am wrong

## Danger: Some WiX Knowledge Required

Ok so before I go on, I am not going to explain everything from scratch.

>I'm assuming you might know the basics of WiX here, and you have done iis things with it.

## Show me Teh Codez...



Ok here it goes...In your fragment that declares your website you need to declare a binary. This says basically bundle the binary code from this file into the msi. This can go right under your fragment tag. The **sourceFile** tag should be the path to your certificate.

```XML
<Binary Id="certBinary" SourceFile=".\IRCool.org.pfx"/>

```

### Declare your IIS Instance things!


Ok...So I'm hoping you know how the iis stuff with wix works if you have read up to this point (and heeded my warnings)

When you go to declare your component the iis certificate declaration needs to be a child of the component tag. The certificate needs to be the same level as your website tag.

The binary key in the certificate tag needs to match the ID of the binary tag we declared. I like to add it to local machine, personal store. Request **must** be no. Obviously the PFXPassword needs to be the password to your pfx file.

```

<iis:Certificate Id="cert" BinaryKey="certBinary" Name="IRCool.org" StoreLocation="localMachine" StoreName="personal" PFXPassword="mypasswordisawesome" Request="no" />


```


### Lets bind this

Ok so now we have our certificate declared in IIS. We need to bind against it. So you will probably end up with something like the following:

You have declared a website, in it you have added 2 web addresses. A web address that is on port 443, and is secure. Another one that is on 80, and is not. You will have declared a certificate reference that matches your iis certificate tag.

```

 <iis:WebSite Id='IRCool' Description='IRCool' Directory='Install_Web' StartOnInstall='yes' ConfigureIfExists='yes' AutoStart='yes'>
                              <iis:WebAddress Id='SecIRCool' Port='443' Header='IRCool' Secure='yes' />
                              <iis:WebAddress Id='IRCool' Port='80' Header='IRCool' />
                              <iis:WebApplication Id='IRCoolApp' WebAppPool='IRCoolAppPool' Name='IRCool' />
                              <iis:CertificateRef Id='cert' />
                            </iis:WebSite>

```

## Ok..how do I redirect my port 80?

So I know there **has** to be a better way here. I'm not sure how to configure IIS to do this with wix. However according to [Stack Overflow](http://stackoverflow.com/a/4945950) you could redirect on begin request in MVC4+ (or you could do the following in [NancyFX](http://nancyfx.org/)).


```csharp

protected override void RequestStartup(TinyIoCContainer container, IPipelines pipelines, NancyContext context)
        {
            pipelines.BeforeRequest += (x) => x.Request.Url.IsSecure
                ? new RedirectResponse(x.Request.Url.ToString().Replace("http:", "https:"))
                : null;
            base.RequestStartup(container, pipelines, context);
        }

```

## tl;dr?

You should end up with a fragment that resembles this:

```
<Fragment>
    <Binary Id="certBinary" SourceFile=".\IRCool.org.pfx"/>
		<Directory Id="TARGETDIR" Name="SourceDir">
			<Directory Id="IISMain" Name='inetpub'>
				<Directory Id="PubFolderName" Name="PubFolderName">
					<Component Id='WebsiteConfig' Guid='{YOURGUIDHERE}' Win64="yes">
						<iis:Certificate Id="cert" BinaryKey="certBinary" Name="IRCool.org" StoreLocation="localMachine" StoreName="personal" PFXPassword="mypasswordisawesome" Request="no" />
						<iis:WebSite Id='IRCool' Description='IRCool' Directory='PubFolderName' StartOnInstall='yes' ConfigureIfExists='yes' AutoStart='yes'>
									  <iis:WebAddress Id='SecIRCool' Port='443' Header='IRCool' Secure='yes' />
									  <iis:WebAddress Id='IRCool' Port='80' Header='IRCool' />
									  <iis:WebApplication Id='IRCoolApp' WebAppPool='IRCoolAppPool' Name='IRCool' />
									  <iis:CertificateRef Id='cert' />
									</iis:WebSite>
									<iis:WebAppPool Id='IRCoolAppPool' Identity="localSystem" RecycleMinutes="0" IdleTimeout="0" ManagedPipelineMode='Integrated' ManagedRuntimeVersion='v4.0' Name='IRCool' />
					</Component>
				</Directory>
			</Directory>
        </Directory>
	<Fragment>

```
